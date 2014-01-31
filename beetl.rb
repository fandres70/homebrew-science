require 'formula'

class Beetl < Formula
  homepage 'https://github.com/BEETL/BEETL'
  url 'https://github.com/BEETL/BEETL/archive/BEETL-0.9.0.tar.gz'
  sha1 '545e23e8132af297a6c39c10410a0d0ca392b38c'

  depends_on 'boost' => :optional
  depends_on 'seqan' => :optional

  fails_with :clang do
    build 500
    cause 'Requires OpenMP'
  end

  def install
    boost = Formula.factory('boost').opt_prefix
    seqan = Formula.factory('seqan').opt_prefix/'include'
    args = [
      '--disable-dependency-tracking',
      '--disable-silent-rules',
      "--prefix=#{prefix}"]
    args << "--with-boost=#{boost}" if build.with? 'boost'
    args << "--with-seqan=#{seqan}" if build.with? 'seqan'
    system './configure', *args
    system 'make', 'install'
  end

  test do
    system 'beetl --version'
  end
end
