require File.join(File.dirname(__FILE__), 'abstract-php')

class Php56 < AbstractPhp
  init
  
  PHP_SRC_TARBALL = 'http://downloads.php.net/tyrael/php-5.6.0alpha1.tar.bz2'
  PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
  PHP_VERSION     = '5.6.0-alpha.1'
  PHP_BRANCH      = 'PHP-5.6'
  
  PHP_CHECKSUM    = {
                      :md5    => 'd1ac1df6ff701546a005e2d9799d2002',
                      :sha1   => '08dec1cd5ef3acccaafd7ca79f5a8b22643e7d65',
                      :sha256 => '17123fd1b07aa1cd16eedc9ae653dfbd560e2b7da95961f546334fda14bba804',
                    }
  
  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  # Leopard requires Hombrew OpenSSL to build correctly
  depends_on 'openssl' if MacOS.version == :leopard

  def install_args
    args = super
    args << "--with-homebrew-openssl" if MacOS.version == :leopard
    args + [
      "--enable-zend-signals",
      "--enable-dtrace",
      "--enable-opcache",
      ## Causing issues on Mavericks (10.9.1)
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
