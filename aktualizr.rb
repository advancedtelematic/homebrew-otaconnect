class Aktualizr < Formula
  desc "C++ Client for HERE OTA Connect"
  homepage ""
  version "2019.11"
  url "https://github.com/advancedtelematic/aktualizr.git", :using => :git, :tag => "#{version}"
  sha256 "782fa343c85be455d6e51bd774f3244e0dad093989ac9bb1d96215785f7e7314"

  depends_on "asn1c"
  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "libarchive"
  depends_on "libsodium"
  depends_on "curl-openssl"
  depends_on "libp11"
  depends_on "pkgconfig" => :build
  depends_on "openssl@1.1"
  depends_on "python3" => :build


  def install
    mkdir "build" do
      openssl = Formula["openssl@1.1"]
      system "cmake", "..", "-DCMAKE_PREFIX_PATH=#{openssl.opt_prefix};$CMAKE_PREFIX_PATH",
                            "-DWARNING_AS_ERROR=OFF",
                            *std_cmake_args
      system "make"
      system "mkdir", "-p", "#{bin}"
      system "cp", "./src/aktualizr_primary/aktualizr", "#{bin}/aktualizr"
    end
  end

  test do
    system "#{bin}/aktualizr --help"
  end
end
