class Aktualizr < Formula
  desc "C++ Client for HERE OTA Connect"
  homepage "https://github.com/advancedtelematic/aktualizr.git"

  head "https://github.com/advancedtelematic/aktualizr.git"

  # get the latest release tag
  version = `git ls-remote --tags https://github.com/advancedtelematic/aktualizr.git | cut -d/ -f3- | sort -t. -nk1,2 -k3 | awk '/^[^{]*$/{version=$1}END{print version}'`.strip

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
    root_url "https://github.com/advancedtelematic/aktualizr/releases/download/#{version}"
    cellar :any
    sha256 "021255fc3b2b7409ab649adeb0abdb71efec564519ca7d0a6ad36d92abc9f8b6" => :mojave
  end

  def install
    # double check that the version that has been checked out is the one that we expect
    if build.stable?
      # in case of a non HEAD brewing we want to build the latest stable release
      expected_version = `git describe --abbrev=0`.strip
    else
      # in case of a HEAD brewing we want to build the tip of master branch
      expected_version = ("HEAD-" + `git rev-parse --short HEAD`.strip)[0..11]
    end

    if expected_version != version
      odie "!!! Invalid version of aktualizr: expected #{expected_version} got #{version}"
    else
      ohai "!!! Building #{expected_version} version of aktualizr..."
    end

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
