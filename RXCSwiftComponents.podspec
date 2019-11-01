Pod::Spec.new do |spec|

  spec.name         = "RXCSwiftComponents"
  spec.version      = "1.0"

  spec.author       = { "ruixingchen" => "rxc@ruixingchen.com" }

  spec.summary      = "some swift components and extensions, 平淡且枯燥"
  spec.description  = "some swift components and extensions, 平淡且枯燥"
  spec.homepage     = "https://github.com/ruixingchen/RXCSwiftComponents"
  spec.license      = "MIT"

  spec.source       = { :git => "https://github.com/ruixingchen/RXCSwiftComponents.git", :tag => spec.version.to_s }
  #spec.source_files  = "Source/*.swift"

  spec.requires_arc = true
  spec.swift_versions = "5.1"
  spec.ios.deployment_target = '9.0'

  spec.default_subspecs = 'Core'
  
  spec.subspec 'Core' do |subspec|
    subspec.ios.source_files = 'Source/Core/**/*.swift'
    subspec.ios.frameworks = 'Foundation', 'UIKit', 'CoreGraphics'
  end

  spec.subspec 'Texture' do |subspec|
    subspec.dependency 'Texture', '~> 2.8'

    subspec.ios.source_files = 'Source/ASDK/**/*.swift'
    subspec.ios.frameworks = 'UIKit'
  end

  spec.subspec 'MJRefresh' do |subspec|
    subspec.dependency 'MJRefresh', '~> 3.2'

    subspec.ios.source_files = 'Source/MJRefresh/**/*.swift'
    subspec.ios.frameworks = 'UIKit'
  end

end
