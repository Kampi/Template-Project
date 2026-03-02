# Template Variables

The `init-project.sh` script replaces the following placeholders automatically when a new project is initialized from this template.

## File Variables (`${…}`)

Replaced via `sed` in all text files (`.md`, `.yaml`, `.adoc`, shell scripts, etc.).

| Variable | Description | Example |
| --- | --- | --- |
| `${PROJECT_NAME}` | Human-readable project name | `My Sensor Board` |
| `${BOARD_NAME}` | KiCad board name (used for file naming) | `MySensorBoard` |
| `${DESIGNER}` | Full name of the hardware designer | `Jane Doe` |
| `${EMAIL}` | Designer e-mail address | `jane@example.com` |
| `${COMPANY}` | Company / organisation name (optional) | `ACME Corp` |
| `${REVISION}` | Initial revision string | `1.0.0` |
| `${RELEASE_DATE}` | Human-readable release date | `02-Mar-2026` |
| `${RELEASE_DATE_NUM}` | ISO release date | `2026-03-02` |
| `${GIT_URL}` | Full GitHub repository URL | `https://github.com/user/repo` |
| `${GIT_USER}` | GitHub username, parsed from `${GIT_URL}` | `user` |
| `${GIT_REPO}` | GitHub repository name, parsed from `${GIT_URL}` | `repo` |
| `${MASTER_BRANCH}` | Default Git branch name | `main` |
| `${PROJECT_NAME_ANCHOR}` | Lowercase, hyphenated project name for Markdown anchors | `my-sensor-board` |
| `${BOARD_NAME_ANCHOR}` | Lowercase, hyphenated board name — also used as hardware directory name | `mysensorboard` |

## KiCad Text Variables

Written into the `.kicad_pro` JSON under `text_variables`. Available inside KiCad schematics and PCB layouts via `${VARIABLE}` in text fields and title blocks.

| Variable | Description |
| --- | --- |
| `PROJECT_NAME` | Human-readable project name |
| `BOARD_NAME` | KiCad board name |
| `DESIGNER` | Full name of the hardware designer |
| `COMPANY` | Company / organisation name |
| `RELEASE_DATE` | Human-readable release date (`DD-Mon-YYYY`) |
| `RELEASE_DATE_NUM` | ISO release date (`YYYY-MM-DD`) |
| `REVISION` | Initial revision string |

## KiBot Variables (`kibot_yaml/kibot_main.yaml`)

| Variable | Set from |
| --- | --- |
| `PROJECT_NAME` | `${PROJECT_NAME}` |
| `BOARD_NAME` | `${BOARD_NAME}` |
| `COMPANY` | `${COMPANY}` |
| `DESIGNER` | `${DESIGNER}` |
| `GIT_URL` | `${GIT_URL}` |
