# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Hpx < Formula
  desc "The C++ standards library for concurrency and parallelism"
  homepage "http://stellar-group.org/libraries/hpx/"
  url "https://github.com/STEllAR-GROUP/hpx/archive/0.9.99.tar.gz"
  sha256 "84736ca5232225af4456c81fd3731a00cc3dffcbd3022973fe9d18d7e279918f"

  depends_on "cmake" => :build
  depends_on "boost@1.60"
  depends_on "homebrew/science/hwloc"
  depends_on "gperftools"

  def install
    mktemp do
      cmake_args = std_cmake_args
      cmake_args << "-DHPX_WITH_MALLOC=tcmalloc" 
      system "cmake", buildpath, *cmake_args
      system "make"
      system "make", "install" # if this fails, try separate make/make install steps
    end
  end

  test do
    system "wget", "http://stellar.cct.lsu.edu/files/hpx_0.9.0/src/examples/quickstart/hello_world.cpp"
    system "clang++", "hello_world.cpp"
  end
end
