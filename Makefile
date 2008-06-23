all:
%::
	@mkdir -p downloads
	@$(MAKE) -C wifi-firmware $@
	@$(MAKE) -C wifi-tools $@
