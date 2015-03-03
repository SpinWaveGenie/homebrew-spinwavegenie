require "formula"

class Spinwavegenie < Formula
  homepage "https://github.com/SpinWaveGenie/SpinWaveGenie"
  head "https://github.com/SpinWaveGenie/SpinWaveGenie.git", :branch => "master"

  depends_on "cmake" => :build
  depends_on "eigen"
  depends_on "boost" => "c++11"
  depends_on "tbb" => "c++11"
  depends_on "nlopt" => :optional
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
