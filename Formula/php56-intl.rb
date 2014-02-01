require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php56Intl < AbstractPhp56Extension
  init
  homepage 'http://php.net/manual/en/book.intl.php'
  url 'http://downloads.php.net/tyrael/php-5.6.0alpha1.tar.bz2'
  sha256 '17123fd1b07aa1cd16eedc9ae653dfbd560e2b7da95961f546334fda14bba804'
  version '6.0.0a1'

  depends_on 'icu4c'

  def install
    Dir.chdir "ext/intl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-icu-dir=#{Formula.factory('icu4c').opt_prefix}",
                          "--enable-intl"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file unless build.include? "without-config-file"
  end
end
