##############################################################################
# Description: Makefile for strace
#
# Author:  Jean-Paul Saman <jean-paul.saman@m2x.nl>
# version: 4.5.19
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=4.5.19
TARCHIVE=strace-$(TVER).tar.bz2
TURL=http://sourceforge.net/projects/strace/files/strace/${VER}/${TARCHIVE}/download
BDIR=_build
TDIR=$(BDIR)/strace-$(TVER)
TDISTS=$(PRJROOT)/external-components/downloads
INST_DIR=${INSTALL_MOD_PATH}
INSTROOT=$(shell pwd)/$(BDIR)/products

CC=arm-linux-gcc

.PHONY: all install clean realclean

all:
	@echo "########################################"
	@echo "    INSTALL strace ..."
	@echo "########################################"

	@mkdir -p ${TDISTS}
	@mkdir -p ${BDIR}
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi
	@tar -C ${BDIR} -xvjf ${TDISTS}/${TARCHIVE}

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
	        --disable-rpath \
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
