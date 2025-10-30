#!/bin/bash
ln -s ~/flake/dots/* ~/.config/
rm ~/flake/hosts/home/hardware-configuration.nix
sudo nixos-generate-config
sudo cp /etc/nixos/hardware-configuration.nix ~/flake/hosts/home/hardware-configuration.nix
sudo nixos-rebuild switch --flake ~/flake#default
reboot
