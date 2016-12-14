# Copy nanopb C source and headers to Arduino
ACTIVATE_DIR="${PREFIX}"/etc/conda/activate.d
DEACTIVATE_DIR="${PREFIX}"/etc/conda/deactivate.d
SHARE_DIR="${PREFIX}"/share/platformio
mkdir -p ${ACTIVATE_DIR}
mkdir -p ${DEACTIVATE_DIR}
mkdir -p ${SHARE_DIR}

# Add file to platformio share directory to force the directory to be made.
touch ${SHARE_DIR}/.empty

# Write script to set `PLATFORMIO_LIB_EXTRA_DIRS` environment variable
echo "#!/bin/sh"> ${ACTIVATE_DIR}/platformio-env-lib_extra_dirs.sh
echo export PLATFORMIO_LIB_EXTRA_DIRS=\${CONDA_PREFIX}/include/Arduino>> ${ACTIVATE_DIR}/platformio-env-lib_extra_dirs.sh
# Write script to set `PLATFORMIO_HOME_DIR` environment variable
echo "#!/bin/sh"> ${ACTIVATE_DIR}/platformio-env-home_dir.sh
echo export PLATFORMIO_HOME_DIR=\${CONDA_PREFIX}/share/platformio>> ${ACTIVATE_DIR}/platformio-env-home_dir.sh

# Write script to unset `PLATFORMIO_LIB_EXTRA_DIRS` environment variable
echo "#!/bin/sh"> ${DEACTIVATE_DIR}/platformio-env-lib_extra_dirs.sh
echo unset PLATFORMIO_LIB_EXTRA_DIRS>> ${DEACTIVATE_DIR}/platformio-env-lib_extra_dirs.sh
# Write script to unset `PLATFORMIO_HOME_DIR` environment variable
echo "#!/bin/sh"> ${DEACTIVATE_DIR}/platformio-env-home_dir.sh
echo unset PLATFORMIO_HOME_DIR>> ${DEACTIVATE_DIR}/platformio-env-home_dir.sh

# Install platformio from pip
"${PYTHON}" -m pip install --no-cache "platformio==3.1.0"
rc=$?; if [[ $rc != 0  ]]; then exit $rc; fi
