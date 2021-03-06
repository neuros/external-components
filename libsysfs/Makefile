##############################################################################
# Description: Makefile for libsysfs
#
# Author:  Jean-Paul Saman <jean-paul.saman@m2x.nl>
# version: 2.1.0
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=2.1.0
TARCHIVE=sysfsutils-$(TVER).tar.gz
TURL=http://sourceforge.net/projects/linux-diag/files/sysfsutils/i$(TVER)/$(TARCHIVE)/download
BDIR=_build
TDIR=$(BDIR)/sysfsutils-$(TVER)
TDISTS=$(PRJROOT)/external-components/downloads
INST_DIR=${INSTALL_MOD_PATH}
INSTROOT=$(shell pwd)/$(BDIR)/products

CC=arm-linux-gcc

.PHONY: all install clean realclean

all:
	@echo "########################################"
	@echo "    INSTALL libsysfsutils ..."
	@echo "########################################"

	@mkdir -p ${TDISTS}
	@mkdir -p ${BDIR}
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi
	@tar -C ${BDIR} -xvzf ${TDISTS}/${TARCHIVE}

	cd $(TDIR) && \
	CFLAGS="-I$(TOOLCHAIN_USR_INSTALL)/include -fPIE -msoft-float" \
	LDFLAGS="-L$(TOOLCHAIN_USR_INSTALL)/lib -L${TOOLCHAIN_USR_INSTALL}/lib -lpthread" ac_cv_have_abstract_sockets=yes \
	./configure --prefix=$(INSTROOT) --host=arm-linux \
	        --exec-prefix=/usr \
	        --bindir=/usr/bin \
	        --libdir=/usr/lib \
	        --includedir=/usr/include \
		--datadir=/usr/share \
	        --mandir=/man \
	        --enable-shared \
		--disable-nls \
	        --disable-static \
		--with-gnu-ld \
		--with-librt

	@make -C $(TDIR) CC=$(CC)
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(TOOLCHAIN)/target install
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(INSTALL_MOD_PATH) install

install:
	#install to rootfs
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(INSTALL_MOD_PATH) install

clean:
	@rm -rfv $(BDIR)

realclean:
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
