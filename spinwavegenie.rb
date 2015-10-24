require "formula"

class Spinwavegenie < Formula
  homepage "https://github.com/SpinWaveGenie/SpinWaveGenie"
  url "http://github.com/SpinWaveGenie/SpinWaveGenie/releases/download/v0.2.1/SpinWaveGenie-0.2.1.tar.gz"
  sha256 "ee125a20c84112f3dc92b904d7a51c4f5b65b0a72191d574f037cfa9c7dbabc8"
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
