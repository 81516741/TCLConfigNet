

Pod::Spec.new do |s|
  s.name             = 'TCLConfigNet'
  s.version          = '0.3.5'
  s.summary          = 'TCL 配网'


  s.description      = "TCL 快速配网优化SDK 配网就是快 就是稳"

  s.homepage         = 'https://github.com/81516741/TCLConfigNet'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '81516741@qq.com' => '81516741@qq.com' }
  s.source           = { :git => 'https://github.com/81516741/TCLConfigNet.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

# s.source_files = 'TCLConfigNet/Classes/**/*'
  s.vendored_frameworks = 'TCLConfigNet.framework'

end
