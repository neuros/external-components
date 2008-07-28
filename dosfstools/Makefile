##############################################################################
# Description: Makefile for dosfstools
# 
# Author:  Terry Qiu (tqiu@neuros.com.cn)
# version: 1.0
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=2.11
TARCHIVE=dosfstools-$(TVER).src.tar.gz
TURL=ftp://ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools/$(TARCHIVE)
BDIR=_build
TDIR=$(BDIR)/dosfstools-$(TVER)
TDISTS=$(PRJROOT)/external-components/downloads
INST_DIR=${INSTALL_MOD_PATH}

.PHONY: install clean

all:
	@echo "########################################"
	@echo "    INSTALL dosfstools ..."
	@echo "########################################"

	@mkdir -p ${TDISTS}
	@mkdir -p ${BDIR}
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi
	@tar -C ${BDIR} -xvzf ${TDISTS}/${TARCHIVE}

	for p in $$(ls patches/*.diff) ; \
	do patch -d $(TDIR) -p1 < $$p ; \
	done

	@make -C $(TDIR) CC=$(CC)

install:
	@make -C $(TDIR) CC=$(CC) PREFIX=$(INSTALL_MOD_PATH) install

clean:
	@rm -rfv $(BDIR)

realclean:
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
