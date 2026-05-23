@echo off
setlocal

echo ========================================
echo Rust fuzzing scaffold check
echo ========================================

set "REPO_ROOT=%~dp0.."
pushd "%REPO_ROOT%"

if not exist Cargo.toml (
    echo Skipping Rust fuzzing: no Cargo.toml found.
    popd
    exit /b 0
)

echo Rust workspace detected.
echo Fuzzing is scaffolded but no Rust fuzz target is required yet.
echo Future setup:
echo   cargo install cargo-fuzz --locked
echo   cargo fuzz init
echo   cargo fuzz run target_name

popd
exit /b 0