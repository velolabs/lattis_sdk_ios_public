Pod::Spec.new do |s|
  s.name     = 'LattisSDK'
  s.version  = '2.2.6'
  s.license  = { :type => 'MIT', :file => 'LICENSE.md' }
  s.summary  = 'Bluetooth connectivity implementation for Ellipse lock (Lattis inc.)'
  s.homepage = 'https://github.com/velolabs/lattis_sdk_ios_public'
  s.authors  = { 'Ravil Khusainov' => 'ravil@lattis.io' }
  s.source   = { :git => 'https://github.com/velolabs/lattis_sdk_ios_public.git', :tag => "v#{s.version}" }

  s.swift_version = '5.3'
#  s.platform = :ios
  s.vendored_frameworks = 'LattisSDK.xcframework'
  s.ios.deployment_target = '10.0'
  s.watchos.deployment_target = '4.0'
  s.frameworks = 'CoreBluetooth'
end
