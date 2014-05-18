#!/bin/bash

#
# Taken from https://gist.github.com/josephwecker/2884332
#
CURDIR="${BASH_SOURCE[0]}";RL="readlink";([[ `uname -s`=='Darwin' ]] || RL="$RL -f")
while([ -h "${CURDIR}" ]) do CURDIR=`$RL "${CURDIR}"`; done
N="/dev/null";pushd .>$N;cd `dirname ${CURDIR}`>$N;CURDIR=`pwd`;popd>$N

function symlink_py {
    ln -s `python -c 'import '${1}', os.path, sys; sys.stdout.write(os.path.dirname('${1}'.__file__))'` $CURDIR/zato_extra_paths
}

#rm -rf $CURDIR/bin
rm -rf $CURDIR/develop-eggs
rm -rf $CURDIR/downloads
rm -rf $CURDIR/eggs
#rm -rf $CURDIR/include
rm -rf $CURDIR/.installed.cfg
#rm -rf $CURDIR/lib
rm -rf $CURDIR/parts
rm -rf $CURDIR/zato_extra_paths

zypper -n install     git
zypper -n install     gcc-fortran
zypper -n install     gcc-c++
zypper -n install     libatlas3-devel
zypper -n install     blas-devel
zypper -n install     sqlite3-devel
zypper -n install     libevent-devel
zypper -n install     libgfortran3
zypper -n install     lapack-devel
zypper -n install     lapack
zypper -n install     libpqxx-devel
zypper -n install     libyaml-devel
zypper -n install     libxml2-devel
zypper -n install     libxslt-devel
zypper -n install     suitesparse-devel
zypper -n install     libopenssl-devel
zypper -n install     python-numpy
zypper -n install     python-scipy
zypper -n install     swig
zypper -n install     libuuid-devel
zypper -n install     uuid-runtime
zypper -n install     postgresql91-devel
zypper mr -d devel_languages_python
zypper -n install     python-m2crypto


mkdir $CURDIR/zato_extra_paths

symlink_py 'M2Crypto'
symlink_py 'numpy'
symlink_py 'scipy'


$CURDIR/bin/python bootstrap.py -v 1.7.0
$CURDIR/bin/buildout

echo
echo OK
