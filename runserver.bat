@echo off

rem goto "%1"
rem goto :end

if "%input%"=="zredc" goto zredc
if "%input%"=="rfedc" goto rfedc

:zredc
set PRODUCT=zredc
python manage.py runserver 0.0.0.0:8000
goto end
endlocal

:rfedc
set PRODUCT=rfedc
python manage.py runserver 0.0.0.0:8000
goto end
endlocal

:end