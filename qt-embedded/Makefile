#########################################################################################
# This makefile is for an external application/library in the Neuros source tree.
# Available options are:
#
# - install: use only this during normal builds. will just install pre-build binaries.
# - rebuild: this will download the source, patch it and rebuild it to generate from 
#            scratch the pre-built binaries. You may need some special tools to re-build.
# - clean: if you do a rebuild, this will restore the pristine env as before you did it.
#
# App/Library: Qt-Embedded Library
# Version: 4.4.0
# Extra tools for rebuild: wget
#########################################################################################

TVER=4.4.0
TDIR=_build/qt-embedded-linux-opensource-src-$(TVER)
TARCHIVE=qt-embedded-linux-opensource-src-$(TVER).tar.gz
TDISTS=$(PRJROOT)/external-components/downloads
BDIR=_build
## was opt/Qtopia
QT_INSTALL_PREFIX=/opt/Qt-$(TVER)

TURL=http://open.neurostechnology.com/files/osd2/external-components/qt-embedded/$(TARCHIVE)

INSTROOT=$(shell pwd)/_build/products

.PHONY: install clean cleanall

# Just run this during the normal neuros build procedure.
# It will install the pre-built binaries to the OSD rootfs.
# This will also install headers and libraries into the toolchain, so
# you can use them if you want.
#

all:

	# Only rebuild if directory doesn't exist already.
	configs/setup-qt-embedded.sh

	@echo "########################################"
	@echo "    INSTALL qt-embedded 4.0  ..."
	@echo "########################################"

	@mkdir -p ${TDISTS}
	@mkdir -p $(BDIR)
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi
	@tar -C _build --touch -xvzf ${TDISTS}/${TARCHIVE}

	patch -p0 < patches/00-remove-license-qt4.4.diff
	patch -p0 < patches/02-qfontdatabase_qws.diff
	patch -p0 < patches/03-qabstractbutton-focusfix.diff
	cp configs/qconfig-* $(TDIR)/src/corelib/global
	cd $(TDIR)/ && \
	./configure --prefix=${QT_INSTALL_PREFIX} -hostprefix ${TOOLCHAIN}/Qt-$(TVER) -release \
	-shared -no-accessibility -qt-sql-sqlite -no-qt3support \
	-nomake demos -nomake examples -nomake docs \
	-qt-gif -qt-libtiff -qt-libpng -qt-libmng -qt-libjpeg -no-openssl \
	-no-cups -embedded arm -xplatform qws/linux-arm-g++ -little-endian -qt-freetype \
	-depths 16,32 -qt-gfx-linuxfb -no-gfx-transformed -no-gfx-qvfb \
	-no-gfx-vnc -no-gfx-multiscreen -qt-kbd-tty -plugin-kbd-usb -no-kbd-sl5000 \
	-no-kbd-yopy -no-kbd-vr41xx -no-kbd-qvfb -qt-mouse-pc -no-mouse-bus \
	-qt-mouse-linuxtp -no-mouse-yopy -no-mouse-vr41xx -no-mouse-tslib \
	-no-mouse-qvfb -plugin-decoration-default \
	-no-stl -no-exceptions -no-sql-ibase -no-sql-mysql -no-sql-odbc \
	-no-sql-psql -no-sql-sqlite2 -no-decoration-styled  -no-decoration-windows \
	-no-decoration-default -I${TOOLCHAIN_USR_INSTALL}/include -reduce-relocations \
	-L${TOOLCHAIN_USR_INSTALL}/lib -no-phonon -no-xmlpatterns -no-dbus -no-nis -webkit \
	-DQT_KEYPAD_NAVIGATION

	make -j6 -C $(TDIR)
	make -j6 -C $(TDIR) install
	cd ${TOOLCHAIN} && ln -sf Qt-$(TVER) Qt


install:

	mkdir -p ${INSTALL_MOD_PATH}/${QT_INSTALL_PREFIX}/lib
	mkdir -p ${INSTALL_MOD_PATH}/${QT_INSTALL_PREFIX}/plugins
	mkdir -p ${INSTALL_MOD_PATH}/${QT_INSTALL_PREFIX}/lib/fonts

	cp -a ${TOOLCHAIN}/Qt/lib/libQt*so* ${INSTALL_MOD_PATH}/${QT_INSTALL_PREFIX}/lib
	cp -a fonts/*.qpf2 ${INSTALL_MOD_PATH}/${QT_INSTALL_PREFIX}/lib/fonts
	cp -a fonts/*.qpf2 ${TOOLCHAIN}/Qt/lib/fonts

	cp -Ra ${TOOLCHAIN}/Qt/plugins/* ${INSTALL_MOD_PATH}/${QT_INSTALL_PREFIX}/plugins

	cd ${INSTALL_MOD_PATH}/opt && ln -sf Qt-$(TVER) Qt

clean:
	-rm -rfv _build

cleanall: clean
	-rm -rfv ${TOOLCHAIN}/Qt
	-rm -rfv ${TOOLCHAIN}/Qt-$(TVER)

.PHONY: cleanall clean rebuild install
