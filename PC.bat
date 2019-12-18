@echo off
net session >nul 2>&1
    if %errorLevel% == 0 (
        goto Execute
    ) else (
        goto error
    )
pause >nul
:Execute
SET /P dest= Enter Drive (C:,D:,E: etc) :
:LOOP
netsh wlan show profiles
SET /P ssid= Enter WIFI SSID : 
netsh wlan show profiles "%ssid%" key=clear >> %dest%/Passwords.txt
echo "Done Successfully!"
pause
cls
goto LOOP
:error
echo Administrator Permission Required......
pause
