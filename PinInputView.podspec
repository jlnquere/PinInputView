#
# Be sure to run `pod lib lint PinInputView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PinInputView'
  s.version          = '0.1.0'
  s.summary          = 'PinInputView is a simple UIControl to enter pin codes'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
PinInputView is an `UIControl` used to enter a pin code. The typical use case is two-factors authentication. 

This component is really simple to use. You can easily customize the fonts and colors. It resizes automatically according to its configuration.
### Features
- Custolizable font and color.
- As many digits as you need (from 1 to +∞).
- AutoLayout compatible (`intrinsicContentSize` updated according to the configuration).
- Interface-Builder compatible.
- Pure Swift 4.
- Open project: you have an issue or an idea ? Feel free to [create an issue](https://github.com/jlnquere/PinInputView/issues/new), or submit a PR :)

                       DESC

  s.homepage         = 'https://github.com/jlnquere/PinInputView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Julien Quéré' => 'julien@sinplicity.fr' }
  s.source           = { :git => 'https://github.com/jlnquere/PinInputView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jlnquere'

  s.ios.deployment_target = '9.0'

  s.source_files = 'PinInputView/Classes/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'PureLayout'
  s.swift_version = "4.0"
end
