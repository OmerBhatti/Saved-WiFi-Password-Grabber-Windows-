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
setlocal enabledelayedexpansion
FOR /F "tokens=2 delims=:" %%G IN ('netsh wlan show profiles') DO (
  SET _temp=%%G
  SET wifiname=!_temp:~1!
  netsh wlan show profile "!wifiname!" key=clear>> %dest%/passwords.txt
)
endlocal
goto end
:error
echo Run As Administrator
pause
goto term
:end
echo Done Successfully!!!
echo Passwords saved at %dest%\passwords.txt
echo See the content of %dest%\passwords.txt
pause
type %dest%\passwords.txt
pause
:term