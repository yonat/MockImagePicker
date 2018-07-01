
Pod::Spec.new do |s|

  s.name         = "MockImagePicker"
  s.version      = "1.0.0"
  s.summary      = "Mock UIImagePickerController for use in simulator."

  s.homepage     = "https://github.com/yonat/MockImagePicker"
  s.screenshots  = "https://raw.githubusercontent.com/yonat/MockImagePicker/master/Screenshots/MockImagePicker.png"

  s.license      = { :type => "MIT", :file => "LICENSE.txt" }

  s.author             = { "Yonat Sharon" => "yonat@ootips.org" }
  s.social_media_url   = "http://twitter.com/yonatsharon"

  s.swift_version = '4.0'
  s.platform     = :ios, "9.3"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/yonat/MockImagePicker.git", :tag => s.version }
  s.source_files  = "Sources/*.swift"

  s.dependency 'MiniLayout'

end
