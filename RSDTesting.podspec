#
# Be sure to run `pod lib lint RSDTesting.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RSDTesting"
  s.version          = "0.1.11"
  s.summary          = "Helper code for tests written in Swift."

  s.description      = <<-DESC
Testing helpers for asynchronous code, faking, mocking, and swizzling
                       DESC

  s.homepage         = "https://github.com/RaviDesai/RSDTesting"
  s.license          = 'MIT'
  s.author           = { "RaviDesai" => "ravidesai@me.com" }
  s.source           = { :git => "https://github.com/RaviDesai/RSDTesting.git", :tag => s.version.to_s }

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  # s.resource_bundles = {
  #   'RSDTesting' => ['Pod/Assets/*.png']
  # }

  s.frameworks = 'UIKit', 'XCTest'
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
end
