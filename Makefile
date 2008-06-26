all:
%::
	@mkdir -p downloads
	@$(MAKE) -C wifi-firmware $@
	@$(MAKE) -C wifi-tools $@
	@$(MAKE) -C e2fsprogs $@
	@$(MAKE) -C dosfstools $@
