#
#  Be sure to run `pod spec lint DGDatePicker.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '10.0'
s.name = "DGDatePicker"
s.summary = "DGDatePicker is a modal date picker."
s.requires_arc = true

# 2
s.version = "1.0.2"

# 3
s.license = { :type => "proprietary", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Dimitris Georgiou" => "dgrgiou@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/dgrgiou/DGDatePicker"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/dgrgiou/DGDatePicker.git",
             :tag => "#{s.version}" }

# 7
s.dependency 'JTAppleCalendar', '~> 7.1.5'

# 8
s.source_files = "DGDatePicker/**/*.{swift}"

# 9
s.resources = "DGDatePicker/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "4.2"

end
