Pod::Spec.new do |s|
    s.name              = 'RocketAlert'
    s.version           = '1.0-beta.3'
    s.summary           = 'User friendly, Modular and Modern iOS Alert View'
    s.homepage          = 'https://github.com/peppesapienza/Rocket-Alert'

    s.author            = { 'Giuseppe Sapienza' => 'giuseppe.sapienza@xcoding.it' }
    s.license           = { :type => 'Apache-2.0', :file => 'LICENSE' }

    s.platform          = :ios

    s.source            = { :git => 'https://github.com/peppesapienza/Rocket-Alert.git', :tag => '1.0-beta.3' }
    s.requires_arc = true

    s.ios.frameworks = 'Foundation', 'UIKit'
    s.ios.deployment_target = '10.0'
    s.ios.source_files = "RocketAlert/*.swift", "RocketAlert/**/*.{h,m,swift,plist}"
end
