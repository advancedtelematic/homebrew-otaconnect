class Ota < Formula
  desc "Manage OTA Connect devices, groups, packages and campaigns"
  homepage ""
  url "https://github.com/advancedtelematic/ota-cli.git", :using => :git
  version "0.1.0"
  sha256 "12042bdaa88299e9825681c28589337045116f74"

  depends_on "rust" => :build

  def install
    ENV["CARGO_HOME"] = "#{prefix}"
    system "make", "ota"
  end

  test do
    system "#{bin}/ota --help"
  end
end
