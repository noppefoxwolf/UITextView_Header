Pod::Spec.new do |s|
  s.name             = 'UITextView_Header'
  s.version          = '0.5.0'
  s.summary          = 'UITextView header view extension.'

  s.description      = <<-DESC
UITextView header view extension.
                       DESC

  s.homepage         = 'https://github.com/noppefoxwolf/UITextView_Header.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '🦊Tomoya Hirano' => 'noppelabs@gmail.com' }
  s.source           = { :git => 'https://github.com/noppefoxwolf/UITextView_Header.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/noppefoxwolf'

  s.ios.deployment_target = '8.0'

  s.source_files = 'UITextView_Header/Classes/**/*'
end
