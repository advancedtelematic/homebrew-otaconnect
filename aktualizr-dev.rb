class AktualizrDev < Formula
  desc "C++ Client for HERE OTA Connect"
  homepage ""
  version = "2020.2"
  url "https://github.com/advancedtelematic/aktualizr.git", :using => :git, :tag => "#{version}"
  sha256 "782fa343c85be455d6e51bd774f3244e0dad093989ac9bb1d96215785f7e7314"

  depends_on "openssl@1.1"
  depends_on "curl-openssl"
  depends_on "asn1c"
  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "libarchive"
  depends_on "libsodium"
  depends_on "pkgconfig" => :build
  depends_on "python3" => :build

  bottle do
    cellar :any
    sha256 "021255fc3b2b7409ab649adeb0abdb71efec564519ca7d0a6ad36d92abc9f8b6" => :catalina
  end

  def install
    mkdir "build" do
      system "cmake", "..", "-DBoost_USE_MULTITHREADED=ON", "-DOPENSSL_SSL_LIBRARY=#{Formula["openssl@1.1"].opt_prefix}/lib/libssl.dylib", "-DOPENSSL_CRYPTO_LIBRARY=#{Formula["openssl@1.1"].opt_prefix}/lib/libcrypto.dylib", *std_cmake_args

      system "make",  "-j#{ENV.make_jobs}"

      system "mkdir", "-p", "#{bin}"
      system "mkdir", "-p", "#{lib}"

      system "cp", "./src/aktualizr_primary/aktualizr", "#{bin}/aktualizr-dev"
      system "cp", "./src/libaktualizr/libaktualizr_lib.dylib", "#{lib}"
    end
  end

  test do
    system "#{bin}/aktualizr --help"
  end
end
