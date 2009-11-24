##############################################################################
# Description: Makefile for libpopt (cmd line option parsing library)
# 
# Author:  Ugo Riboni (nerochiaro@neuros.us) & Terry Qiu(tqiu@neuros.com.cn)
# version: 1.10.2
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=1.10.2
TARCHIVE=popt-$(TVER).tar.gz
TURL=http://rpm5.org/files/popt/$(TARCHIVE)
BDIR=_build
TDIR=$(BDIR)/popt-$(TVER)
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
	cd $(TDIR) && CFLAGS="-msoft-float" \
	./configure --prefix=/usr --host=arm-linux --disable-static
	make -C $(TDIR)
	DESTDIR=$(INSTROOT) make -C $(TDIR) install

install: all
	mkdir -p $(INSTALL_MOD_PATH)/usr/lib
	mkdir -p $(INSTALL_MOD_PATH)/usr/share

	arm-linux-strip --strip-unneeded $(INSTROOT)/usr/lib/*.so

	cp -av $(INSTROOT)/usr/lib/* $(INSTALL_MOD_PATH)/usr/lib
	cp -av $(INSTROOT)/usr/share $(INSTALL_MOD_PATH)/usr

	mkdir -p $(TOOLCHAIN_USR_INSTALL)/include
	mkdir -p $(TOOLCHAIN_USR_INSTALL)/lib
	cp -av $(INSTROOT)/usr/include/* $(TOOLCHAIN_USR_INSTALL)/include
	cp -av $(INSTROOT)/usr/lib/*.so* $(TOOLCHAIN_USR_INSTALL)/lib

clean: 
	@rm -rfv $(BDIR)

realclean: 
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
