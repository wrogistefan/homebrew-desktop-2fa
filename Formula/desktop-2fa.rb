class Desktop2fa < Formula
  desc "Secure offline TOTP desktop authenticator"
  homepage "https://github.com/wrogistefan/desktop-2fa"
  url "https://files.pythonhosted.org/packages/source/d/desktop-2fa/desktop_2fa-0.7.2.tar.gz"
  sha256 "009C605476CD656EF9FD14A21CD2E61E1932881BD76458DF6A3161FCE95E9702"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    venv_dir = libexec/"venv"
    system Formula["python@3.12"].opt_bin/"python3", "-m", "venv", venv_dir

    # pip w venv
    pip = venv_dir/"bin/pip"
    system pip, "install", "--upgrade", "pip", "setuptools", "wheel"
    system pip, "install", "desktop-2fa==0.7.2"

    # wrapper
    (bin/"d2fa").write <<~EOS
      #!/bin/bash
      exec "#{venv_dir}/bin/desktop-2fa" "$@"
    EOS
    chmod 0755, bin/"d2fa"

    (bin/"desktop-2fa").write <<~EOS
      #!/bin/bash
      exec "#{venv_dir}/bin/desktop-2fa" "$@"
    EOS
    chmod 0755, bin/"desktop-2fa"
  end

  test do
    assert_match "Desktop-2FA v0.7.2", shell_output("#{bin}/d2fa --version")
  end
end
