class Termpdf < Formula
  desc "Terminal PDF reader built with Rust, ratatui, PDFium, and the kitty image protocol"
  homepage "https://github.com/NiJingzhe/TermPDF"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/NiJingzhe/TermPDF/releases/download/v0.1.1/termpdf-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "684de354e1e5e1e6b6a347030b89b7dd0edfe49cbed8fabb13e841b3d661b2d4"
    end
  end

  def install
    libexec.install "termpdf"

    libexec.install "libpdfium.dylib"

    (bin/"termpdf").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/termpdf" "$@"
    EOS
  end

  test do
    assert_match "TermPDF", shell_output("#{bin}/termpdf --help")
  end
end
