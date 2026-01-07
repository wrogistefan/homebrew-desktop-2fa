class Desktop2fa < Formula
  desc "Secure TOTP authenticator for desktop with encrypted vault"
  homepage "https://github.com/wrogistefan/desktop-2fa"
  url "https://files.pythonhosted.org/packages/source/d/desktop_2fa/desktop_2fa-0.7.1.tar.gz"
  sha256 "e975c4dcd0531610c61acf0ae28babca4e87845c96fe7dbd45dbb13907a97f73"
  license "Apache-2.0"

  depends_on "python@3.12"
  depends_on "pipx"

  def install
    system "pipx", "install", "desktop-2fa==0.7.1"
    (bin/"d2fa").write <<~EOS
      #!/bin/bash
      exec pipx run desktop-2fa "$@"
    EOS
  end

  test do
    system "#{bin}/d2fa", "--help"
  end
end
