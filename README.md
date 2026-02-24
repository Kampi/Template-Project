# ${PROJECT_NAME}

[![License](https://img.shields.io/badge/License-GPL%203.0-blue.svg)](https://opensource.org/license/gpl-3-0/)
[![PCB](${GIT_URL}/actions/workflows/pcb.yaml/badge.svg)](${GIT_URL}/actions/workflows/pcb.yaml)
[![Documentation](https://img.shields.io/badge/Documentation-HTML-007ec6?longCache=true&style=flat&logo=asciidoctor&colorA=555555)](https://${GIT_USER}.github.io/${PROJECT_NAME}/)

## Table of Contents

- [${PROJECT_NAME}](#${PROJECT_NAME_ANCHOR})
  - [Table of Contents](#table-of-contents)
  - [About](#about)
  - [Directory Breakdown](#directory-breakdown)
  - [Purchasing](#purchasing)
  - [Ressources](#ressources)
  - [Maintainer](#maintainer)

## About

...

It is built with **KiCad** and integrates a full **CI/CD pipeline** using **KiBot**, ensuring reproducible outputs for documentation, manufacturing, and releases.

Key features:

- Open-source hardware design
- Automated generation of Gerber, BoM, and documentation via KiBot
- Workflow stages (DRAFT → PRELIMINARY → CHECKED → RELEASED) for structured releases
- Clear documentation and changelog to track progress
- Designed with collaboration and transparency in mind

Please check the [wiki](${GIT_URL}/wiki) for more information about the project.

You can also view this project on [CADLAB.io](...).

## Directory Breakdown

- **`.github`**: GitHub related files
- **`.gitignore`**: Ignored files list
- **`${BOARD_NAME_ANCHOR}`**: KiCad project for the PCB
- **`production`**: Manufacturing outputs (Gerbers, documentation, etc.)
- **`CHANGELOG.md`**: Version history
- **`LICENSE`**: Project license
- **`README.md`**: Project overview

## Purchasing

TBD

## Ressources

- [KiBot Template](https://github.com/nguyen-v/KDT_Hierarchical_KiBot)
- [KiCad Project Template](https://github.com/Kampi/Template-Project)

## Maintainer

- [${DESIGNER}](mailto:${EMAIL})
