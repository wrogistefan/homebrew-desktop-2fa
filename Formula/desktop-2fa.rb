class Desktop2fa < Formula
  include Language::Python::Virtualenv

  desc "Secure offline 2FA desktop authenticator"
  homepage "https://github.com/wrogistefan/desktop-2fa"
  url "https://github.com/wrogistefan/desktop-2fa/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "F5AD98105290819C4E497D1FCC5CF52D160FAB21B62CB1577D826BA53B3E4B17"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    # Basic test: check that CLI runs and prints version
    output = shell_output("#{bin}/d2fa --help")
    assert_match "Usage", output
  end
end
