#
# meta-custom/recipes-phosphor/images/obmc-phosphor-image/obmc-phosphor-image.bbappend
#

# 1) Create an empty Redfish log file before the final image is assembled
#ROOTFS_POSTPROCESS_COMMAND += "create_redfish_log;"

#create_redfish_log() {
#    install -d "${IMAGE_ROOTFS}/var/log"
#    install -m 0644 /dev/null "${IMAGE_ROOTFS}/var/log/redfish"
#}

#ROOTFS_POSTPROCESS_COMMAND += "create_redfish_log_safe;"

#create_redfish_log_safe() {
#    install -d "${IMAGE_ROOTFS}/var/log"
#    touch     "${IMAGE_ROOTFS}/var/log/redfish"
#    chmod 0644 "${IMAGE_ROOTFS}/var/log/redfish"
#}

# 2) Pull in mDNS, WPA supplicant, IPMI tool, web UI and bmcweb
IMAGE_INSTALL_append = " \
    avahi-daemon \
    wpa-supplicant \
    ipmitool \
    webui-vue \
    bmcweb \
"

# 3) Tweak the Raspberry Pi’s boot partition in one go
ROOTFS_POSTPROCESS_COMMAND += "update_rpi_boot;"

update_rpi_boot() {
    bbnote ">> update_rpi_boot: fixing config.txt + cmdline.txt in ${IMAGE_ROOTFS}/boot"

    # make sure the boot directory is there
    install -d "${IMAGE_ROOTFS}/boot"

    # (a) enable the Pi's UART0 for serial console
    if ! grep -qxF 'enable_uart=1' "${IMAGE_ROOTFS}/boot/config.txt"; then
        echo 'enable_uart=1' >> "${IMAGE_ROOTFS}/boot/config.txt"
    fi

    # (b) set up the correct cmdline for serial console + rootfs
    cat > "${IMAGE_ROOTFS}/boot/cmdline.txt" <<EOF
dwc_otg.lpm_enable=0 console=serial0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait
EOF
}
