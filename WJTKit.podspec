#
# Be sure to run `pod lib lint WJKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WJTKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of WJKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/tqhnet/WJKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tqhnet' => 'tqhnet@163.com' }
  s.source           = { :git => 'https://github.com/tqhnet/WJKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'WJKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WJKit' => ['WJKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # 此三方库需要依赖的其他CocoaPods仓库，可以依赖多个
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SVProgressHUD', '~> 2.0.4'
  s.dependency 'Masonry'
  s.dependency 'MJRefresh'
  s.dependency 'YYModel'
  s.dependency 'AFNetworking'
  s.dependency 'YYCache'
  
end
