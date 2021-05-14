
Pod::Spec.new do |spec|
  spec.name                   = 'Zouter'
  spec.version                = '2.0.0'
  spec.license                = { :type => 'MIT', :file => 'LICENSE' }
  spec.summary                = 'A common router tool'
  spec.homepage               = 'https://github.com/lzackx/Zouter'
  spec.author                 = { 'lzackx' => 'zackx@foxmail.com' }
  spec.source                 = { :git => 'https://github.com/lzackx/Zouter.git', :tag => spec.version }
  spec.ios.deployment_target  = '8.0'
  spec.source_files           = 'Zouter/Classes/*.{m,h}'
  spec.private_header_files   = 'Zouter/Classes/*Private.h'
  spec.frameworks             = 'UIKit', 'Foundation'
  spec.dependency "ZKit/core"
  spec.dependency "CTMediator"
end
