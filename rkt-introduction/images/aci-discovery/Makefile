DOMAIN=rkt.devopsfloripa.io

default: aci-discovery

aci-discovery:
	sudo aci-discovery --domain $(DOMAIN)

pubkeys:
	gpg2 --export -a rkt@devopsfloripa.io > pubkeys.gpg
	sudo mkdir -p /opt/aci
	sudo cp pubkeys.gpg /opt/aci/pubkeys.gpg

clean:
	sudo rm -f pubkeys.gpg

.PHONY: clean
