##############################################################################
# Description: Makefile for oprofile (profiling tool)
# 
# Author:  Ugo Riboni (nerochiaro@neuros.us) & Terry Qiu(tqiu@neuros.com.cn)
# version: 0.9.4
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=0.9.4
TARCHIVE=oprofile-$(TVER).tar.gz
TURL=http://prdownloads.sourceforge.net/oprofile/$(TARCHIVE)
BDIR=_build
TDIR=$(BDIR)/oprofile-$(TVER)
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
	CFLAGS="-I$(TOOLCHAIN_USR_INSTALL)/include -L$(TOOLCHAIN_USR_INSTALL)/lib -msoft-float" \
	./configure --host=arm-linux --with-kernel-support \
	--with-extra-includes=$(TOOLCHAIN_USR_INSTALL)/include --with-extra-libs=$(TOOLCHAIN_USR_INSTALL)/lib \
	--prefix=$(INSTROOT)

	make -C $(TDIR)
	make -C $(TDIR) install

install: all
	mkdir -p $(INSTALL_MOD_PATH)/usr/bin
	mkdir -p $(INSTALL_MOD_PATH)/lib

	for f in $(INSTROOT)/bin/* ; do arm-linux-strip --strip-unneeded $$f ; done
	cp -av $(INSTROOT)/bin/* $(INSTALL_MOD_PATH)/usr/bin/
	
	arm-linux-strip --strip-unneeded $(INSTROOT)/lib/oprofile/*.so*
	cp -av $(INSTROOT)/lib/oprofile $(INSTALL_MOD_PATH)/usr/lib/

clean: 
	@rm -rfv $(BDIR)

realclean: 
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
