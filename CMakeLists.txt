cmake_minimum_required(VERSION 3.24)

project(
	Aegis
	VERSION 0.1.0
	DESCRIPTION "Fintech-style modular monolith"
	LANGUAGES CXX
)

if(MSVC)
    cmake_policy(SET CMP0091 NEW)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>DLL")
endif()

function(disable_clang_tidy_for_target target_name)
    set_target_properties(${target_name}
        PROPERTIES
            CXX_CLANG_TIDY ""
    )
endfunction()

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(BUILD_TESTS "Build Tests" ON)
option(WARNINGS_AS_ERRORS "Treat compiler warnings as errors" ON)
option(ENABLE_SECURITY_HARDENING "Enable security-oriented compiler flags" ON)

find_package(Catch2)
find_package(fmt REQUIRED)
find_package(spdlog REQUIRED)
find_package(nlohmann_json REQUIRED)
find_package(glfw3 REQUIRED)
find_package(glad REQUIRED)
find_package(glm REQUIRED)
find_package(volk REQUIRED)

add_library(project_options INTERFACE)

target_compile_options(project_options
    INTERFACE
        $<$<CXX_COMPILER_ID:MSVC>:
            /W4
            $<$<BOOL:${WARNINGS_AS_ERRORS}>:/WX>
            /permissive-
            /Zc:__cplusplus
            /Zc:preprocessor
            /EHsc
            /MP
            /utf-8
        >

        $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<BOOL:${ENABLE_SECURITY_HARDENING}>>:
            /sdl
            /guard:cf
        >

        $<$<CXX_COMPILER_ID:Clang>:
            -Wall
            -Wextra
            -Wpedantic
            -Wno-c++98-compat
            -Wno-c++98-compat-pedantic
            -Wno-c2y-extensions
            -Wno-unknown-warning-option
            $<$<BOOL:${WARNINGS_AS_ERRORS}>:-Werror>
        >

        $<$<CXX_COMPILER_ID:GNU>:
            -Wall
            -Wextra
            -Wpedantic
            $<$<BOOL:${WARNINGS_AS_ERRORS}>:-Werror>
        >
)

target_link_options(project_options
    INTERFACE
        $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<BOOL:${ENABLE_SECURITY_HARDENING}>>:
            /guard:cf
        >
)

add_subdirectory(src/shared)
add_subdirectory(src/pricing_engine)
add_subdirectory(src/risk_engine)
add_subdirectory(src/dashboard)

if(BUILD_TESTS)
	enable_testing()
	add_subdirectory(tests)
endif()