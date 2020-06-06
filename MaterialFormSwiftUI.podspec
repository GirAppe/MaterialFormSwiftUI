Pod::Spec.new do |s|
    s.name             = 'MaterialFormSwiftUI'
    s.version          = '0.9.6'
    s.summary          = 'Material UI Text Field wrapper for SwiftUI.'
    s.description      = <<-DESC
    Defines reusable and observable Material text field component, that works both with UIKit (iOS 10+) and SwiftUI (iOS 13+).
                        DESC

    s.homepage         = 'https://github.com/GirAppe/MaterialFormSwiftUI.git'
    s.screenshots      = 'https://raw.githubusercontent.com/GirAppe/MaterialFormSwiftUI/0.9.6/material-form-light.gif', 'https://raw.githubusercontent.com/GirAppe/MaterialFormSwiftUI/0.9.6/material-form-dark.gif'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Andrzej Michnia' => 'amichnia@gmail.com' }
    s.source           = { :git => 'https://github.com/GirAppe/MaterialFormSwiftUI.git', :tag => s.version.to_s }

    s.ios.deployment_target = '13.0'
    s.tvos.deployment_target = '13.0'
    s.preserve_paths = '*'
    s.swift_versions = ['5.0', '5.1.2', '5.2.2']
    s.source_files = 'Sources/MaterialFormSwiftUI/**/*'
    s.frameworks = ['UIKit', 'SwiftUI']
    s.dependency 'MaterialForm'
end
