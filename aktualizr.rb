class Aktualizr < Formula
  desc "C++ Client for HERE OTA Connect"
  homepage ""
  url "https://github.com/advancedtelematic/aktualizr/releases/download/2018.13/aktualizr-2018.13.tar.gz"
  sha256 "782fa343c85be455d6e51bd774f3244e0dad093989ac9bb1d96215785f7e7314"

  depends_on "asn1c" => :build
  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "libarchive" => :build
  depends_on "libsodium" => :build
  depends_on "pkgconfig" => :build
  depends_on "openssl" => :build
  depends_on "python3" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    
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
