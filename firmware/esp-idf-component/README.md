# ${PROJECT_NAME}

[![License](https://img.shields.io/badge/License-${LICENSE_BADGE}.svg)](${LICENSE_LINK})
[![Build](${GIT_URL}/actions/workflows/fw-esp-component.yaml/badge.svg)](${GIT_URL}/actions/workflows/fw-esp-component.yaml)

## Table of Contents

- [${PROJECT_NAME}](#${PROJECT_NAME_ANCHOR})
  - [Table of Contents](#table-of-contents)
  - [About](#about)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Directory Breakdown](#directory-breakdown)
  - [Maintainer](#maintainer)

## About

...

ESP-IDF component for ESP-IDF v6.1 or later.

## Installation

Add the component to a project with the IDF Component Manager:

```sh
idf.py add-dependency "${GIT_USER}/${GIT_REPO}"
```

## Usage

```c
#include <${GIT_REPO_LOWER}.h>

void app_main(void)
{
    ESP_ERROR_CHECK(${GIT_REPO_LOWER}_init());
}
```

The directory [examples](examples) contains complete projects. Build an example with:

```sh
cd examples/basic
idf.py set-target esp32
idf.py build
```

## Directory Breakdown

- **`.github`**: GitHub related files
- **`examples`**: Example projects for the component
- **`include`**: Public header files
- **`src`**: Source files
- **`scripts`**: Additional scripts for CI/CD etc.
- **`CHANGELOG.md`**: Changes of the component
- **`CMakeLists.txt`**: Build configuration of the component
- **`idf_component.yml`**: Manifest for the ESP Component Registry
- **`LICENSE`**: Project license
- **`README.md`**: Project overview

## Maintainer

- [${DESIGNER}](mailto:${EMAIL})
