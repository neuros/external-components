##############################################################################
# Description: Makefile for alsa-lib
#
# Author:  Jean-Paul Saman (jean-paul.saman@m2x.nl)
# version: 1.0.21a
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=1.0.21a
TARCHIVE=alsa-lib-$(TVER).tar.bz2
TURL=ftp://ftp.alsa-project.org/pub/lib/$(TARCHIVE)
BDIR=_build
TDIR=$(BDIR)/alsa-lib-$(TVER)
TDISTS=$(PRJROOT)/external-components/downloads
INST_DIR=${INSTALL_MOD_PATH}
INSTROOT=$(shell pwd)/$(BDIR)/products

CC=arm-linux-gcc

.PHONY: all install clean realclean

all:
	@echo "########################################"
	@echo "    INSTALL alsa-lib ..."
	@echo "########################################"

	@mkdir -p ${TDISTS}
	@mkdir -p ${BDIR}
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi
	@tar -C ${BDIR} -xvjf ${TDISTS}/${TARCHIVE}

	cd ${TDIR} && \
	CFLAGS="-I$(TOOLCHAIN_USR_INSTALL)/include -fPIE -msoft-float" \
	LDFLAGS="-L$(TOOLCHAIN_USR_INSTALL)/lib -lm" ac_cv_have_abstract_sockets=yes \
	./configure \
	        --prefix=$(INSTROOT) \
		--host=arm-linux \
	        --exec-prefix=/usr \
		--datadir=/usr/share \
	        --bindir=/usr/bin \
	        --libdir=/usr/lib \
	        --includedir=/usr/include \
	        --mandir=/man \
	        --enable-shared \
	        --disable-static \
		--with-gnu-ld \
	        --with-softfloat \
		--with-pthread \
		--with-librt \
	        --disable-aload \
	        --enable-mixer \
	        --enable-pcm \
	        --enable-rawmidi \
	        --enable-hwdep \
	        --enable-seq \
	        --disable-instr \
	        --disable-alisp \
		--disable-python \
	        --with-debug=yes \
	        --with-alsa-devdir=/dev \
	        --with-aload-devdir=/dev \
		--with-ctl-plugins=all \
	        --with-pcm-plugins=all

	@make -C $(TDIR) CC=$(CC)
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(INSTROOT) install
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(TOOLCHAIN)/target install

	#Fix up $(INSTROOT)/usr/lib/pkgconfig/alsa.pc
	sed -e 's/libdir=\/usr\/lib/libdir=${prefix}\/usr\/lib/' \
	    -e 's/includedir=\/usr\/include/includedir=${prefix}\/usr\/include/' \
	    -i.orig $(INSTROOT)/usr/lib/pkgconfig/alsa.pc \
	    -i.orig $(TOOLCHAIN)/target/usr/lib/pkgconfig/alsa.pc

	#Auto install into toolchain for deps
	mkdir -p $(TOOLCHAIN_USR_INSTALL)/include/alsa
	cp -av $(INSTROOT)/usr/include/alsa/* $(TOOLCHAIN_USR_INSTALL)/include/alsa
	cp -av $(INSTROOT)/usr/include/sys/asoundlib.h $(TOOLCHAIN_USR_INSTALL)/include/sys
	cp -av $(INSTROOT)/usr/lib/* $(TOOLCHAIN_USR_INSTALL)/lib
	cp -av $(INSTROOT)/usr/bin/* $(TOOLCHAIN_USR_INSTALL)/bin

install:
	#install to rootfs
	mkdir -p $(INSTALL_MOD_PATH)/usr/lib
	mkdir -p $(INSTALL_MOD_PATH)/usr/share
	mkdir -p $(INSTALL_MOD_PATH)/usr/bin
	mkdir -p $(INSTALL_MOD_PATH)/etc

	cp -av $(INSTROOT)/usr/bin/* $(INSTALL_MOD_PATH)/usr/bin
	cp -av $(INSTROOT)/usr/lib/*.so* $(INSTALL_MOD_PATH)/usr/lib
	cp -av $(INSTROOT)/usr/share/* $(INSTALL_MOD_PATH)/usr/share
	#cp -av $(INSTROOT)/etc/* $(INSTALL_MOD_PATH)/etc

install:

clean:
	@rm -rfv $(BDIR)

realclean:
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
