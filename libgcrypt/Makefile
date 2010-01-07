##############################################################################
# Description: Makefile for libgcrypt
#
# Author:  Jean-Paul Saman <jean-paul.saman@m2x.nl>
# version: 1.2.3
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=1.2.3
TARCHIVE=libgcrypt-$(TVER).tar.bz2
TURL=ftp://ftp.gnupg.org/gcrypt/libgcrypt/$(TARCHIVE)
BDIR=_build
TDIR=$(BDIR)/libgcrypt-$(TVER)
TDISTS=$(PRJROOT)/external-components/downloads
INST_DIR=${INSTALL_MOD_PATH}
INSTROOT=$(shell pwd)/$(BDIR)/products

CC=arm-linux-gcc

.PHONY: all install clean realclean

all:
	@echo "########################################"
	@echo "    INSTALL libgcrypt ..."
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
		--with-librt \
		--with-gpg-error-prefix=$(INSTALL_MOD_PATH)/usr

	@make -C $(TDIR) CC=$(CC)
	@sudo make -C $(TDIR) CC=$(CC) DESTDIR=$(TOOLCHAIN)/target install
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(INSTALL_MOD_PATH) install

        # fix libtool idiotics
	#@rm $(TOOLCHAIN)/target/usr/lib/libcrypt.la $(INSTALL_MOD_PATH)/usr/lib/libgcrypt.la
	@sed -e 's/libdir=\'\/usr\/lib\'/libdir=\'$(TOOLCHAIN)\/target\/usr\/lib\'/' \
		-i.orig $(TOOLCHAIN)/target/usr/lib/libcrypt.la $(INSTALL_MOD_PATH)/usr/lib/libgcrypt.la

        # fixup libgcrypt-config
	@sed -e 's/exec_prefix=/exec_prefix=\${prefix}/' \
	     -e 's/includedir=/includedir=\${prefix}/' \
	     -e 's/libdir=/libdir=\${prefix}/' -i.orig $(TOOLCHAIN)/target/usr/bin/libgcrypt-config

	@sed -e 's/exec_prefix=/exec_prefix=\${prefix}/' \
	     -e 's/includedir=/includedir=\${prefix}/' \
	     -e 's/libdir=/libdir=\${prefix}/' -i.orig $(INSTALL_MOD_PATH)/usr/bin/libgcrypt-config
`
install:
	#install to rootfs
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(INSTALL_MOD_PATH) install

clean:
	@rm -rfv $(BDIR)

realclean:
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
