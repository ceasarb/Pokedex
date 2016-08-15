# Uncomment this line to define a global platform for your project
platform :ios, '10.0'

target 'Pokédex' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'Alamofire',
  :git => 'https://github.com/Alamofire/Alamofire.git',
  :branch => 'swift3'
  
  post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
    end
  end
end

end
