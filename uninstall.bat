@echo off
setlocal

set "REPO=https://raw.githubusercontent.com/JevonThompsonx/fineprint-deploy/main"
set "TEMP_DIR=%temp%\fineprint-deploy"

mkdir "%TEMP_DIR%" 2>nul

:: Check for 7-Zip and install if needed
if not exist "C:\Program Files\7-Zip\7z.exe" (
    echo Installing 7-Zip...
    powershell -command "Invoke-WebRequest -Uri 'https://www.7-zip.org/a/7z2501-x64.exe' -OutFile '%TEMP_DIR%\7z.exe'"
    "%TEMP_DIR%\7z.exe" /S
    timeout /t 3 >nul
)

echo Downloading FinePrint...
powershell -command "Invoke-WebRequest -Uri '%REPO%/fp1144.exe' -OutFile '%TEMP_DIR%\fp1144.exe'"

echo Downloading pdfFactory Pro...
powershell -command "Invoke-WebRequest -Uri '%REPO%/pdf844pro.exe' -OutFile '%TEMP_DIR%\pdf844pro.exe'"

echo Extracting FinePrint...
"C:\Program Files\7-Zip\7z.exe" x "%TEMP_DIR%\fp1144.exe" -o"%TEMP_DIR%\fp" -y >nul

echo Extracting pdfFactory Pro...
"C:\Program Files\7-Zip\7z.exe" x "%TEMP_DIR%\pdf844pro.exe" -o"%TEMP_DIR%\pdf" -y >nul

echo Uninstalling FinePrint...
net stop spooler >nul 2>&1
"%TEMP_DIR%\fp\setup-x64.exe" /uninstall /quiet /force
net start spooler >nul 2>&1

echo Uninstalling pdfFactory Pro...
net stop spooler >nul 2>&1
"%TEMP_DIR%\pdf\setup-x64.exe" /uninstall /quiet /force
net start spooler >nul 2>&1

echo Cleaning up...
rd /s /q "%TEMP_DIR%"

echo Done.
