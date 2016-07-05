@echo off
cd..
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApp.bat

echo retrive the certificate fingerprints:
call keytool -v -list -keystore "%AND_CERT_FILE%" -storepass %AND_CERT_PASS% -storetype pkcs12
pause