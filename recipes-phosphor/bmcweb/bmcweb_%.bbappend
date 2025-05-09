################################################
# meta-custom/recipes-phosphor/bmcweb/bmcweb_%.bbappend
################################################

# 1) Disable strict XSS prevention so bmcweb
#    won’t crash if schema files are missing
PACKAGECONFIG:append = " insecure-disable-xss"

# 2) Ensure we ship the insecure signing key
DEPENDS:append = " phosphor-insecure-signing-key-native"

