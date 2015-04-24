require "formula"

class Spinwavegenie < Formula
  homepage "https://github.com/SpinWaveGenie/SpinWaveGenie"
  url "https://github.com/SpinWaveGenie/SpinWaveGenie/archive/v0.1.0.tar.gz"
  sha256 "ab7ee3ac3d86640cc0abc2e2aa0c2d8973337c3f5f957f5b14f9f9b5b94d6956"
  head "https://github.com/SpinWaveGenie/SpinWaveGenie.git", :branch => "master"

  depends_on "cmake" => :build
  depends_on "eigen"
  depends_on "boost" => "c++11"
  depends_on "tbb" => "c++11"
  depends_on "homebrew/science/nlopt" => :optional
  option "without-check", "skip build-time checks (not recommended)"

  def install
    cmake_args = std_cmake_args
    cmake_args << "-DBUILD_TESTING=ON" if build.with? "check"
    system "cmake", ".", *cmake_args
    system "make"
    system "make", "test" if build.with? "check"
    system "make install"
  end

  test do
    system "true"
  end
end
