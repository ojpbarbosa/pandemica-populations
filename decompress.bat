@echo off
setlocal

if "%~1"=="" (
    echo Usage: decompress.bat [city]
    exit /b 1
)

set "city=%~1"
set "directory=.\data\simulation\populations\%city%"

if not exist "%directory%" (
    echo "%directory%" not found, trying "%city%"...
    set "directory=%city%"
    if not exist "%directory%" (
        echo Directory "%directory%" not found.
        exit /b 1
    )
)

for %%f in ("%directory%\*.tar.gz") do (
    tar -xzf "%%f" -C "%directory%"
)

endlocal
