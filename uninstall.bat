@echo off
setlocal

set "REPO=https://raw.githubusercontent.com/JevonThompsonx/fineprint-deploy/main"
set "TEMP_DIR=%temp%\fineprint-deploy"

mkdir "%TEMP_DIR%" 2>nul

echo Downloading FinePrint...
powershell -command "Invoke-WebRequest -Uri '%REPO%/fp1144.exe' -OutFile '%TEMP_DIR%\fp1144.exe'"

echo Downloading pdfFactory...
powershell -command "Invoke-WebRequest -Uri '%REPO%/pdf844std.exe' -OutFile '%TEMP_DIR%\pdf844std.exe'"

echo Extracting FinePrint...
"C:\Program Files\7-Zip\7z.exe" x "%TEMP_DIR%\fp1144.exe" -o"%TEMP_DIR%\fp" -y >nul

echo Extracting pdfFactory...
"C:\Program Files\7-Zip\7z.exe" x "%TEMP_DIR%\pdf844std.exe" -o"%TEMP_DIR%\pdf" -y >nul

echo Uninstalling FinePrint...
net stop spooler >nul 2>&1
"%TEMP_DIR%\fp\setup-x64.exe" /uninstall /quiet /force
net start spooler >nul 2>&1

echo Uninstalling pdfFactory...
net stop spooler >nul 2>&1
"%TEMP_DIR%\pdf\setup-x64.exe" /uninstall /quiet /force
net start spooler >nul 2>&1

echo Cleaning up...
rd /s /q "%TEMP_DIR%"

echo Done.
