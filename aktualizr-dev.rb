class AktualizrDev < Formula
  desc "C++ Client for HERE OTA Connect, current dev version"

  head "https://github.com/advancedtelematic/aktualizr.git"

  depends_on "openssl@1.1"
  depends_on "curl-openssl"
  depends_on "asn1c"
  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "libarchive"
  depends_on "libsodium"
  depends_on "pkgconfig" => :build
  depends_on "python3" => :build

  keg_only "Don't interfere with a release version, this is current dev version of Aktualizr"

  def install
   brew link --force  mkdir "build" do
      git_revision = `git rev-parse --short HEAD`.chomp
      system "cmake", "..",
                      "-DAKTUALIZR_VERSION=dev-#{git_revision}",
                      "-DCMAKE_INSTALL_PREFIX=#{prefix}",
                      "-DBoost_USE_MULTITHREADED=ON",
                      "-DOPENSSL_SSL_LIBRARY=#{Formula["openssl@1.1"].opt_prefix}/lib/libssl.dylib",
                      "-DOPENSSL_CRYPTO_LIBRARY=#{Formula["openssl@1.1"].opt_prefix}/lib/libcrypto.dylib",
                      *std_cmake_args

      system "make", "install", "-j#{ENV.make_jobs}"
    end
  end


  test do
    system "#{bin}/aktualizr --help"
  end
end
