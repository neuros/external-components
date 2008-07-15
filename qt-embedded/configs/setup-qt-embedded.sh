#!/bin/sh
if [ -d ${TOOLCHAIN}/Qt ]; then


	echo "Qt-Embedded TOOLCHAIN ALREADY BUILT."
	echo "-------------------------------"
	echo "Please Remove ${TOOLCHAIN}/Qt*"
	echo "inoder to force rebuiding of   "
	echo " qtopia by running make cleanall"
	echo "------------------------------"


else

	make rebuild

fi
