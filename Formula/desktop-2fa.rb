class Desktop2fa < Formula
  desc "Secure offline TOTP desktop authenticator"
  homepage "https://github.com/wrogistefan/desktop-2fa"
  url "https://files.pythonhosted.org/packages/source/d/desktop-2fa/desktop_2fa-0.7.2.tar.gz"
  sha256 "009C605476CD656EF9FD14A21CD2E61E1932881BD76458DF6A3161FCE95E9702"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    python = Formula["python@3.12"].opt_libexec/"bin/python3"
    venv = libexec/"venv"

    # Create venv using the correct python path
    system python, "-m", "venv", venv

    # Install desktop-2fa inside venv
    system venv/"bin/pip", "install", "--upgrade", "pip", "setuptools", "wheel"
    system venv/"bin/pip", "install", "desktop-2fa==0.7.2"

    # Wrappers
    (bin/"d2fa").write <<~EOS
      #!/bin/bash
      exec "#{venv}/bin/desktop-2fa" "$@"
    EOS

    (bin/"desktop-2fa").write <<~EOS
      #!/bin/bash
      exec "#{venv}/bin/desktop-2fa" "$@"
    EOS
  end

  test do
    assert_match "Desktop-2FA v0.7.2", shell_output("#{bin}/d2fa --version")
  end
end

