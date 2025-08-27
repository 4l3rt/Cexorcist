@echo off
setlocal enableextensions
 
echo Stopping Windows Update service...
net stop wuauserv >nul 2>&1
net stop cryptSvc >nul 2>&1
net stop bits >nul 2>&1
net stop msiserver >nul 2>&1
 
echo Deleting C:\Windows\Temp...
del /s /f /q C:\Windows\Temp\*.* >nul 2>&1
for /d %%x in (C:\Windows\Temp\*) do rd /s /q "%%x" >nul 2>&1
 
echo Deleting %TEMP%...
del /s /f /q "%TEMP%\*.*" >nul 2>&1
for /d %%x in ("%TEMP%\*") do rd /s /q "%%x" >nul 2>&1
 
echo Deleting C:\Windows\Prefetch...
del /s /f /q C:\Windows\Prefetch\*.* >nul 2>&1
for /d %%x in (C:\Windows\Prefetch\*) do rd /s /q "%%x" >nul 2>&1
 
echo Deleting C:\Windows\SoftwareDistribution\Download...
del /s /f /q C:\Windows\SoftwareDistribution\Download\*.* >nul 2>&1
for /d %%x in (C:\Windows\SoftwareDistribution\Download\*) do rd /s /q "%%x" >nul 2>&1
 
echo Deleting .exe/.msi/.rar from Downloads...
for %%X in (exe msi rar 7z) do (
    del /s /f /q "%USERPROFILE%\Downloads\*.%%X" >nul 2>&1
)
 
echo Deleting .exe/.msi/.rar from Desktop...
for %%X in (exe msi rar 7z) do (
    del /s /f /q "%USERPROFILE%\Desktop\*.%%X" >nul 2>&1
)
 
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches" >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Configuring Disk Cleanup preset...
    cleanmgr /sageset:1337
)
 
echo.
echo Opening Disk Cleanup...
start cleanmgr
 
echo Starting Windows Update service...
net start wuauserv >nul 2>&1
net start cryptSvc >nul 2>&1
net start bits >nul 2>&1
net start msiserver >nul 2>&1
 
echo === ALL DONE. Check manually if you want deeper cleanup ===
pause
