class Termpdf < Formula
  TERMPDF_VERSION = "0.4.2".freeze

  desc "Terminal PDF reader using PDFium and the kitty image protocol"
  homepage "https://github.com/NiJingzhe/TermPDF"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/NiJingzhe/TermPDF/releases/download/v#{TERMPDF_VERSION}/termpdf-#{TERMPDF_VERSION}-aarch64-apple-darwin.tar.gz"
      sha256 "6cb4222a613d1c435203848b99be09094f09a523bff56377aed0aa5a3b107aa7"
    end
  end

  def install
    libexec.install "termpdf"

    libexec.install "libpdfium.dylib"

    (bin/"termpdf").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/termpdf" "$@"
    EOS

    generate_completions_from_executable(
      libexec/"termpdf", "completions", base_name: "termpdf", shells: [:zsh, :fish]
    )
  end

  test do
    assert_match "Terminal PDF viewer", shell_output("#{bin}/termpdf --help")
    assert_match "#compdef termpdf", shell_output("#{bin}/termpdf completions zsh")
    assert_match "complete -c termpdf", shell_output("#{bin}/termpdf completions fish")
  end
end
