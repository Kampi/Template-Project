---
name: create-release
description: Create a hardware release x.y.z of this KiCad project. Runs ERC/DRC, switches the KiBot variant to CHECKED, pushes "Prepare Release x.y.z" to the development branch, waits for the KiBot pipeline, merges into main/master, creates and pushes the tag x.y.z and waits for the release pipeline. Use when the user asks to prepare, create or publish a release.
---

# Create Release

Releases are built by the `PCB Data` workflow ([pcb.yaml](../../workflows/pcb.yaml)).
A push to the development branch builds the outputs with the variant from `kibot_variant`,
a push of a SemVer tag (`x.y.z`) builds the `RELEASED` variant, updates the `CHANGELOG.md`
and creates the GitHub release.

## Prerequisites

- `git`, `kicad-cli` (KiCad 9 or newer) and an authenticated GitHub CLI (`gh auth status`).
- Clean working tree (`git status --porcelain` is empty). Otherwise stop and ask the user.
- Current branch is the development branch (e.g. `x.y.z_Dev` or `dev`).

## Gather parameters

Read the values from the repository instead of guessing. The template placeholders
(see `VARIABLES.md`) are replaced by `init-project.sh`, so always read the
current values at runtime and never hardcode names like `hardware`, `Template` or `main`:

| Parameter     | Source                                                                                       |
| ------------- | -------------------------------------------------------------------------------------------- |
| `VERSION`     | From the branch name `x.y.z_Dev`. Otherwise ask the user. Must match `^[0-9]+\.[0-9]+\.[0-9]+$` |
| `DEV_BRANCH`  | `git branch --show-current`                                                                  |
| `MAIN_BRANCH` | `master_branch` in `pcb.yaml`                                                                |
| `INPUT_DIR`   | `kibot_input_dir` in `pcb.yaml` (directory with the KiCad project)                           |
| `BOARD`       | `kicad_board` in `pcb.yaml` (file name of the `.kicad_pcb` / `.kicad_sch` / `.kicad_pro`)    |

If a value still contains an unreplaced placeholder (`${...}`), fall back to:

- `MAIN_BRANCH`: whichever of `origin/main` / `origin/master` exists.
- `INPUT_DIR`: the directory that contains the `.kicad_pro` file (`git ls-files '*.kicad_pro'`).
- `BOARD`: the base name of that `.kicad_pro` file.

Verify that `INPUT_DIR/BOARD.kicad_sch` and `INPUT_DIR/BOARD.kicad_pcb` exist before continuing.

Abort if the tag already exists (`git ls-remote --tags origin "refs/tags/$VERSION"` returns a result)
or if `INPUT_DIR/CHANGELOG.md` has no entries in the `## [Unreleased]` section.

Show the user a short summary (version, development branch, main branch) and get a confirmation
before anything is pushed.

## Steps

Stop at the first failing step, report the error and do not continue.

### 1. Run ERC and DRC

```bash
cd "$INPUT_DIR"
mkdir -p /tmp/release-check
kicad-cli sch erc --severity-error --exit-code-violations \
    -o /tmp/release-check/erc.rpt "$BOARD.kicad_sch"
kicad-cli pcb drc --severity-error --schematic-parity --exit-code-violations \
    -o /tmp/release-check/drc.rpt "$BOARD.kicad_pcb"
cd -
```

A non-zero exit code means violations. Summarize the errors from the reports for the user and abort.
Warnings do not block the release.

### 2. Set the variant to CHECKED

- In `.github/workflows/pcb.yaml` set `  kibot_variant: <OLD>` to `  kibot_variant: CHECKED`.
- In `INPUT_DIR/BOARD.kicad_pro` set the text variable `"PCB_VARIANT"` to `"CHECKED"` (if present).

Only change these values, keep the rest of the files untouched.

### 3. Commit and push to the development branch

```bash
git pull --rebase origin "$DEV_BRANCH"
git add .github/workflows/pcb.yaml "$INPUT_DIR/$BOARD.kicad_pro"
git commit -m "Prepare Release $VERSION"
git push origin "$DEV_BRANCH"
```

### 4. Wait for the KiBot pipeline

```bash
SHA=$(git rev-parse HEAD)
# The run may need a few seconds to show up, retry until it exists
RUN_ID=$(gh run list --workflow pcb.yaml --branch "$DEV_BRANCH" --commit "$SHA" \
    --json databaseId --jq '.[0].databaseId')
gh run watch "$RUN_ID" --exit-status
```

On failure show the failed jobs (`gh run view "$RUN_ID" --log-failed | tail -n 100`) and abort.

### 5. Switch to the main branch and pull the result

The pipeline pushes the generated outputs back to the development branch, so pull them first.

```bash
git pull --rebase origin "$DEV_BRANCH"
git checkout "$MAIN_BRANCH"
git pull origin "$MAIN_BRANCH"
git pull --no-rebase --no-edit origin "$DEV_BRANCH"
```

On merge conflicts stop and hand over to the user.

### 6. Create the tag

```bash
git tag "$VERSION"
```

### 7. Push the main branch and the tag

```bash
git push --atomic origin "$MAIN_BRANCH" "$VERSION"
```

### 8. Wait for the release pipeline

```bash
SHA=$(git rev-parse HEAD)
# Wait for all PCB runs of this commit (branch push and tag push)
gh run list --workflow pcb.yaml --commit "$SHA" --json databaseId,headBranch,status
gh run watch <RUN_ID> --exit-status   # for each listed run, the tag run is mandatory
```

On success report the release URL (`gh release view "$VERSION" --json url --jq .url`).
On failure show the failed log and abort. Never delete or move the tag without asking the user.
