# Ensure the boot directory exists before upstream install runs
do_install_prepend() {
    install -d ${D}/boot
}

# Tell BitBake where to find our files
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Add our two files into SRC_URI so they get staged into ${WORKDIR}
SRC_URI += " \
    file://extra-config.txt \
    file://extra-cmdline.txt \
"

# After the normal rpi-config install, overwrite the boot files
do_install_append() {
    install -m 0644 ${WORKDIR}/extra-config.txt  ${D}/boot/config.txt
    install -m 0644 ${WORKDIR}/extra-cmdline.txt ${D}/boot/cmdline.txt
}

