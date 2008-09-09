##############################################################################
# Description: Makefile for libbfd (dependency of oprofile)
# 
# Author:  Ugo Riboni (nerochiaro@neuros.us) & Terry Qiu(tqiu@neuros.com.cn)
# version: 2.18
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=2.18
TARCHIVE=binutils-$(TVER).tar.gz
TURL=http://ftp.gnu.org/gnu/binutils/$(TARCHIVE)
BDIR=_build
TDIR=$(BDIR)/binutils-$(TVER)
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
	./configure --host=arm-linux --target=arm-linux --prefix=$(INSTROOT) 
	make -C $(TDIR)
	make -C $(TDIR) install

install: all
	mkdir -p $(TOOLCHAIN_USR_INSTALL)/include
	mkdir -p $(TOOLCHAIN_USR_INSTALL)/lib
	cp -av $(INSTROOT)/include/* $(TOOLCHAIN_USR_INSTALL)/include
	cp -av $(INSTROOT)/lib/* $(TOOLCHAIN_USR_INSTALL)/lib

	arm-linux-strip --strip-unneeded $(INSTROOT)/bin/*
	cp -av $(INSTROOT)/bin/objdump $(INSTALL_MOD_PATH)/usr/bin

# Only static libraries, no need to strip anything.
	cp -av $(INSTROOT)/lib/* $(INSTALL_MOD_PATH)/lib

	@echo
	@echo "********************************************************"
	@echo "Please notice that only static libraries and the objdump"
	@echo "binary were installed. It is not a full installation of"
	@echo "binutils, only just enough to make oprofile happy."
	@echo "********************************************************"
clean: 
	@rm -rfv $(BDIR)

realclean: 
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
