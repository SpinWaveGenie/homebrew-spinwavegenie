class Spinwavegenie < Formula
  desc "Library for simplifying linear spin wave calculations"
  homepage "https://github.com/SpinWaveGenie/SpinWaveGenie"
  url "https://github.com/SpinWaveGenie/SpinWaveGenie/releases/download/v0.2.1/SpinWaveGenie-0.2.1.tar.gz"
  sha256 "ee125a20c84112f3dc92b904d7a51c4f5b65b0a72191d574f037cfa9c7dbabc8"
  head "https://github.com/SpinWaveGenie/SpinWaveGenie.git", :branch => "master"

  option "without-test", "skip build-time testss (not recommended)"

  depends_on "cmake" => :build
  depends_on "eigen"
  depends_on "boost"
  depends_on "tbb"
  depends_on :python if build.head?
  depends_on "homebrew/science/nlopt" => :optional

  def install
    cmake_args = std_cmake_args
    cmake_args << "-DBUILD_TESTING=ON" if build.with? "test"
    cmake_args << "-DPYBIND11_PYTHON_VERSION=2.7" if build.head?
    cmake_args << "-DPYTHON_SITE_PACKAGES_DIR=lib/python2.7/site-packages" if build.head?
    system "cmake", ".", *cmake_args
    system "make"
    system "make", "test" if build.with? "test"
    system "make", "install"
    if build.head?
      site_packages = "lib/python2.7/site-packages"
      pth_contents = "#{prefix}/lib/python2.7/site-packages\n"
      (prefix/site_packages/"homebrew-spinwavegenie.pth").write pth_contents
    end
  end

  test do
    system "true"
  end
end
