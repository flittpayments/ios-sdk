#
# Be sure to run `pod lib lint Flitt.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = "Flitt"
  s.version          = "1.2.2"
  s.summary          = "Library for accepting payments directly from iOS application's clients."

  s.homepage         = "https://github.com/flittpayments/ios-sdk"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Maxim Kozenko" => "mkozenko@flitt.com" }
  s.source           = { :git => "https://github.com/flittpayments/ios-sdk.git", :tag => s.version.to_s }

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Cloudipsp/*.{h,m}'
  s.resources	= 'Cloudipsp/*.xib'
  s.frameworks = 'UIKit', 'PassKit'
end
