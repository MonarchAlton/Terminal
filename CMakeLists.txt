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

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(BUILD_TESTS "Build Tests" OFF)
option(WARNINGS_AS_ERRORS "Treat compiler warnings as errors" ON)
option(ENABLE_SECURITY_HARDENING "Enable security-oriented compiler flags" ON)

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

        $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:
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

add_subdirectory(src/pricing_engine)
add_subdirectory(src/risk_engine)
add_subdirectory(src/dashboard)

if(BUILD_TESTS)
	enable_testing()
	add_subdirectory(tests)
endif()