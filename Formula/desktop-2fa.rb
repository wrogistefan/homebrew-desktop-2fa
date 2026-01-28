class Desktop2fa < Formula
  desc "Secure offline TOTP desktop authenticator"
  homepage "https://github.com/wrogistefan/desktop-2fa"
  url "https://files.pythonhosted.org/packages/c5/25/194d538ae07fd42c65f882b4b53decafbfa9fd4cae594a6a16c7578495b1/desktop_2fa-0.8.1.tar.gz"
  sha256 "347b3eaf9d213160a9fd25cfa75acebaf7751048dea98c657eba2fb1eba8caa2"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    python = Formula["python@3.12"].opt_libexec/"bin/python3"
    venv = libexec/"venv"

    # Create venv using the correct python path
    system python, "-m", "venv", venv

    # Install desktop-2fa inside venv
    system venv/"bin/pip", "install", "--upgrade", "pip", "setuptools", "wheel"
    system venv/"bin/pip", "install", "desktop-2fa==0.8.1"

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
    assert_match "Desktop-2FA v0.8.1")
  end
end

