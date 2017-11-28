Pod::Spec.new do |s|
  s.name = 'CLHUD'
  s.version = '1.0.6'
  s.license = 'MIT'
  s.summary = 'This is a loadding'
  s.homepage = 'https://github.com/Darren-chenchen/CLHUD'
  s.authors = { 'Darren-chenchen' => '1597887620@qq.com' }
  s.source = { :git => 'https://github.com/Darren-chenchen/CLHUD.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Loadding/CLHUD/**/*.swift'
  s.resource_bundles = { 
	'Loadding' => ['Loadding/CLHUD/resource/**/*.gif']
  }
end
