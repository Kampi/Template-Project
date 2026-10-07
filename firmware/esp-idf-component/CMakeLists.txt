# Library version (updated by the release pipeline)
set(${GIT_REPO_UPPER}_LIB_MAJOR 0)
set(${GIT_REPO_UPPER}_LIB_MINOR 1)
set(${GIT_REPO_UPPER}_LIB_BUILD 0)

idf_component_register(SRCS "src/${GIT_REPO_LOWER}.c"
                       INCLUDE_DIRS "include")

target_compile_definitions(${COMPONENT_LIB} PRIVATE
                           ${GIT_REPO_UPPER}_LIB_MAJOR=${${GIT_REPO_UPPER}_LIB_MAJOR}
                           ${GIT_REPO_UPPER}_LIB_MINOR=${${GIT_REPO_UPPER}_LIB_MINOR}
                           ${GIT_REPO_UPPER}_LIB_BUILD=${${GIT_REPO_UPPER}_LIB_BUILD})
