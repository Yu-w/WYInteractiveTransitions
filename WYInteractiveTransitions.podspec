#
# Be sure to run `pod lib lint WYInteractiveTransitions.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "WYInteractiveTransitions"
  s.version          = "0.1.5"
  s.summary          = "WYInteractiveTransitions provides custimzed interactive transitions between view controllers in one line of code."
  s.description      = <<-DESC
                        WYInteractiveTransitions are called when view controller transitions take place.
                        * PresentViewControlles
                        * DismissViewController
                        * PerformSegueWithIdentifier & PrepareForSegue
                        * etc...
                       DESC
  s.homepage         = "https://github.com/yuwang17/WYInteractiveTransitions"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Yu Wang" => "wangyu2165@gmail.com" }
  s.source           = { :git => "https://github.com/yuwang17/WYInteractiveTransitions.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'WYInteractiveTransitions' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
