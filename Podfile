# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

use_frameworks!

def common_pods
  pod 'Alamofire', '~> 4.8.2'
  pod 'AlamofireNetworkActivityLogger'
  pod 'ReachabilitySwift'
  pod 'SwiftyJSON'
  pod 'SDWebImage'
end

def test_pods
  pod 'Nimble'
  pod 'Quick'
end

target 'Kitabisa Movie' do
  common_pods
end

target 'Kitabisa MovieTests' do
  common_pods
  test_pods
end
