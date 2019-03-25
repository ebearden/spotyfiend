# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Spotyfiend' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Spotyfiend
  pod 'SpotifyKit', :git => 'https://github.com/ebearden/SpotifyKit.git', :commit => 'f66c134495cd1a4f67d5ccbbf7aaa64f67b9f796'
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'Firebase/Auth'
  pod 'GoogleSignIn'

  target 'SpotyfiendCore' do
    pod 'SpotifyKit', :git => 'https://github.com/ebearden/SpotifyKit.git', :commit => 'f66c134495cd1a4f67d5ccbbf7aaa64f67b9f796'
    pod 'Firebase/Core'
    pod 'Firebase/Firestore'
    pod 'Firebase/Auth'
    pod 'GoogleSignIn'
  end

  target 'SpotyfiendTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SpotyfiendUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
