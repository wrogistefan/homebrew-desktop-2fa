class Desktop2fa < Formula
  include Language::Python::Virtualenv

  desc "Secure offline desktop application for generating and managing TOTP 2FA codes"
  homepage "https://github.com/wrogistefan/desktop-2fa"
  url "https://files.pythonhosted.org/packages/source/d/desktop-2fa/desktop-2fa-0.7.1.tar.gz"
  sha256 "c6d0f4b1e0b1f6d1b3b4c7c8b1e8c1a2e0c9d8f8f4a2b0d4f7b8e3c1d2f9a0b"

  license "Apache-2.0"

  depends_on "python@3.12"
  depends_on "pipx"

  def install
    # pipx isolation with explicit python
    system Formula["pipx"].opt_bin/"pipx", "install",
           "desktop-2fa",
           "--python", Formula["python@3.12"].opt_bin/"python3.12",
           "--force"

    # symlink the executable into Homebrew's bin
    bin.install_symlink HOMEBREW_PREFIX/"bin/desktop-2fa"
  end

  def caveats
    <<~EOS
      desktop-2fa is installed using pipx for full dependency isolation.

      This ensures:
        • all Python dependencies are installed correctly
        • no conflicts with system Python or Homebrew Python
        • clean upgrades when new versions are published to PyPI

      To run:
        desktop-2fa --help

      To upgrade:
        pipx upgrade desktop-2fa
    EOS
  end

  test do
    system "#{bin}/desktop-2fa", "--help"
  end
end
