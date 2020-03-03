class Aktualizr < Formula
  desc "C++ Client for HERE OTA Connect"
  homepage "https://github.com/advancedtelematic/aktualizr.git"
  version = "2020.4"

  url "https://github.com/advancedtelematic/aktualizr.git", :using => :git, :tag => "#{version}", :revision => "deea9a4562e88c466a3b203a62891bdd9d558af3"
  head "https://github.com/advancedtelematic/aktualizr.git"

  # in case of --HEAD brewing the global version attribute will be equal to HEAD-<short-latest-commit-hash-of-master>
  # in case of stable/default brewing the global version will be equal to the latest release tag

  bottle do
    root_url "https://github.com/advancedtelematic/aktualizr/releases/download/2020.4"
    cellar :any
    sha256 "7e0a533908a79af650702a14ddcaedaff410294edaa4edc1ff0febb20baa8ace" => :mojave
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "python" => :build
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
