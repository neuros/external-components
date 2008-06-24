##############################################################################
# Description: Makefile for e2fsprogs (ext2/3 filesystem tools)
# 
# Author:  Terry Qiu(tqiu@neuros.com.cn)
# version: 1.0
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=1.40.2
TARCHIVE=e2fsprogs-$(TVER).tar.gz
TURL=http://downloads.sourceforge.net/sourceforge/e2fsprogs/$(TARCHIVE)
BDIR=_build
TDIR=$(BDIR)/e2fsprogs-$(TVER)
TDISTS=$(PRJROOT)/external-components/downloads
INSTROOT=$(shell pwd)/$(BDIR)/products

.PHONY: install clean

all:
	@echo "########################################"
	@echo "    INSTALL e2fsprogs utilities ..."
	@echo "########################################"

	@mkdir -p ${TDISTS}
	@mkdir -p $(BDIR)
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi
	@tar -C _build --touch -xvzf ${TDISTS}/${TARCHIVE}

	for p in $$(ls patches/*.diff) ; \
	do patch -d $(TDIR) -p1 < $$p ; \
	done

	mkdir -p $(INSTROOT)
	cd $(TDIR) && \
	./configure --prefix=$(INSTROOT) --host=arm-linux --with-cc=arm-linux-gcc --with-linker=arm-linux-ld \
	--disable-imager --disable-resizer --enable-elf-shlibs
	make -C $(TDIR)

install: all
	mkdir -p $(INSTROOT)/etc  # make install should create this, but doesn't	
	make -C $(TDIR) install

	arm-linux-strip --strip-unneeded $(INSTROOT)/sbin/*
	arm-linux-strip --strip-unneeded $(INSTROOT)/lib/*

	cp -av $(INSTROOT)/sbin/mke2fs $(INSTALL_MOD_PATH)/sbin
	cp -av $(INSTROOT)/sbin/e2fsck $(INSTALL_MOD_PATH)/sbin
	cp -av $(INSTROOT)/lib/libext2fs* $(INSTALL_MOD_PATH)/lib
	cp -av $(INSTROOT)/lib/libcom_err* $(INSTALL_MOD_PATH)/lib
	cp -av $(INSTROOT)/lib/libe2p* $(INSTALL_MOD_PATH)/lib
	cp -av $(INSTROOT)/lib/libblkid* $(INSTALL_MOD_PATH)/lib
	cp -av $(INSTROOT)/lib/libuuid* $(INSTALL_MOD_PATH)/lib

	cd $(INSTALL_MOD_PATH)/sbin && ln -svf mke2fs mkfs.ext2
	cd $(INSTALL_MOD_PATH)/sbin && ln -svf mke2fs mkfs.ext3
	cd $(INSTALL_MOD_PATH)/sbin && ln -svf e2fsck fsck.ext2
	cd $(INSTALL_MOD_PATH)/sbin && ln -svf e2fsck fsck.ext3

	cp -Rav $(INSTROOT)/etc/* $(INSTALL_MOD_PATH)/etc

clean: 
	@rm -rfv $(BDIR)

realclean: 
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)