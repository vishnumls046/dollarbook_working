# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
platform :ios, '13.1'
target 'dollarbook' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'NVActivityIndicatorView'
  pod 'NVActivityIndicatorView/Extended'
  pod 'FloatingTabBarController'
  pod 'CGMath'
  pod 'Spring', :git => 'https://github.com/MengTo/Spring.git'
  pod 'SOTabBar'
  pod 'MSBBarChart'
  pod 'TaggerKit'
  pod 'IQKeyboardManagerSwift'
  pod 'TransitionButton'
  pod 'Alamofire'
  pod 'SwiftValidators'
  pod 'Fastis'
  pod 'NVActivityIndicatorView'
  pod 'Toaster'
  pod 'TagsList'
  pod 'GLWalkthrough'
  pod 'Kingfisher'
  pod 'OneSignalXCFramework', '>= 3.0.0', '< 4.0'
  pod 'PieCharts'
  pod 'RandomColorSwift'
  pod 'TagListView'
  pod 'KWVerificationCodeView'
  pod 'SwiftEntryKit'
end

target 'OneSignalNotificationServiceExtension' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'OneSignalXCFramework', '>= 3.0.0', '< 4.0'
end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.1'
    end
  end
end
