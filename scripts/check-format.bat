@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Checking C++ formatting
echo ========================================

set "REPO_ROOT=%~dp0.."
pushd "%REPO_ROOT%"

set "FAILED=0"

for /r %%f in (*.cpp *.hpp *.h *.cxx *.hxx *.cc) do (
    echo %%f | findstr /i "\\out\\ \\build\\ \\.git\\ \\docs\\generated\\ \\third_party\\conan\\" >nul
    if errorlevel 1 (
        clang-format --dry-run --Werror "%%f"
        if errorlevel 1 (
            set "FAILED=1"
        )
    )
)

if "%FAILED%"=="1" (
    echo.
    echo Formatting check failed.
    echo Run scripts\format.bat locally.
    popd
    exit /b 1
)

echo.
echo C++ formatting check passed.

popd
exit /b 0