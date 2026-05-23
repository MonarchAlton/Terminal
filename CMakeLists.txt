cmake_minimum_required(VERSION 3.24)

project(
	Aegis
	VERSION 0.1.0
	DESCRIPTION "Fintech-style modular monolith"
	LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(BUILD_TESTS "Build Tests" OFF)

add_subdirectory(src/pricing-engine)
add_subdirectory(src/risk-engine)
add_subdirectory(src/dashboard)

if(BUILD_TESTS)
	enable_testing()
	add_subdirectory(tests)
endif()