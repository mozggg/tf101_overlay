# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#EAPI=5

#inherit xorg-2
XORG_ABI=12

DESCRIPTION="NVIDIA Tegra X.org binary driver"
HOMEPAGE="https://developer.nvidia.com/linux-tegra"
SRC_URI="http://developer.download.nvidia.com/mobile/tegra/l4t/r${PV}.0/ventana_release_armhf/Tegra20_Linux_R${PV}_armhf.tbz2"

LICENSE="nvidia"
SLOT="0"
KEYWORDS="arm"

IUSE=""
DEPEND="<x11-base/xorg-server-1.14.99"
RDEPEND="${DEPEND}"

RESTRICT="strip mirror"

S="${WORKDIR}"

src_unpack() {
	unpack "${A}"
	unpack "./Linux_for_Tegra/nv_tegra/nvidia_drivers.tbz2"
}

src_install() {
	ddir=usr/lib/xorg/modules/drivers
	insinto /$ddir
	newins $ddir/tegra_drv.abi$XORG_ABI.so tegra_drv.so

	#conflicting mesa
	rm usr/lib/libEGL*
	rm usr/lib/libGLES*
	#conflicting libjpeg
	rm usr/lib/libjpeg*
	#all others
	insinto /usr/lib
	doins usr/lib/lib*

	insinto /lib/firmware
	doins lib/firmware/*.bin
}
