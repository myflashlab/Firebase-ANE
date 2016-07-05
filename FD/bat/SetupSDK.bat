:: Set working dir
cd %~dp0 & cd ..

:user_configuration

:: Static path to Flex SDK
set FLEX_SDK=C:\flex_sdk_4.6_air_sdk_22-153

:: Path to Java SDK
set JAVA_SDK=C:\Program Files (x86)\Java\jdk1.7.0_04

:: Use FD supplied SDK path if executed from FD
if exist "%FD_CUR_SDK%" set FLEX_SDK=%FD_CUR_SDK%

set AUTO_INSTALL_IOS=yes

:: Path to Android SDK
::set ANDROID_SDK=C:\Program Files (x86)\FlashDevelop\Tools\android
set ANDROID_SDK=D:\android

:validation
if not exist "%FLEX_SDK%\bin" goto flexsdk
if not exist "%ANDROID_SDK%\platform-tools" goto androidsdk
goto succeed

:flexsdk
echo.
echo ERROR: incorrect path to Flex SDK in 'bat\SetupSDK.bat'
echo.
echo Looking for: %FLEX_SDK%\bin
echo.
if %PAUSE_ERRORS%==1 pause
exit

:androidsdk
echo.
echo ERROR: incorrect path to Android SDK in 'bat\SetupSDK.bat'
echo.
echo Looking for: %ANDROID_SDK%\platform-tools
echo.
if %PAUSE_ERRORS%==1 pause
exit

:succeed
set PATH=%FLEX_SDK%\bin;%PATH%
set PATH=%PATH%;%ANDROID_SDK%\platform-tools
set PATH=%PATH%;%JAVA_SDK%\bin