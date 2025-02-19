class Cli < Formula
  desc "Command line utility for nullplatform APIs"
  homepage "https://nullplatform.com"
  version "latest"

  cli_version = version.to_s

  linux_arm_checksum   = "11c7b08e737576276202f4a238d607a9e42aff5ebcfc87a2ad06aa266b3c10f5"
  linux_amd_checksum   = "3958e29bb1b9826ab8da4da5b1cb7b2aadcc3f7f806e539c7ba1539dbf6c732b"
  darwin_arm_checksum  = "816f9b38f4cdb4b0cbe740894f681c28c568fed58585948ed7a5d9f96442223a"
  darwin_amd_checksum  = "61714ab41e4a621e783b3531de40c7561761ad084cad5e368b7606357599ca93"

  linux_arm_binary     = "np-Linux-arm"
  linux_amd_binary     = "np-Linux-amd"
  darwin_arm_binary    = "np-Darwin-arm"
  darwin_amd_binary    = "np-Darwin-amd"

  BINARY_INFORMATION = if OS.mac?
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        { name: darwin_amd_binary, sha256: darwin_amd_checksum }
      else
        odie "Unsupported 32 bits CPU architecture on macOS."
      end
    elsif Hardware::CPU.arm?
      { name: darwin_arm_binary, sha256: darwin_arm_checksum }
    else
      odie "Unsupported CPU architecture on macOS."
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        { name: linux_amd_binary, sha256: linux_amd_checksum }
      else
        odie "Unsupported 32 bits CPU architecture on Linux."
      end
    elsif Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        { name: linux_arm_binary, sha256: linux_arm_checksum }
      else
        odie "Unsupported 32 bits ARM CPU architecture on Linux."
      end
    else
      odie "Unsupported CPU architecture on Linux."
    end
  else
    odie "Unsupported operating system."
  end

  url "https://cli.nullplatform.com/#{cli_version}/#{BINARY_INFORMATION[:name]}"
  sha256 BINARY_INFORMATION[:sha256]

  def install
    # Install the binary into Homebrew's bin directory, renaming it to "np"
    bin.install "#{BINARY_INFORMATION[:name]}" => "np"

    # Ensure the binary is executable
    chmod 0755, bin/"np"

    # Generate and install shell completions

    # Bash completion
    bash_output = Utils.safe_popen_read("#{bin}/np", "completion", "bash")
    (bash_completion/"np").write bash_output

    # Zsh completion
    zsh_output = Utils.safe_popen_read("#{bin}/np", "completion", "zsh")
    (zsh_completion/"_np").write zsh_output

    # Fish completion
    fish_output = Utils.safe_popen_read("#{bin}/np", "completion", "fish")
    (fish_completion/"np.fish").write fish_output
  end

  test do
    # A simple test to check if the command runs and returns help text.
    assert_match "Usage", shell_output("#{bin}/np --help")
  end
end
