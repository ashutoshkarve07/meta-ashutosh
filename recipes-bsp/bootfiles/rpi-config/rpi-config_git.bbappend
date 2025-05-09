# let BitBake look in our files/ dir first
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# pick up our two extras
SRC_URI += " \
    file://extra-config.txt \
    file://extra-cmdline.txt \
"

# after upstream’s do_install, ensure /boot exists and then overwrite
do_install_append() {
    # create the boot folder in the image
    install -d ${D}/boot

    # copy in our versions
    install -m 0644 ${WORKDIR}/extra-config.txt   ${D}/boot/config.txt
    install -m 0644 ${WORKDIR}/extra-cmdline.txt  ${D}/boot/cmdline.txt
}

