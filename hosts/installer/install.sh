#!/usr/bin/env bash

# TODO: maybe do inside pkgs.writeShellApplication instead of settings home.file and reading those from here
# Sources:
# https://github.com/iynaix/dotfiles/blob/main/install.sh
# https://github.com/iynaix/dotfiles/blob/main/nixos/zfs.nix
# https://github.com/iynaix/dotfiles/blob/main/nixos/impermanence.nix
# https://github.com/iynaix/dotfiles/blob/main/hosts/vm/default.nix#L9
set -e
function yesno() {
  local prompt="$1"

  while true; do
    read -rp "$prompt [y/n] " yn
    case $yn in
      [Yy]* ) echo "y"; return;;
      [Nn]* ) echo "n"; return;;
      * ) echo "Please answer yes or no.";;
    esac
  done
}

function info() {
  # 35 is magenta
  echo -e "\e[1;35m$1\e[0m"
}

cat << Introduction
This script will format the *entire* disk with a 1GB boot partition
(labelled NIXBOOT), 16GB of swap, then allocating the rest to ZFS.

The following ZFS datasets will be created:
    - zroot/root (mounted at / with blank snapshot)
    - zroot/nix (mounted at /nix)
    - zroot/tmp (mounted at /tmp)
    - zroot/persist (mounted at /persist)
    - zroot/persist/cache (mounted at /persist/cache)

Introduction


if [[ -b "/dev/vda" ]]; then
  # VM
  DISK="/dev/vda"

  BOOTDISK="${DISK}3"
  SWAPDISK="${DISK}2"
  ZFSDISK="${DISK}1"
# else
  # Regular disk
  # TODO
fi

info "Boot Partiton: $BOOTDISK"
info "SWAP Partiton: $SWAPDISK"
info "ZFS Partiton: $ZFSDISK"

do_format=$(yesno "This irreversibly formats the entire disk. Are you sure?")
if [[ $do_format == "n" ]]; then
    exit
fi

info "Partitioning disk"
sudo blkdiscard -f "$DISK"

sudo sgdisk -n3:1M:+1G -t3:EF00 "$DISK"
sudo sgdisk -n2:0:+16G -t2:8200 "$DISK"
sudo sgdisk -n1:0:0 -t1:BF01 "$DISK"

# notify kernel of partition changes
sudo sgdisk -p "$DISK" > /dev/null
sleep 5

info "Creating Swap"
sudo mkswap "$SWAPDISK" --label "SWAP"
sudo swapon "$SWAPDISK"

info "Creating Boot Disk"
sudo mkfs.fat -F 32 "$BOOTDISK" -n NIXBOOT

# setup encryption
use_encryption=$(yesno "Use encryption?")
if [[ $use_encryption == "y" ]]; then
    encryption_options=(-O encryption=aes-256-gcm -O keyformat=passphrase -O keylocation=prompt)
else
    encryption_options=()
fi

info "Creating base zpool"
sudo zpool create -f \
    -o ashift=12 \
    -o autotrim=on \
    -O compression=zstd \
    -O acltype=posixacl \
    -O atime=off \
    -O xattr=sa \
    -O normalization=formD \
    -O mountpoint=none \
    "${encryption_options[@]}" \
    zroot "$ZFSDISK"

info "Creating /"
sudo zfs create -o mountpoint=legacy zroot/root
sudo zfs snapshot zroot/root@blank
sudo mount -t zfs zroot/root /mnt

# create the boot parition after creating root
info "Mounting /boot (efi)"
sudo mount --mkdir "$BOOTDISK" /mnt/boot

info "Creating /nix"
sudo zfs create -o mountpoint=legacy zroot/nix
sudo mount --mkdir -t zfs zroot/nix /mnt/nix

info "Creating /tmp"
sudo zfs create -o mountpoint=legacy zroot/tmp
sudo mount --mkdir -t zfs zroot/tmp /mnt/tmp

info "Creating /cache"
sudo zfs create -o mountpoint=legacy zroot/cache
sudo mount --mkdir -t zfs zroot/cache /mnt/cache

info "Creating /persist"
sudo zfs create -o mountpoint=legacy zroot/persist
sudo mount --mkdir -t zfs zroot/persist /mnt/persist

info "Importing GPG key"
gpg --import gpg-key.asc
info "Cloning configuration"
git clone git@github.com:LilleAila/dotfiles
cd $HOME/dotfiles
info "Decrypting secrets"
git-crypt unlock

HOST=$(echo "Configure a new host" | cat - <(nix flake show . --json 2>/dev/null | jq --raw-output '.nixosConfigurations | keys[]') | fzf --header="Choose a host to install")
echo

if [ "$HOST" == "Configure a new host" ]; then
  info "Configuring new host..."
  read -r "Name for the new host: " HOST_NAME
  cp -r hosts/template "hosts/$HOST_NAME"
  sudo nixos-generate-config --no-filesystems --show-hardware-config > "hosts/$HOST_NAME/hardware-configuration.nix"
  info "Editing configuration.nix"
  info "Press enter to continue..."
  read
  if [[ $use_encryption == "y" ]]; then
    sed -i '/zfs.encryption/s/false/true/' "hosts/$HOST_NAME/configuration.nix"
  fi
  $hostId=$(head -c 8 /etc/machine-id)
  sed -i "/networking.hostId/s/placeholder/$hostId" "hosts/$HOST_NAME/configuration.nix"
  sed -i "/hostname/s/placeholder/$HOST_NAME" "hosts/$HOST_NAME/configuration.nix"
  info "Adding configuration to flake.nix"
  sed -i "/nixosConfigurations = {/a \ \ \ \ \ \ $HOST_NAME = mkConfig {name = \"$HOST_NAME\";};" flake.nix
  info "Commiting changes"
  git add -A
  git commit -m "Hosts: added $HOST_NAME"
  git push
  info "Installing NixOS configuration for host $HOST_NAME"
else
  info "Installing NixOS configuration for host $HOST"
fi

info "Press enter to continue..."
read
sudo nixos-install --no-root-password --flake .#$HOST

info "Copying secrets"
sudo mkdir -p /mnt/cache/.config/sops/age/keys.txt
sudo cat $HOME/.config/sops/ags/keys.txt > /mnt/cache/.config/sops/age/keys.txt
