class Aktualizr < Formula
  desc "C++ Client for HERE OTA Connect"
  homepage "https://github.com/advancedtelematic/aktualizr.git"

  head "https://github.com/advancedtelematic/aktualizr.git"

  version = "2020.3"

  url "https://github.com/advancedtelematic/aktualizr.git", :using => :git, :tag => "#{version}"

  # in case of --HEAD brewing the global version attribute will be equal to HEAD-<short-latest-commit-hash-of-master>
  # in case of stable/default brewing the global version will be equal to the latest release tag

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
    root_url "https://github.com/advancedtelematic/aktualizr/releases/download/2020.3"
    cellar :any
    sha256 "f42c799f7262f49a6debe2435254e14ef6bcc39b6168541a1fb09dffa6882f82" => :mojave
  end

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
