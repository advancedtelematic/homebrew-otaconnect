class Ota < Formula
  desc "Manage OTA Connect devices, groups, packages and campaigns"
  homepage ""
  version "0.1.0"
  url "https://github.com/advancedtelematic/ota-cli.git", :using => :git, :tag => "#{version}"
  sha256 "12042bdaa88299e9825681c28589337045116f74"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--root", prefix, "--path", "."
  end

  test do
    system "#{bin}/ota --help"
  end
end
