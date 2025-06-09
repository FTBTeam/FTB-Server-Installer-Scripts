@echo off
setlocal enabledelayedexpansion
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "packId=REPLACE_ME"
set "packVersion=REPLACE_ME"

set "downloadUrl=https://github.com/FTBTeam/FTB-Server-Installer/releases/latest/download/ftb-server-"

IF "%packId%"=="" (
    echo %ESC%[31mMissing pack id, if you renamed this bat file undo your changes otherwise contact FTB%ESC%[0m
    exit /b 1
)
IF "%packId%"=="REPLACE_ME" (
     echo %ESC%[31mInvalid pack id "%packVersion%", please contact FTB%ESC%[0m
    exit /b 1
)
IF "%packVersion%"=="" (
    echo %ESC%[31mMissing pack version, if you renamed this bat file undo your changes otherwise contact FTB%ESC%[0m
    exit /b 1
)
IF "%packVersion%"=="REPLACE_ME" (
    echo %ESC%[31mInvalid pack version "%packVersion%", please contact FTB%ESC%[0m
    exit /b 1
)

echo PackId: %packId%
echo PackVersion: %packVersion%

reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PROCESSOR_ARCHITECTURE >nul 2>&1
for /f "tokens=3" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PROCESSOR_ARCHITECTURE 2^>nul') do set "sysArch=%%A"


set "arch=amd64"
if /i "%sysArch%"=="ARM64" (
   set "arch=arm64"
)

set "completeUrl=%downloadUrl%windows-%arch%.exe"

echo Downloading FTB Server Installer from: %completeUrl%

curl -L -o serverinstaller_%packId%_%packVersion%.exe %completeUrl%

IF %ERRORLEVEL% NEQ 0 (
    echo %ESC%[31mFailed to download the file. Please check the URL or your internet connection.%ESC%[0m
    pause
    exit /b %ERRORLEVEL%
)

echo %ESC%[32mDownloaded FTB Server Installer to: %~dp0serverinstaller_%packId%_%packVersion%.exe%ESC%[0m
echo %ESC%[36mYou can now run the installer using the command: .\serverinstaller_%packId%_%packVersion%.exe%ESC%[0m