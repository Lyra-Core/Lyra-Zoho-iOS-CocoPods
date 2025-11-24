#
# Be sure to run `pod lib lint LyraZoho.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LyraZoho'
  s.version          = '1.2.3'
  s.summary          = 'LyraZoho is an sdk that integrates Lyra with Zoho CRM.'

  s.homepage         = 'https://github.com/Lyra-Core/Lyra-Zoho-iOS-CocoPods'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Velocity Cubed'
  s.source           = { :git => 'https://github.com/Lyra-Core/Lyra-Zoho-iOS-CocoPods.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '17.0'

  s.source_files = 'LyraZoho/Classes/**/*'
  s.dependency 'Mobilisten', '~> 10.1.6'
  
  s.resource_bundles = {
    'LyraZoho' => ['LyraZoho/Assets/**/*.json']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
