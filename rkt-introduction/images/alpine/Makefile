.PHONY: clean build-rootfs build-aci sign-aci push-aci

ARCH     = amd64
OS       = linux
NAME     = alpine
VERSION  = 3.6
ROOTFS   = build/rootfs
BUCKET   = rkt.devopsfloripa.io

default: build-aci

clean:
	sudo rm -rf .acbuild ./build $(NAME)-$(VERSION).aci $(NAME)-$(VERSION).aci.asc

build-rootfs:
	sudo ./build-alpine.sh $(VERSION)

build-aci:
	$(MAKE) clean build-rootfs
	sudo acbuild begin
	sudo acbuild set-name rkt.devopsfloripa.io/$(NAME)
	sudo acbuild copy-to-dir $(ROOTFS)/* /
	sudo acbuild set-exec -- /bin/sh
	sudo acbuild --debug label add version $(VERSION)
	sudo acbuild --debug label add arch $(ARCH)
	sudo acbuild --debug label add os $(OS)
	sudo acbuild --debug write --overwrite $(NAME)-$(VERSION).aci
	sudo acbuild end
	$(MAKE) sign-aci push-aci

sign-aci:
	rm -f $(NAME)-$(VERSION).aci.asc
	gpg2 -u rkt@devopsfloripa.io -o $(NAME)-$(VERSION).aci.asc --detach-sign $(NAME)-$(VERSION).aci

push-aci:
	sudo mkdir -p /opt/aci/linux/amd64
	sudo cp -rf $(NAME)-$(VERSION).aci.asc /opt/aci/linux/amd64
	sudo cp -rf $(NAME)-$(VERSION).aci /opt/aci/linux/amd64
