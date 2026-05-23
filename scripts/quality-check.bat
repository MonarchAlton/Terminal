@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Running full project quality checks
echo ========================================

set "REPO_ROOT=%~dp0.."
pushd "%REPO_ROOT%"

echo.
echo Repository root:
echo %CD%

echo.
echo ========================================
echo C++: formatting check
echo ========================================
call scripts\check-format.bat
if errorlevel 1 (
    echo C++ formatting check failed.
    popd
    exit /b 1
)

if exist Cargo.toml (
    echo.
    echo ========================================
    echo Rust: formatting check
    echo ========================================
    cargo fmt --all --check
    if errorlevel 1 (
        echo Rust formatting check failed.
        popd
        exit /b 1
    )

    echo.
    echo ========================================
    echo Rust: clippy
    echo ========================================
    cargo clippy --all-targets --all-features -- -D warnings
    if errorlevel 1 (
        echo Rust clippy failed.
        popd
        exit /b 1
    )

    echo.
    echo ========================================
    echo Rust: tests
    echo ========================================
    cargo test --all-targets --all-features
    if errorlevel 1 (
        echo Rust tests failed.
        popd
        exit /b 1
    )
) else (
    echo.
    echo Skipping Rust checks: no Cargo.toml found at repo root.
)

echo.
echo ========================================
echo C++: CMake configure
echo ========================================
cmake --preset windows-clang-debug
if errorlevel 1 (
    echo CMake configure failed.
    popd
    exit /b 1
)

echo.
echo ========================================
echo C++: CMake build
echo ========================================
cmake --build --preset build-windows-clang-debug
if errorlevel 1 (
    echo CMake build failed.
    popd
    exit /b 1
)

echo.
echo ========================================
echo C++: AddressSanitizer configure
echo ========================================
cmake --preset windows-clang-asan
if errorlevel 1 (
    echo AddressSanitizer configure failed.
    popd
    exit /b 1
)

echo.
echo ========================================
echo C++: AddressSanitizer build
echo ========================================
cmake --build --preset build-windows-clang-asan
if errorlevel 1 (
    echo AddressSanitizer build failed.
    popd
    exit /b 1
)

echo.
echo ========================================
echo Fuzzing scaffold checks
echo ========================================
call scripts\fuzz-cpp.bat
if errorlevel 1 (
    echo C++ fuzz scaffold check failed.
    popd
    exit /b 1
)

call scripts\fuzz-rust.bat
if errorlevel 1 (
    echo Rust fuzz scaffold check failed.
    popd
    exit /b 1
)

echo.
echo ========================================
echo Quality checks passed
echo ========================================

popd
exit /b 0