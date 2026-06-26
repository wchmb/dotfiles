nix:
#	sudo -E nix run nix-darwin -- switch --flake .
	sudo darwin-rebuild switch --flake .

update:
	nix flake update
	sudo darwin-rebuild switch --flake .

install:
	sudo nix run nix-darwin/master#darwin-rebuild -- switch
