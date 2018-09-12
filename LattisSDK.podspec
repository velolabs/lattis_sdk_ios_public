Pod::Spec.new do |s|
  s.name     = 'LattisSDK'
  s.version  = '2.0.1'
  s.license  = { :type => 'MIT', :file => 'LICENSE.md' }
  s.summary  = 'Bluetooth connectivity implementation for Ellipse lock (Lattis inc.)'
  s.homepage = 'https://github.com/velolabs/lattis_sdk_ios_public'
  s.authors  = { 'Ravil Khusainov' => 'ravil@lattis.io' }
  s.source   = { :git => 'https://github.com/velolabs/lattis_sdk_ios_public.git', :tag => "v{s.version}" }

  s.swift_version = '4.1'
  s.platform = :ios
  s.ios.vendored_frameworks = 'LattisSDK.framework', 'Oval.framework'
  s.ios.deployment_target = '10.0'
  s.ios.frameworks = 'CoreBluetooth'
  s.dependency 'CryptoSwift'
end
