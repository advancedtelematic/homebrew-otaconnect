class Aktualizr < Formula
  desc "C++ Client for HERE OTA Connect"
  homepage "https://github.com/advancedtelematic/aktualizr"
  version = "2020.9"
  revision = "d4811f900c765f3b4e5b9ea76531bad7d830a691"

  url "https://github.com/advancedtelematic/aktualizr.git", using: :git, tag: version.to_s, revision: revision.to_s
  head "https://github.com/advancedtelematic/aktualizr.git"

  # in case of --HEAD brewing the global version attribute will be equal to HEAD-<short-latest-commit-hash-of-master>
  # in case of stable/default brewing the global version will be equal to the latest release tag

  bottle do
    root_url "https://github.com/advancedtelematic/aktualizr/releases/download/2020.9"
    cellar :any
    sha256 "35c0d3bece8fe1f7c9fc5f3f3a0545dc784071a0b9203281d6fa607ff271718a" => :mojave
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
