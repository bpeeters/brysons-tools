EAPI=7

DESCRIPTION="Enpass Password Manager"
HOMEPAGE="https://www.enpass.io"
SRC_URI="https://apt.enpass.io/pool/main/e/enpass/enpass_6.0.4.281_amd64.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="mirror strip"

inherit unpacker

RDEPEND="x11-libs/libXScrnSaver
	sys-process/lsof"

S="${WORKDIR}"

ENPASS_HOME="/opt/enpass"

src_prepare() {
	default
	unpack usr/share/doc/enpass/changelog.gz
	mkdir usr/share/doc/${PF}
	mv changelog usr/share/doc/${PF}
	rm -r usr/share/doc/enpass
}

src_install() {
	# The enpass deb package installs into ./usr and ./opt
	insinto /

	doins -r usr/
	#doins -r usr/share/applications
	#doins -r usr/share/icons
	#doins -r usr/share/mime

	doins -r opt/

	fperms +x ${ENPASS_HOME}/Enpass
	fperms +x ${ENPASS_HOME}/importer_enpass

	dosym ${ENPASS_HOME}/Enpass /usr/bin/enpass
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

