##############################################################################
# Description: Makefile for libxml (xml parsing tools)
# 
# Author:  Tom Bruno (tbruno@neuros.us) & Terry Qiu(tqiu@neuros.com.cn)
# version: 1.0
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=2.6.32
TARCHIVE=libxml2-$(TVER).tar.gz
TURL=ftp://xmlsoft.org/libxml2/$(TARCHIVE)
BDIR=_build
TDIR=$(BDIR)/libxml2-$(TVER)
TDISTS=$(PRJROOT)/external-components/downloads
INSTROOT=$(shell pwd)/$(BDIR)/products

.PHONY: install clean

all:
	@mkdir -p ${TDISTS}
	@mkdir -p $(BDIR)
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi
	@tar -C _build --touch -xvzf ${TDISTS}/${TARCHIVE}

	for p in $$(ls patches/*.diff) ; \
	do patch -d $(TDIR) -p1 < $$p ; \
	done

	mkdir -p $(INSTROOT)
	cd $(TDIR) && \
	./configure --prefix=$(INSTROOT) --host=arm-linux
	make -C $(TDIR)

install: all
	mkdir -p $(INSTROOT)/etc  # make install should create this, but doesn't	
	make -C $(TDIR) install

	mkdir -p $(INSTALL_MOD_PATH)/usr/bin
	mkdir -p $(INSTALL_MOD_PATH)/usr/lib
	mkdir -p $(INSTALL_MOD_PATH)/usr/share

	arm-linux-strip --strip-unneeded $(INSTROOT)/bin/xmlcatalog
	arm-linux-strip --strip-unneeded $(INSTROOT)/bin/xmllint
	arm-linux-strip --strip-unneeded $(INSTROOT)/lib/libxml2.so

	cp -av $(INSTROOT)/bin/xmlcatalog $(INSTALL_MOD_PATH)/usr/bin
	cp -av $(INSTROOT)/bin/xmllint $(INSTALL_MOD_PATH)/usr/bin
	cp -av $(INSTROOT)/lib/* $(INSTALL_MOD_PATH)/usr/lib
	cp -av $(INSTROOT)/share/* $(INSTALL_MOD_PATH)/usr/share

	mkdir -p $(TOOLCHAIN_USR_INSTALL)/include
	mkdir -p $(TOOLCHAIN_USR_INSTALL)/lib
	cp -av $(INSTROOT)/include/libxml2/* $(TOOLCHAIN_USR_INSTALL)/include
	cp -av $(INSTROOT)/lib/libxml2.so* $(TOOLCHAIN_USR_INSTALL)/lib
	cp -av $(INSTROOT)/lib/pkgconfig $(TOOLCHAIN_USR_INSTALL)/lib


clean: 
	@rm -rfv $(BDIR)

realclean: 
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
