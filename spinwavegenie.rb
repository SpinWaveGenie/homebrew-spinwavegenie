require "formula"

class Spinwavegenie < Formula
  homepage "https://github.com/SpinWaveGenie/SpinWaveGenie"
  url "http://github.com/SpinWaveGenie/SpinWaveGenie/releases/download/v0.1.1/SpinWaveGenie-0.1.1.tar.gz"
  sha256 "731670a3a4107b3de064b54c3fd1c72f61b65385d783513b0cb7445f0b3c8ed9"
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
