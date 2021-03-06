require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Tidy < AbstractPhp54Extension
  init
  homepage 'http://php.net/manual/en/book.tidy.php'
  url 'http://www.php.net/get/php-5.4.24.tar.bz2/from/this/mirror'
  sha1 '0f6c16e393a837b1576e3a332ade6ae7c1f5305b'
  version '5.4.24'

  def install
    Dir.chdir "ext/tidy"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file unless build.include? "without-config-file"
  end
end
