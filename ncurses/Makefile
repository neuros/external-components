##############################################################################
# Description: Makefile for ncurses
#
# Author:  Jean-Paul Saman <jean-paul.saman@m2x.nl>
# version: 5.7
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=5.7
TARCHIVE=ncurses-$(TVER).tar.gz
TURL=http://ftp.gnu.org/pub/gnu/ncurses/$(TARCHIVE)
BDIR=_build
TDIR=$(BDIR)/ncurses-$(TVER)
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
		--with-shared \
		--disable-nls \
	        --disable-static \
	        --disable-rpath \
		--with-gnu-ld \
		--with-librt \
		--without-gpm \
		--without-ada \
		--without-cxx \
		--without-cxx-binding \
		--without-progs \
		--with-normal --with-debug \
		--disable-relink \
		--disable-lp64 --enable-largefile \
		--disable-big-core --disable-big-strings \
		--with-pthread --enable-reentrant \
		--enable-safe-sprintf \
		--enable-symlinks

	@make -C $(TDIR) CC=$(CC)
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(INSTROOT) install
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
