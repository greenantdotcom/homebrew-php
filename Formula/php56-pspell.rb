require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php56Pspell < AbstractPhp56Extension
  init
  homepage 'http://php.net/manual/en/book.pspell.php'
  url 'http://www.php.net/get/php-5.5.8.tar.bz2/from/this/mirror'
  sha1 '94800df241864a2c66fd01adca3d22247dc1a8d5'
  version '5.5.8'

  depends_on 'aspell'

  def install
    Dir.chdir "ext/pspell"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--with-pspell=#{Formula.factory('aspell').opt_prefix}"
    system "make"
    prefix.install "modules/pspell.so"
    write_config_file unless build.include? "without-config-file"
  end
end
