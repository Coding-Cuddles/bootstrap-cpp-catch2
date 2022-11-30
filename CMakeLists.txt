cmake_minimum_required(VERSION 3.19)
project(bootstrap-cpp-catch2 CXX)
enable_testing()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(Catch2 REQUIRED)

add_executable(main main.cpp)

file(GLOB tests "${PROJECT_SOURCE_DIR}/test_*.cpp")
foreach(test ${tests})
    get_filename_component(name ${test} NAME_WE)
    add_executable(${name} ${test})
    add_test(${name} ${name})
    target_link_libraries(${name} PRIVATE Catch2::Catch2)
endforeach()

add_custom_target(
    copy-compile-commands ALL
    ${CMAKE_COMMAND} -E copy_if_different
    ${CMAKE_BINARY_DIR}/compile_commands.json
    ${CMAKE_CURRENT_LIST_DIR}
)
