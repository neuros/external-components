##############################################################################
# Description: Makefile for wireless-tools
# 
# Author:  Frank Xue
# version: 1.0
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=29
TARCHIVE=wireless_tools.$(TVER).tar.gz
TURL=http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/$(TARCHIVE)
TDISTS=$(PRJROOT)/external-components/downloads
TDIR=_install
INST_DIR=${INSTALL_MOD_PATH}/usr/bin
CC=arm-linux-gcc


.PHONY: install clean

all:
	@echo "########################################"
	@echo "    INSTALL wireless-tools ..."
	@echo "########################################"

	@mkdir -p ${TDISTS}
	@mkdir -p ${TDIR}
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi
	@tar -C ${TDIR} -xvzf ${TDISTS}/${TARCHIVE}
	@make -C $(TDIR)/wireless_tools.$(TVER) CC=$(CC) PREFIX=${INSTALL_MOD_PATH}/usr BUILD_STATIC=y

install:all
	@mkdir -p ${INST_DIR}
	@make -C $(TDIR)/wireless_tools.$(TVER) CC=$(CC) PREFIX=${INSTALL_MOD_PATH}/usr BUILD_STATIC=y install

clean:
	@rm -rfv ${TDIR}

realclean:
	@rm -rfv $(TDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
