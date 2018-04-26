
Pod::Spec.new do |spec|
  spec.name                   = 'ZRouter'
  spec.version                = '1.0.0'
  spec.license                = { :type => 'MIT', :file => 'LICENSE' }
  spec.summary                = 'A common router tool'
  spec.homepage               = 'https://github.com/lzackx/ZRouter'
  spec.author                 = { 'lzackx' => 'zackx@foxmail.com' }
  spec.source                 = { :git => 'https://github.com/lzackx/ZRouter.git', :tag => spec.version }
  spec.ios.deployment_target  = '8.0'
  spec.source_files           = 'ZRouter/ZRouter/*.{m,h}'
  spec.private_header_files   = 'ZRouter/ZRouter/ZRouterPrivate.h'
  spec.resources              = 'ZRouter/ZRouter/*.{plist}'
  spec.frameworks             = 'UIKit', 'Foundation'

end
