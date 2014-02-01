require File.join(File.dirname(__FILE__), 'abstract-php')

class Php56 < AbstractPhp
  init
  url 'http://downloads.php.net/tyrael/php-5.6.0alpha1.tar.bz2'
  sha256 '17123fd1b07aa1cd16eedc9ae653dfbd560e2b7da95961f546334fda14bba804'
  version '5.6.0alpha1'

  head 'https://github.com/php/php-src.git', :branch => 'PHP-5.6'

  # Leopard requires Hombrew OpenSSL to build correctly
  depends_on 'openssl' if MacOS.version == :leopard

  def install_args
    args = super
    args << "--with-homebrew-openssl" if MacOS.version == :leopard
    args + [
      "--enable-zend-signals",
      "--enable-dtrace",
      "--enable-opcache",
      "--disable-phpdbg"
    ]
  end

  def php_version
    5.6
  end

  def php_version_path
    56
  end
end
