##############################################################################
# Description: Makefile for ntfs-3g
# 
# Author:  Terry Qiu(tqiu@neuros.com.cn)
# Version: 1.0
# Extra tools for rebuild: wget
# Dependencies: fuse
#########################################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=1.2531
TARCHIVE=ntfs-3g-$(TVER).tgz
TURL=http://www.ntfs-3g.org/$(TARCHIVE)
BDIR=_build
TDIR=$(BDIR)/ntfs-3g-$(TVER)
TDISTS=$(PRJROOT)/external-components/downloads
INSTROOT=$(shell pwd)/$(BDIR)/products

.PHONY: install clean

all:
	@echo "########################################"
	@echo "    INSTALL ntfs-3g utilities ..."
	@echo "########################################"

	@mkdir -p ${TDISTS}
	@mkdir -p $(BDIR)
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi
	@tar -C $(BDIR) --touch -xvzf ${TDISTS}/${TARCHIVE}

	for p in $$(ls patches/*.diff) ; \
	do patch -d $(TDIR) -p1 < $$p ; \
	done

	mkdir -p $(INSTROOT)
	cd $(TDIR) && \
	./configure --prefix=$(INSTROOT) --host=arm-linux --exec-prefix=$(INSTROOT) \
	--disable-ldconfig --disable-static --disable-mtab --disable-debug

	make -C $(TDIR)

install: all
	make -C $(TDIR) install
	arm-linux-strip --strip-unneeded $(INSTROOT)/bin/*
	arm-linux-strip --strip-unneeded $(INSTROOT)/lib/*.so*

	cp -av $(INSTROOT)/bin/* $(INSTALL_MOD_PATH)/bin/
	cp -av $(INSTROOT)/lib/libntfs-3g.so* $(INSTALL_MOD_PATH)/lib/
	rm -f $(INSTALL_MOD_PATH)/sbin/mount.ntfs-3g
	ln -s /bin/ntfs-3g $(INSTALL_MOD_PATH)/sbin/mount.ntfs-3g

clean:
	@rm -rfv $(BDIR)

realclean:
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
