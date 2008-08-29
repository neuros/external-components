##############################################################################
# Description: Makefile for Ralink RT73 chip based firmware installation
# 
# Author:  Frank Xue
# version: 1.0
# Extra tools for build: wget unzip
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

# check unzip util
UNZIP=$(shell which unzip)
ifeq ($(UNZIP),)
    $(error unzip util not found in your host, please install it first)
endif

TVER=1.8
TARCHIVE=RT71W_Firmware_V${TVER}.zip
TURL=http://www.ralinktech.com.tw/data/${TARCHIVE}
TDISTS=$(PRJROOT)/external-components/downloads
TDIR=_install
INST_DIR=${INSTALL_MOD_PATH}/lib/firmware


.PHONY: install clean

all:
	@echo "######################################################"
	@echo " INSTALL Ralink RT73 chip based USB WIFI firmware ..."
	@echo "######################################################"
	@echo $(TDISTS)/$(TARCHIVE)

	@mkdir -p ${TDISTS}
	@mkdir -p ${TDIR}
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi

install:
	@mkdir -p ${INST_DIR}
	@unzip -o -d ${TDIR} ${TDISTS}/${TARCHIVE}
	@cp ${TDIR}/RT71W_Firmware_V${TVER}/rt73.bin ${INST_DIR}/

clean:
	@rm -rfv ${TDIR}

realclean:
	@rm -rfv $(TDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
