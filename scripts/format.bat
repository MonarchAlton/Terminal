@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Formatting project
echo ========================================

set "REPO_ROOT=%~dp0.."
pushd "%REPO_ROOT%"

echo.
echo Formatting C++ files...

for /r %%f in (*.cpp *.hpp *.h *.cxx *.hxx *.cc) do (
    echo %%f | findstr /i "\\out\\ \\build\\ \\.git\\ \\docs\\generated\\ \\third_party\\conan\\" >nul
    if errorlevel 1 (
        clang-format -i "%%f"
        if errorlevel 1 (
            echo clang-format failed on %%f
            popd
            exit /b 1
        )
    )
)

echo.
echo C++ formatting complete.

if exist Cargo.toml (
    echo.
    echo Formatting Rust files...
    cargo fmt --all
    if errorlevel 1 (
        echo cargo fmt failed.
        popd
        exit /b 1
    )
) else (
    echo.
    echo Skipping Rust formatting: no Cargo.toml found at repo root.
)

echo.
echo ========================================
echo Formatting complete
echo ========================================

popd
exit /b 0