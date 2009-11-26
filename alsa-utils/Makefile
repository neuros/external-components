##############################################################################
# Description: Makefile for alsa-util
#
# Author:  Jean-Paul Saman <jean-paul.saman@m2x.nl>
# version: 1.0.21
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=1.0.21
TARCHIVE=alsa-utils-$(TVER).tar.bz2
TURL=ftp://ftp.alsa-project.org/pub/utils/$(TARCHIVE)
BDIR=_build
TDIR=$(BDIR)/alsa-utils-$(TVER)
TDISTS=$(PRJROOT)/external-components/downloads
INST_DIR=${INSTALL_MOD_PATH}
INSTROOT=$(shell pwd)/$(BDIR)/products

CC=arm-linux-gcc

.PHONY: all install clean realclean

all:
	@echo "########################################"
	@echo "    INSTALL alsa-utils ..."
	@echo "########################################"

	@mkdir -p ${TDISTS}
	@mkdir -p ${BDIR}
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi
	@tar -C ${BDIR} -xvjf ${TDISTS}/${TARCHIVE}

	#cd $(TDIR) && patch -p1 < ../../alsa-utils-ncurses.patch && autoreconf &&
	cd $(TDIR) && patch -p1 < ../../alsa-utils-configure.patch && autoreconf && \
	CFLAGS="-I$(TOOLCHAIN_USR_INSTALL)/include -fPIE -msoft-float" \
	LDFLAGS="-L$(TOOLCHAIN_USR_INSTALL)/lib -L${TOOLCHAIN_USR_INSTALL}/lib -lpthread" ac_cv_have_abstract_sockets=yes \
	./configure --prefix=$(INSTROOT) --host=arm-linux \
	        --with-alsa-prefix=$(TOOLCHAIN_USR_INSTALL)/lib/ \
	        --with-alsa-inc-prefix=$(TOOLCHAIN_USR_INSTALL)/include/ \
	        --exec-prefix=/usr \
	        --bindir=/usr/bin \
	        --libdir=/usr/lib \
	        --includedir=/usr/include \
		--datadir=/usr/share \
	        --mandir=/man \
	        --enable-shared \
		--disable-nls \
	        --disable-static \
	        --disable-rpath \
		--disable-xmlto \
	        --enable-alsatest \
	        --enable-alsamixer \
	        --enable-largefile \
		--with-curses=ncursest \
		--with-gnu-ld \
		--with-librt

	@make -C $(TDIR) CC=$(CC)
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(INSTALL_MOD_PATH) install

install:
	#install to rootfs
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(INSTALL_MOD_PATH) install

clean:
	@rm -rfv $(BDIR)

realclean:
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
