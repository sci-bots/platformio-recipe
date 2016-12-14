REM Copy nanopb C source and headers to Arduino
set ACTIVATE_DIR="%PREFIX%"\etc\conda\activate.d
set DEACTIVATE_DIR="%PREFIX%"\etc\conda\deactivate.d
set SHARE_DIR="%PREFIX%"\share\platformio
setlocal enableextensions
md %ACTIVATE_DIR%
md %DEACTIVATE_DIR%
md %SHARE_DIR%
endlocal

REM Add file to platformio share directory to force the directory to be made.
type NUL> %SHARE_DIR%\.empty

REM Write script to set `PLATFORMIO_LIB_EXTRA_DIRS` environment variable
echo @echo off> %ACTIVATE_DIR%\platformio-env-lib_extra_dirs.bat
echo set PLATFORMIO_LIB_EXTRA_DIRS=%%CONDA_PREFIX%%\Library\include\Arduino>> %ACTIVATE_DIR%\platformio-env-lib_extra_dirs.bat
REM Write script to set `PLATFORMIO_HOME_DIR` environment variable
echo @echo off> %ACTIVATE_DIR%\platformio-env-home_dir.bat
echo set PLATFORMIO_HOME_DIR=%%CONDA_PREFIX%%\share\platformio>> %ACTIVATE_DIR%\platformio-env-home_dir.bat

REM Write script to unset `PLATFORMIO_LIB_EXTRA_DIRS` environment variable
echo @echo off> %DEACTIVATE_DIR%\platformio-env-lib_extra_dirs.bat
echo set PLATFORMIO_LIB_EXTRA_DIRS=>> %DEACTIVATE_DIR%\platformio-env-lib_extra_dirs.bat
REM Write script to unset `PLATFORMIO_HOME_DIR` environment variable
echo @echo off> %DEACTIVATE_DIR%\platformio-env-home_dir.bat
echo set PLATFORMIO_HOME_DIR=>> %DEACTIVATE_DIR%\platformio-env-home_dir.bat

REM Install platformio from pip
"%PYTHON%" -m pip install --no-cache "platformio==3.2.1"
if errorlevel 1 exit 1
:: Add more build steps here, if they are necessary.
