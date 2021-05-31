# Uncomment the next line to define a global platform for your project
 platform :ios, '13.2'

def utilities_pods
  # Pods for Belba2i
  pod 'SwifterSwift', '~> 5.2.0'
  pod 'Kingfisher' # Image Downloading and caching
  pod 'RxSwift' # Using Reactive Programming for shorter code
  pod 'RxCocoa'
  pod 'PhoneNumberKit' # Handling Common PhoneNumber Problems
  pod 'SnapKit', '~> 5.0.0' # Faster UI Building by Code
  pod 'KeychainSwift', '~> 19.0' # For Encrypted Storage
  pod 'R.swift', '~> 5.2.2' # Better Resources Management, just like Android's
  pod 'IQKeyboardManagerSwift', '~> 6.5' # Easier Keyboard Manipulation
  pod 'Moya/RxSwift', '~> 14.0' # Moya + RxSwift to be able to do complex stuff
  pod 'PKHUD', '~> 5.3' # Generic Loader Pod
  pod 'SwiftMessages' # For Giving User some system messages
  pod 'SwiftEntryKit' # For Showing users nice popups, alerts and ratings views
  pod 'Carbon', '~> 1.0.0-rc.6' # For Faster UI Building by Code and butter-smooth UI
  pod 'PopupDialog', '~> 1.1' # For presenting popups with ease
  pod 'SVPinView' # For ease of handling OTPs
  pod 'AppCenter' # For Continous Integration & Delivery (For MVP Stage it's just Delivery)
  pod 'BiometricAuthentication' # For Security of the user when switching between apps
end

def firebase_pods
  pod 'Firebase/Auth' # Authentication Pod through Firebase
end

target 'RamySDK' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RamySDK
  utilities_pods
end

target 'RamySDKTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'RamySDKUITests' do
  # Pods for testing
end
