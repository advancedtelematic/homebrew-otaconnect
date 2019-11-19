class Aktualizr < Formula
  desc "C++ Client for HERE OTA Connect"
  homepage ""
  version "2019.9"
  url "https://github.com/advancedtelematic/aktualizr.git", :using => :git, :tag => "#{version}"
  sha256 "782fa343c85be455d6e51bd774f3244e0dad093989ac9bb1d96215785f7e7314"

  depends_on "asn1c"
  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "libarchive"
  depends_on "libsodium"
  depends_on "curl-openssl"
  depends_on "pkgconfig" => :build
  depends_on "openssl"
  depends_on "python3" => :build

  bottle do
    root_url "https://github.com/advancedtelematic/aktualizr/releases/download/2019.9"
    cellar :any
    sha256 "021255fc3b2b7409ab649adeb0abdb71efec564519ca7d0a6ad36d92abc9f8b6" => :mojave
  end

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "mkdir", "-p", "#{bin}"
      system "cp", "./src/aktualizr_primary/aktualizr", "#{bin}/aktualizr"
    end
  end

  test do
    system "#{bin}/aktualizr --help"
  end
end
