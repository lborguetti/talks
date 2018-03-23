.PHONY: clean build-aci sign-aci push-aci

ARCH       = amd64
OS         = linux
NAME       = alpine-nginx
VERSION    = 1.0
BUCKET     = rkt.devopsfloripa.io

default: build-aci

clean:
	sudo rm -rf .acbuild $(NAME)-$(VERSION).aci $(NAME)-$(VERSION).aci.asc

build-aci:
	$(MAKE) clean
	sudo acbuild begin
	sudo acbuild dependency add quay.io/coreos/alpine-sh
	sudo acbuild set-name rkt.devopsfloripa.io/$(NAME)
	sudo acbuild run -- apk add -U --no-cache nginx
	sudo acbuild run -- mkdir /run/nginx
	sudo acbuild port add http tcp 80
	sudo acbuild set-exec -- /usr/sbin/nginx -g "daemon off;"
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
