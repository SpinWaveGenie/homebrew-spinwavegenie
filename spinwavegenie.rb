class Spinwavegenie < Formula
  desc "Library for simplifying linear spin wave calculations"
  homepage "https://github.com/SpinWaveGenie/SpinWaveGenie"
  url "https://github.com/SpinWaveGenie/SpinWaveGenie/releases/download/v0.3.0/SpinWaveGenie-0.3.0.tar.gz"
  sha256 "689ed2e5a2942b1ace500b0f78e5a72697f9010ac47ad9f0e5853d7da9e836c5"
  head "https://github.com/SpinWaveGenie/SpinWaveGenie.git", :branch => "master"

  option "without-test", "skip build-time tests (not recommended)"

  depends_on "cmake" => :build
  depends_on "eigen"
  depends_on "boost"
  depends_on "tbb"
  depends_on "python@2" => :recommended
  depends_on "python" => :recommended

  def install
    Language::Python.each_python(build) do |_python, version|
      cmake_args = std_cmake_args
      cmake_args << "-DUSE_SYSTEM_EIGEN=ON"
      cmake_args << "-DBUILD_TESTING=ON" if build.with? "test"
      cmake_args << "-DPYBIND11_PYTHON_VERSION=#{version}"
      cmake_args << "-DPYTHON_SITE_PACKAGES_DIR=lib/python#{version}/site-packages"
      Dir.mkdir("#{buildpath}/python#{version}")
      Dir.chdir("#{buildpath}/python#{version}")
      system "cmake", *cmake_args, "../"
      system "make"
      system "make", "test" if build.with? "test"
      system "make", "install"
      site_packages = "lib/python#{version}/site-packages"
      pth_contents = "#{prefix}/lib/python#{version}/site-packages\n"
      (prefix/site_packages/"homebrew-spinwavegenie.pth").write pth_contents
    end
  end

  test do
    system "true"
  end
end
