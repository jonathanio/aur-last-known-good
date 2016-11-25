pkgname=last-known-good
pkgver=1.0.0+rc1
pkgrel=1
pkgdesc="Backup the Last Known Good kernel on successful boots."
arch=("any")
url="https://github.com/jonathanio/aur-last-known-good"
license=("GPL")
depends=("bash" "systemd")
source=("${pkgname}.install"
        "${pkgname}.sh"
        "${pkgname}.man"
        "${pkgname}.service")
install="${pkgname}.install"
sha256sums=("SKIP"
            "SKIP"
            "SKIP"
            "SKIP")
sha512sums=("SKIP"
            "SKIP"
            "SKIP"
            "SKIP")

package() {
  install -D -m755 "${pkgname}.sh" "${pkgdir}/usr/bin/${pkgname}"
  install -D -m644 "${pkgname}.service" "${pkgdir}/usr/lib/systemd/system"
  install -D -m644 "${pkgname}.man" "${pkgdir}/usr/share/man/man8/${pkgname}.8"
}

# vim:set ts=2 sw=2 et:
