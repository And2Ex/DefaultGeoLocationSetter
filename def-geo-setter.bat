@echo off
chcp 65001 > nul

echo Setting default coordinates in settings...
timeout /t 1 /nobreak > nul
start ms-settings:privacy-location

set /p dummyVar=Press Enter to continue...

REM Registry keys to modify the value
for /f "tokens=2 delims= " %%a in ('whoami /user /nh') do set "sid=%%a"
set "key=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc\Migrated\UserStore\%sid%"
set "value=DefaultGeoposition"

REM Get the current value from the registry
reg query "%key%" /v "%value%" > "temp.txt"
for /f "tokens=2*" %%a in ('reg query "%key%" /v "%value%" ^| find "%value%"') do set "regvalue=%%b"
if not defined regvalue (
    echo Value %value% not found. Perhaps no default location is set in Windows settings.
    exit /b
)

REM Prompt user to enter filename for storing value writing commands
set /p filename="Enter filename: "

REM Write command to write value to a new file
(
echo @echo off
echo chcp 65001 ^> nul
echo.
echo reg add "%key%" /v "%value%" /t REG_BINARY /d "%regvalue%" /f ^> nul
echo if %%errorlevel%% equ 0 ^(
echo     echo Location set successfully.
echo ^) else ^(
echo     echo Failed to set location.
echo     echo Perhaps you did not run the file as an administrator.
echo     echo Also, you need to have any default location already set in settings.
echo     echo.
echo ^)
echo.
echo sc stop lfsvc ^> nul 2^>^&1
echo sc start lfsvc ^> nul 2^>^&1
echo if %%ERRORLEVEL%% equ 0 ^(
echo   echo Location service restarted successfully.
echo ^) else ^(
echo   echo Error restarting location service.
echo   echo.
echo ^)
echo.
echo set "service=SplunkForwarder"
echo sc query "%%service%%" ^> nul 2^>^&1
echo if %%ERRORLEVEL%% equ 1060 ^( 
echo     echo Service %%service%% NOT FOUND. 
echo ^) else ^( 
echo     sc query "%%service%%" ^| find "STATE" ^| find "RUNNING" ^> nul 2^>^&1 
echo     if %%ERRORLEVEL%% equ 0 ^( 
echo         echo Service %%service%% is already running. 
echo         ping 127.0.0.1 -n 5 ^> nul
echo         exit
echo     ^) else ^( 
echo         sc start "%%service%%" ^> nul 2^>^&1 
echo         if %%ERRORLEVEL%% neq 0 ^( 
echo             echo Failed to start service %%service%%. 
echo         ^) else ^( 
echo             echo Forced start of service %%service%%. 
echo             ping 127.0.0.1 -n 5 ^> nul
echo             exit
echo         ^) 
echo     ^) 
echo ^)
echo.
echo echo.
echo echo Contact your administrator.
echo pause ^> nul
) > "%USERPROFILE%\Desktop\%filename%.bat"

REM Deleting the temporary file
del "temp.txt"

echo File %filename%.bat with current coordinates has been created on the desktop.
echo Run it as an administrator.

REM Wait for 5 seconds and close the window
ping 127.0.0.1 -n 5 > nul
exit
