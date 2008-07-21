all:
%::
	@mkdir -p downloads
	@$(MAKE) -C qt-embedded $@
	@$(MAKE) -C rt73-firmware $@
	@$(MAKE) -C zydas-firmware $@
	@$(MAKE) -C wifi-tools $@
	@$(MAKE) -C e2fsprogs $@
	@$(MAKE) -C dosfstools $@
	@$(MAKE) -C ntfs-3g $@
	@$(MAKE) -C yaffs2_utils $@
