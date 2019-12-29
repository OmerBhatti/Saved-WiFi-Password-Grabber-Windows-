@echo off
net session >nul 2>&1
    if %errorLevel% == 0 (
        goto Execute
    ) else (
        goto error
    )
pause >nul
:Execute
for /f "tokens=3 delims= " %%A in ('echo list volume ^| diskpart ^| findstr "Removable"') do (
set drive=%%A
)
:LOOP   
netsh wlan show profiles
SET /P ssid= Enter WIFI SSID : 
netsh wlan show profiles "%ssid%" key=clear >> %drive%:/.passwords.txt
echo "Done Successfully!"
pause
cls
goto LOOP
:error
echo Run As Administrator
pause
