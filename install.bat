@echo off
setlocal

set "REPO=https://raw.githubusercontent.com/JevonThompsonx/fineprint-deploy/main"
set "TEMP_DIR=%temp%\fineprint-deploy"

mkdir "%TEMP_DIR%" 2>nul

echo Downloading FinePrint...
powershell -command "Invoke-WebRequest -Uri '%REPO%/fp/setup-x64.exe' -OutFile '%TEMP_DIR%\fp-setup.exe'"

echo Downloading pdfFactory...
powershell -command "Invoke-WebRequest -Uri '%REPO%/pdffactory/setup-x64.exe' -OutFile '%TEMP_DIR%\pdf-setup.exe'"

echo Installing FinePrint...
"%TEMP_DIR%\fp-setup.exe" /install /quiet

echo Installing pdfFactory...
"%TEMP_DIR%\pdf-setup.exe" /install /quiet

echo Cleaning up...
rd /s /q "%TEMP_DIR%"

echo Done.
