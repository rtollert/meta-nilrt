
FILESEXTRAPATHS_prepend := "${THISDIR}:${THISDIR}/files:${THISDIR}/${PN}:"

SRC_URI =+ "file://busybox-ifplugd"
SRC_URI =+ "file://busybox-acpid file://acpid.conf file://acpid_poweroff.sh"

PACKAGES =+ " ${PN}-ifplugd"
PACKAGES =+ " ${PN}-acpid"

DEPENDS =+ " libselinux"

FILES_${PN}-ifplugd = "${sysconfdir}/init.d/busybox-ifplugd"
FILES_${PN}-acpid = "${sysconfdir}/init.d/busybox-acpid ${sysconfdir}/acpid.conf ${sysconfdir}/acpi ${sysconfdir}/acpi/poweroff.sh"

INITSCRIPT_PACKAGES =+ " ${PN}-ifplugd ${PN}-acpid"

INITSCRIPT_NAME_${PN}-ifplugd = "busybox-ifplugd"
INITSCRIPT_PARAMS_${PN}-ifplugd = "start 20 2 3 4 5 . stop 20 0 1 6 ."
INITSCRIPT_NAME_${PN}-acpid = "busybox-acpid"
INITSCRIPT_PARAMS_${PN}-acpid = "start 20 2 3 4 5 . stop 20 0 1 6 ."

do_install_append () {
	if grep "CONFIG_IFPLUGD=y" ${B}/.config; then
	       install -m 0755 ${WORKDIR}/busybox-ifplugd ${D}${sysconfdir}/init.d/
	fi
	if grep "CONFIG_ACPID=y" ${B}/.config; then
		install -m 0755 ${WORKDIR}/busybox-acpid ${D}${sysconfdir}/init.d/
		install -m 0755 ${WORKDIR}/acpid.conf ${D}${sysconfdir}/
		install -d ${D}${sysconfdir}/acpi
		install -m 0755 ${WORKDIR}/acpid_poweroff.sh ${D}${sysconfdir}/acpi/poweroff.sh
	fi
}
