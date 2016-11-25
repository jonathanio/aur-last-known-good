#!/bin/bash

sleep 10

# Get the preset name of the current kernel based on the name given to the
# initramfs file that was loaded with it.
PRESET_NAME="$(cat /proc/cmdline \
  | grep -Eo 'initrd=\\?initramfs-([^ ]+)\.img' \
  | sed -e 's/^.*initramfs-//' -e 's/\.img$//')"

( cd /boot
  if [[ ! -e "vmlinuz-${PRESET_NAME}" || \
        ! -e "initramfs-${PRESET_NAME}.img" ]]; then
    echo "FATAL: Unable to find vmlinuz and initramfs files. Aborting."
    exit -1
  fi

  if cmp --silent "vmlinuz-${PRESET_NAME}" "vmlinuz-${PRESET_NAME}-lkg" && \
     cmp --silent "initramfs-${PRESET_NAME}.img" "initramfs-${PRESET_NAME}-lkg.img"; then
    echo "SKIP: No change in vmlinuz or initramfs files."
    exit 0
  fi

  # We've booted into a new kernel, copy.
  if cp -f "vmlinuz-${PRESET_NAME}" ".vmlinuz-${PRESET_NAME}-lkg" && \
     cp -f "initramfs-${PRESET_NAME}.img" ".initramfs-${PRESET_NAME}-lkg.img"; then
    # Successful copy, move the files into place, overwriting.
    mv ".vmlinuz-${PRESET_NAME}-lkg" "vmlinuz-${PRESET_NAME}-lkg" && \
    mv ".initramfs-${PRESET_NAME}-lkg.img" "initramfs-${PRESET_NAME}-lkg.img"
    echo "SUCCESS: Kernel updates with current known good image."
    exit 0
  else
    rm -f ".vmlinuz-${PRESET_NAME}-lkg" ".initramfs-${PRESET_NAME}-lkg.img"
    echo "FATAL: Unable to copy vmlinuz or initramfs files. Aborting."
    exit -1
  fi
)
