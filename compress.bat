@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Usage: compress.bat [city]
    exit /b 1
)

set "city=%~1"
set "baseDir=.\data\simulation\populations"
set "directory=%baseDir%\%city%"

if not exist "%directory%" (
    echo "%directory%" not found, trying current directory...
    set "baseDir=."
    set "directory=%baseDir%\%city%"
    if not exist "%directory%" (
        echo "%directory%" not found.
        exit /b 1
    )
)

set /a index=0

pushd "%directory%"
set /a count=0
set files=

for %%f in (fragment-*.json) do (
    set /a count+=1
    set files=!files! "%%f"

    if !count! EQU 4 (
        popd
        tar -czf "%baseDir%\%city%\fragment-!index!.tar.gz" -C "%directory%" !files!
        pushd "%directory%"
        set files=
        set /a count=0
        set /a index+=1
    )
)

if !count! GTR 0 (
    popd
    tar -czf "%baseDir%\%city%\fragment-!index!.tar.gz" -C "%directory%" !files!
    pushd "%directory%"
)

popd

endlocal
