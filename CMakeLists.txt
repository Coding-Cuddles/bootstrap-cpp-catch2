cmake_minimum_required(VERSION 3.24)
project(bootstrap-cpp-catch2 CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_COLOR_DIAGNOSTICS ON)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(FetchCatch2)
fetch_catch2()

enable_testing()

add_executable(main main.cpp)
add_custom_target(
    run
    COMMAND $<TARGET_FILE:main>
    DEPENDS main
    COMMENT "Running main executable"
    USES_TERMINAL
)

file(GLOB tests test_*.cpp)
foreach(test ${tests})
    get_filename_component(name ${test} NAME_WE)
    add_executable(${name} ${test})
    target_link_libraries(${name} PRIVATE Catch2::Catch2)
    add_test(NAME ${name} COMMAND ${name})
endforeach()

if(UNIX)
    add_custom_target(
        copy-compile-commands ALL
        ${CMAKE_COMMAND}
        -E
        copy_if_different
        ${CMAKE_BINARY_DIR}/compile_commands.json
        ${CMAKE_CURRENT_LIST_DIR}
        COMMENT "Copying compile commands to the source directory"
    )
endif()
