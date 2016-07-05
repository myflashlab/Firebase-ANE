@echo off
cd..
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApp.bat

echo Generate keystore from .p12 file
:: http://docs.oracle.com/javase/6/docs/technotes/tools/solaris/keytool.html
call keytool -importkeystore -srckeystore "%AND_CERT_FILE%" -destkeystore "%AND_KEY_STORE%" -srcstoretype pkcs12 -srcstorepass %AND_CERT_PASS% -deststorepass %AND_KEY_STORE_PASS%
pause