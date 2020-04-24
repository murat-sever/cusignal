#!/bin/bash
CONDA_PACKAGE_PATH=$(python -c 'import site; print(site.getsitepackages()[0])')
# Create symbolic links for SoapySDR to the Conda environment and see it
SOAPY_INSTALL_DIR="/usr/lib/python3/dist-packages"
SOAPY_FILE_NAMES="_SoapySDR.so SoapySDR.py"
for file_name in ${SOAPY_FILE_NAMES}; do
    src_file="${SOAPY_INSTALL_DIR}/${file_name}"
    if [[ -f ${src_file} ]]; then
        ln -s ${src_file} ${CONDA_PACKAGE_PATH}/${file_name}
        if [[ $? -eq 0 ]] ; then
            echo "Successfully created symbolic link:"
            echo "  ${src_file} -> "
            echo "  ${CONDA_PACKAGE_PATH}/${file_name}"
        fi
    else
        echo "Source file does not exist: ${src_file}"
        echo "Make sure SoapySDR drivers are properly installed."
    fi
done
export LD_LIBRARY_PATH=${SOAPY_INSTALL_DIR}
