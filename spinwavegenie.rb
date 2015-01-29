require "formula"

class Spinwavegenie < Formula
  homepage "https://github.com/SpinWaveGenie/SpinWaveGenie"
  url "https://github.com/SpinWaveGenie/SpinWaveGenie.git", :branch => "master"
  version "0.1.0"

  depends_on "cmake" => :build
  depends_on "eigen"
  depends_on "boost" => "c++11"
  depends_on "tbb" => "c++11"
  depends_on "nlopt" => :optional
  option "without-check", "skip build-time checks (not recommended)"

  def install
    system "cmake", ".", *std_cmake_args, "-DBUILD_TESTING=ON"
    system "make"
    system "make install"
    system "make", "test" if build.with? "check"
  end

  test do
    system "true"
  end
end
