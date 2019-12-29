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
if [%drive%] == [] goto USBERROR
SET dest= %drive%
setlocal enabledelayedexpansion
FOR /F "tokens=2 delims=:" %%G IN ('netsh wlan show profiles') DO (
  SET _temp=%%G
  SET wifiname=!_temp:~1!
  netsh wlan show profile "!wifiname!" key=clear>> %dest%:/passwords.txt
)
endlocal
goto end
:error
echo Run As Administrator
pause
goto terminate
:USBERROR
echo No USB Found?
echo Please Plug In A USB.....
pause
goto terminate
:end
echo Done Successfully!!!
echo Passwords saved in USB at %dest%:\passwords.txt
echo See the content of %dest%:\passwords.txt
pause
type %dest%:\passwords.txt
pause
:terminate