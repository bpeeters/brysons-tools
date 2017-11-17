# Copyright 2017 Bryson Peeters
# Distributed under the terms of GNU GPLv3
# $Id$

EAPI=6

if [ "${ARCH}" = "amd64" ] ; then
	LNXARCH="linux-x86_64"
else
	LNXARCH="linux-i686"
fi

MY_PN="gitkraken"

# For icons
inherit eutils

DESCRIPTION="The legendary Git GUI client for Windows, Mac, and Linux"
HOMEPAGE="https://www.gitkraken.com"
SRC_URI="
	amd64? ( "https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz" )
	x86? ( "https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz" )
"

LICENSE="gitkraken-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="mirror strip"
RDEPEND=""

S="${WORKDIR}/${MY_PN}"

GITKRAKEN_INSTALL_DIR="/opt/${PN}"

src_install() {

	# install gitkraken files to /opt/gitkraken
	dodir ${GITKRAKEN_INSTALL_DIR}
	cp -a ${S}/. ${D}${GITKRAKEN_INSTALL_DIR} || die "Installing files failed"

	# make gitkraken executable
	fperms +x ${GITKRAKEN_INSTALL_DIR}/gitkraken

	# symlink /opt/gitkraken/gitkraken to /opt/bin/gitkraken
	dosym ${GITKRAKEN_INSTALL_DIR}/gitkraken /opt/bin/gitkraken

	# create an icon
	newicon ${FILESDIR}/gitkraken-keif-teal-sq.png gitkraken.png

	# create desktop entry
	make_desktop_entry "/opt/bin/gitkraken" GitKraken gitkraken Development

}


