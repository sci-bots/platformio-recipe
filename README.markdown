Conda recipe to build [`platformio`][1] package.

**Note** Windows build only.

Build
=====

Install `conda-build`:

    conda install conda-build

Build recipe:

    conda build .


Install
=======

The [Windows 32-bit build][2] may be installed from the
[`wheeler-microfluidics`][3] channel using:

    conda install -c conda-forge -c wheeler-microfluidics platformio

**Note** The `conda-forge` channel must be included in the install command to
provide the `bottle` Conda package.


[1]: http://platformio.org/
[2]: https://anaconda.org/wheeler-microfluidics/platformio
[3]: https://anaconda.org/wheeler-microfluidics
