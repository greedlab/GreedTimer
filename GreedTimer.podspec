#
# Be sure to run `pod lib lint GreedTimer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GreedTimer"
  s.version          = "0.0.1"
  s.summary          = "GCD timer for iOS."
  s.homepage         = "https://github.com/greedlab/GreedTimer"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Bell" => "bell@greedlab.com" }
  s.source           = { :git => "https://github.com/greedlab/GreedTimer.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'

  #s.resource_bundles = {
  #  'GreedTimer' => ['Pod/Assets/*.png']
  #}
   s.resources = 'Pod/Assets/*.png'

  # s.prefix_header_file = 'Pod/Classes/GreedTimer.pch'
  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
