class Ota < Formula
  desc "Manage OTA Connect devices, groups, packages and campaigns"
  bottle do
    root_url "https://github.com/advancedtelematic/ota-cli/releases/download/0.1.0/"
    cellar :any
    sha256 "76d0598ea37213ac6b3741a00dfc421533cfd270a4174c5b4f37521cec6dc2be" => :mojave
  end

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
