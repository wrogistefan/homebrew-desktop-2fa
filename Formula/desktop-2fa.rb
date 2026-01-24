class Desktop2fa < Formula
  desc "Secure offline TOTP desktop authenticator"
  homepage "https://github.com/wrogistefan/desktop-2fa"
  url "https://files.pythonhosted.org/packages/52/d0/8c0e55b606fa20c41c95284c282f292a53e63f8e6c43040ca66ecac932fd/desktop_2fa-0.8.0.tar.gz"
  sha256 "fa9c6a2a242c98ed001d2e53a7cdcb7f2536a2b384314e5407c6e80fe69c5afc"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    python = Formula["python@3.12"].opt_libexec/"bin/python3"
    venv = libexec/"venv"

    # Create venv using the correct python path
    system python, "-m", "venv", venv

    # Install desktop-2fa inside venv
    system venv/"bin/pip", "install", "--upgrade", "pip", "setuptools", "wheel"
    system venv/"bin/pip", "install", "desktop-2fa==0.8.0"

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
    assert_match "Desktop-2FA v0.8.0")
  end
end

