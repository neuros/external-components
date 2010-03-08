##############################################################################
# Description: Makefile for libgpg-error
#
# Author:  Jean-Paul Saman <jean-paul.saman@m2x.nl>
# version: 1.6
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=1.6
TARCHIVE=libgpg-error-$(TVER).tar.bz2
TURL=ftp://ftp.gnupg.org/gcrypt/libgpg-error/$(TARCHIVE)
BDIR=_build
TDIR=$(BDIR)/libgpg-error-$(TVER)
TDISTS=$(PRJROOT)/external-components/downloads
INST_DIR=${INSTALL_MOD_PATH}
INSTROOT=$(shell pwd)/$(BDIR)/products

CC=arm-linux-gcc

.PHONY: all install clean realclean

all:
	@echo "########################################"
	@echo "    INSTALL libgpg-error ..."
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
		--with-gnu-ld \
		--with-librt

	@make -C $(TDIR) CC=$(CC)
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(TOOLCHAIN)/target install
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(INSTALL_MOD_PATH) install

	# fixup libtool madness
	@rm $(TOOLCHAIN)/target/usr/lib/libgpg-error.la $(INSTALL_MOD_PATH)/usr/lib/libgpg-error.la

	# fixup gpg-error-config
	@sed -e 's/exec_prefix=/exec_prefix=$${prefix}/' \
	     -e	's/includedir=/includedir=$${prefix}/' \
	     -e 's/libdir=/libdir=$${prefix}/' -i.orig $(TOOLCHAIN)/target/usr/bin/gpg-error-config

	@sed -e 's/exec_prefix=/exec_prefix=$${prefix}/' \
	     -e	's/includedir=/includedir=$${prefix}/' \
	     -e 's/libdir=/libdir=$${prefix}/' -i.orig $(INSTALL_MOD_PATH)/usr/bin/gpg-error-config

install:
	#install to rootfs
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(INSTALL_MOD_PATH) install

clean:
	@rm -rfv $(BDIR)

realclean:
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
