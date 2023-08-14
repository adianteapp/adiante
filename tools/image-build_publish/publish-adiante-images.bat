@echo off
echo =====================================================================================
echo.
echo.                       ADIANTE PATIENT - Build, publish images 
echo.
echo =====================================================================================
echo.
setlocal enabledelayedexpansion

set version=%1

if "%version%"=="" (
    echo No version parameter provided. Exiting...
    exit /b
)

echo.  1 Cleaning target directory
echo.
rd target /s /q
mkdir target
cd target

echo.  2 Checking out git repository tag: "%version%"
echo.
git clone --branch %version% --depth 1 https://github.com/lucialence/adiante
cd adiante


echo.  3 Create and send adiante-patient-backend image
echo.
cd adiante-backend
call docker build -t mandradeva/adiante:patient-backend-%version% .
call docker push mandradeva/adiante:patient-backend-%version%
echo --> End build and push Adiante patient backend image
cd ..

echo.  4 Create and send adiante-patient image
echo.
cd adiante-front-office
call docker build -t mandradeva/adiante:patient-%version% .
call docker push mandradeva/adiante:patient-%version%
echo --> End build and push Adiante patient image
cd ..

@echo on

