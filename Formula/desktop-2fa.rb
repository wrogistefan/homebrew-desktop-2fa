class Desktop2fa < Formula
  include Language::Python::Virtualenv

  desc "Desktop TOTP authenticator"
  homepage "https://github.com/wrogistefan/desktop-2fa"
  url "https://files.pythonhosted.org/packages/source/d/desktop-2fa/desktop-2fa-0.7.2.tar.gz"
  sha256 "009C605476CD656EF9FD14A21CD2E61E1932881BD76458DF6A3161FCE95E9702"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Desktop-2FA v0.7.2", shell_output("#{bin}/d2fa --version")
  end
end
