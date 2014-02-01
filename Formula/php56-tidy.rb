require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php56Tidy < AbstractPhp56Extension
  init
  homepage 'http://php.net/manual/en/book.tidy.php'
  url 'http://downloads.php.net/tyrael/php-5.6.0alpha1.tar.bz2'
  sha256 '17123fd1b07aa1cd16eedc9ae653dfbd560e2b7da95961f546334fda14bba804'
  version '5.6.0a1'

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
