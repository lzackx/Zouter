
Pod::Spec.new do |spec|
  spec.name                   = 'Zouter'
  spec.version                = '1.1.0'
  spec.license                = { :type => 'MIT', :file => 'LICENSE' }
  spec.summary                = 'A common router tool'
  spec.homepage               = 'https://github.com/lzackx/Zouter'
  spec.author                 = { 'lzackx' => 'zackx@foxmail.com' }
  spec.source                 = { :git => 'https://github.com/lzackx/Zouter.git', :tag => spec.version }
  spec.ios.deployment_target  = '8.0'
  spec.source_files           = 'Zouter/Zouter/*.{m,h}'
  spec.private_header_files   = 'Zouter/Zouter/*Private.h'
  spec.resources              = 'Zouter/Zouter/*.{plist}'
  spec.frameworks             = 'UIKit', 'Foundation'

end
