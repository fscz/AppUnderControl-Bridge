#
# Be sure to run `pod lib lint AppUnderControl-Bridge.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AppUnderControl_Bridge"
  s.version          = "0.1.0"
  s.summary          = "A pod that provides library functions for applications that want to conform to the AppUnderControl Security Protocol"

  s.description      = <<-DESC
AppUnderControl is a security protocl intended for enterprise iOS apps that require special permission to run. To this end an iOS Application 'AppUnderControl' witch a corresponding' WatchKit app is installed and a pairing between the two is created. Apps that conform to the security protocol ask 'AppUnderControl' for permission to run. The request is sent to the paired AppleWatch and needs to be accepted or declined from there. In case permission is granted the requesting application is notified, along with a security token. The original app must verify the delivered security token and may run only, if it is correct.

This pod encapsulates all functionality needed by an application that aims to conform to the protocol, namely:
- call to ask for permission
- listener for answer, along with token
- verification of the delivered token
- callback for successful verfification of token
                       DESC

  s.homepage         = "https://github.com/fscz/AppUnderControl-Bridge"
  s.license          = 'MIT'
  s.author           = { "Fabian Schuetz" => "fabian.m.schuetz@googlemail.com" }
  s.source           = { :git => "https://github.com/fscz/AppUnderControl-Bridge.git", :tag => s.version.to_s }

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'AppUnderControl-Bridge' => ['Pod/Assets/*.png']
  }

  #s.module_map = "Pod/modulemaps/CommonCrypto/module.modulemap"
  #s.preserve_path = 'module/module.modulemap'
  #s.module_map = 'module/module.modulemap'
  #s.pod_target_xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/AppUnderControl-Bridge/module' }
  #s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2 $(PODS_ROOT)/AppUnderControl-Bridge/module' }

  #s.pod_target_xcconfig = { 'SWIFT_INCLUDE_PATHS' => '$(PROJECT_DIR)/../../Pod/modulemaps', 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
  s.dependency 'CryptoSwift'
  s.dependency 'SwiftyBase64'
end
