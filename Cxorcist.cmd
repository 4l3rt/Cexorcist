@echo off
setlocal enableextensions

echo Deleting C:\Windows\Temp...
del /s /f /q C:\Windows\Temp\*.* >nul 2>&1
for /d %%x in (C:\Windows\Temp\*) do rd /s /q "%%x" >nul 2>&1

echo Deleting %TEMP%...
del /s /f /q "%TEMP%\*.*" >nul 2>&1
for /d %%x in ("%TEMP%\*") do rd /s /q "%%x" >nul 2>&1

echo Deleting C:\Windows\Prefetch...
del /s /f /q C:\Windows\Prefetch\*.* >nul 2>&1
for /d %%x in (C:\Windows\Prefetch\*) do rd /s /q "%%x" >nul 2>&1

reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches" >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Configuring Disk Cleanup preset...
    cleanmgr /sageset:1337
)

echo Deleting .exe/.msi/ .7z from Downloads...
for %%X in (exe msi rar 7z) do (
    del /s /f /q "%USERPROFILE%\Downloads\*.%%X" >nul 2>&1
)

echo Desktop .exe/.msi/ .7z from Downloads...
for %%X in (exe msi rar 7z) do (
    del /s /f /q "%USERPROFILE%\Desktop\*.%%X" >nul 2>&1
)

echo.
echo === ALL DONE. Check manually if you want deeper cleanup ===
pause
