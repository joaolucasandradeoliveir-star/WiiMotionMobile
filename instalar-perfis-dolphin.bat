@echo off
setlocal
set "DEST=%USERPROFILE%\Documents\Dolphin Emulator\Config\Profiles\Wiimote"
if not exist "%DEST%" mkdir "%DEST%"
copy /Y "%~dp0profiles\WiiMote-Celular.ini" "%DEST%\WiiMote-Celular.ini" >nul
copy /Y "%~dp0profiles\WiiMote-Celular-Nunchuk.ini" "%DEST%\WiiMote-Celular-Nunchuk.ini" >nul
echo.
echo Perfis copiados para:
echo %DEST%
echo.
echo No Dolphin, abra Controllers ^> Wii Remote 1 ^> Configure e carregue
 echo o perfil WiiMote-Celular ou WiiMote-Celular-Nunchuk.
pause
