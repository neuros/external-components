##############################################################################
# Description: Makefile for Zydas chip based firmware installation
# 
# Author:  Frank Xue
# version: 1.0
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=1.4
TARCHIVE=zd1211-firmware-${TVER}.tar.bz2
TURL=http://downloads.sourceforge.net/zd1211/${TARCHIVE}
TDISTS=$(PRJROOT)/external-components/downloads
TDIR=_install
INST_DIR=${INSTALL_MOD_PATH}/lib/firmware/zd1211


.PHONY: install clean

all:
	@echo "################################################"
	@echo " INSTALL Zydas chip based USB WIFI firmware ..."
	@echo "################################################"
	@echo $(TDISTS)/$(TARCHIVE)

	@mkdir -p ${TDISTS}
	@mkdir -p ${TDIR}
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi

install:
	@mkdir -p ${INST_DIR}
	@tar -C ${TDIR} -xvjf ${TDISTS}/${TARCHIVE}
	@cp ${TDIR}/zd1211-firmware/zd1211* ${INST_DIR}/

clean:
	@rm -rfv ${TDIR}

realclean:
	@rm -rfv $(TDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
