SUMMARY = "Open source package dependencies for the NILRT SNAC configuration."
LICENSE = "MIT"


inherit packagegroup


RDEPENDS:${PN} = ""

RDEPENDS:${PN}:append = "\
	cryptsetup \
	ntp \
	tmux \
"
