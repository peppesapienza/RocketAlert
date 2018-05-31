Pod::Spec.new do |s|
    s.name              = 'RocketAlert'
    s.version           = '0.1.0'
    s.summary           = 'User friendly, Modular and Modern iOS Alert View'
    s.homepage          = 'https://github.com/peppesapienza/Rocket-Alert'

    s.author            = { 'Giuseppe Sapienza' => 'giuseppe.sapienza@xcoding.it' }
    s.license           = { :type => 'Apache-2.0', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :git => 'https://github.com/peppesapienza/Rocket-Alert.git', tag: 0.1.0 }

    s.ios.frameworks = 'Foundation', 'UIKit'
    s.ios.deployment_target = '10.0'
    s.source_files = "RocketAlert", "RocketAlert/**/*.{h,m,swift}"
end
