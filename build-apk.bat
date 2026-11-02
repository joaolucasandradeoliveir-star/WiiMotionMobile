@echo off
setlocal
where gradle >nul 2>nul
if errorlevel 1 (
  echo Gradle nao foi encontrado no PATH.
  echo Abra a pasta no Android Studio e use Build ^> Build Bundle(s) / APK(s) ^> Build APK(s).
  pause
  exit /b 1
)
gradle :app:assembleDebug
if errorlevel 1 exit /b 1
echo.
echo APK gerado em: app\build\outputs\apk\debug\app-debug.apk
pause
