@echo off
setlocal

echo ========================================
echo Generating Doxygen documentation
echo ========================================

set "REPO_ROOT=%~dp0.."
pushd "%REPO_ROOT%"

doxygen Doxyfile
if errorlevel 1 (
    echo Doxygen documentation generation failed.
    popd
    exit /b 1
)

echo.
echo Documentation generated successfully.
echo Output: docs\generated\doxygen\html

popd
exit /b 0