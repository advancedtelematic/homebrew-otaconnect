class Aktualizr < Formula
  desc "C++ Client for HERE OTA Connect"
  homepage "https://github.com/advancedtelematic/aktualizr.git"
  version = "2020.7"
  revision = "cf44da79555d1897115eb350cbc43db1e213db03"

  url "https://github.com/advancedtelematic/aktualizr.git", :using => :git, :tag => version.to_s, :revision => revision.to_s
  head "https://github.com/advancedtelematic/aktualizr.git"

  # in case of --HEAD brewing the global version attribute will be equal to HEAD-<short-latest-commit-hash-of-master>
  # in case of stable/default brewing the global version will be equal to the latest release tag

  bottle do
    root_url "https://github.com/advancedtelematic/aktualizr/releases/download/2020.7"
    cellar :any
    sha256 "ec4c542b8d36f07ae68adc3d245fd9c0606395bee0629c36730ac096b90d2c15" => :mojave
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.8" => :build
  depends_on "asn1c"
  depends_on "boost"
  depends_on "curl-openssl"
  depends_on "libarchive"
  depends_on "libsodium"
  depends_on "openssl@1.1"

  def install
    args = %W[
      -DAKTUALIZR_VERSION=#{version}
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DBoost_USE_MULTITHREADED=ON
      -DOPENSSL_SSL_LIBRARY=#{Formula["openssl@1.1"].opt_prefix}/lib/libssl.dylib
      -DOPENSSL_CRYPTO_LIBRARY=#{Formula["openssl@1.1"].opt_prefix}/lib/libcrypto.dylib
    ]

    mkdir "build" do
      system "cmake", "..", *std_cmake_args, *args
      system "make", "install", "-j#{ENV.make_jobs}"
    end
  end

  test do
    system "#{bin}/aktualizr --help"
  end
end
