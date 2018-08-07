Pod::Spec.new do |s|
  s.name     = 'LattisSDK'
  s.version  = '1.1.0'
  s.license  = { :type => 'MIT', :file => 'LICENSE.md' }
  s.summary  = 'Bluetooth connectivity implementation for Ellipse lock (Lattis inc.)'
  s.homepage = 'https://github.com/velolabs/lattis_sdk_ios_public'
  s.authors  = { 'Ravil Khusainov' => 'ravil@lattis.io' }
  s.source   = { :git => 'https://github.com/velolabs/lattis_sdk_ios_public.git' }
  s.requires_arc = true

  s.swift_version = '4.1'
  s.preserve_paths = '*.framework'
  s.ios.vendored_frameworks = 'CommonCrypto.framework'
  s.ios.vendored_frameworks = 'LattisSDK.framework'
  s.ios.vendored_frameworks = 'Oval.framework'
  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PODS_ROOT)/LattisSDK' }
  s.ios.deployment_target = '10.0'
  s.ios.frameworks = 'CoreBluetooth'
  s.dependency 'KeychainSwift'
end
