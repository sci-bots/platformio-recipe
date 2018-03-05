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
echo set PLATFORMIO_LIB_EXTRA_DIRS=%%CONDA_PREFIX%%\share\platformio\include>> %ACTIVATE_DIR%\platformio-env-lib_extra_dirs.bat
REM Write script to set `PLATFORMIO_HOME_DIR` environment variable
echo @echo off> %ACTIVATE_DIR%\platformio-env-home_dir.bat
echo set PLATFORMIO_HOME_DIR=%%CONDA_PREFIX%%\share\platformio>> %ACTIVATE_DIR%\platformio-env-home_dir.bat

REM Write script to unset `PLATFORMIO_LIB_EXTRA_DIRS` environment variable
echo @echo off> %DEACTIVATE_DIR%\platformio-env-lib_extra_dirs.bat
echo set PLATFORMIO_LIB_EXTRA_DIRS=>> %DEACTIVATE_DIR%\platformio-env-lib_extra_dirs.bat
REM Write script to unset `PLATFORMIO_HOME_DIR` environment variable
echo @echo off> %DEACTIVATE_DIR%\platformio-env-home_dir.bat
echo set PLATFORMIO_HOME_DIR=>> %DEACTIVATE_DIR%\platformio-env-home_dir.bat

%PYTHON% setup.py install --single-version-externally-managed --record record.txt
if errorlevel 1 exit 1
