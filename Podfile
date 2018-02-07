platform :ios, '7.0'

target 'RXExtenstion' do
	pod 'FMDB', '~> 2.7.2'

	pod 'AFNetworking', '~> 3.2.0'
	pod 'SDWebImage', '~> 4.2.3'

	pod 'IBActionSheet', '~> 0.0.4'
	pod 'MJRefresh', '~> 3.1.15.3'

	# 我自己写的库(发布自己的pod http://blog.csdn.net/srxboys/article/details/52983403)
	pod 'RXGetAddressBook', '~> 1.0.0'
	pod 'RXLabel', '~> 1.0.0'

	post_install do |installer|
	    installer.pods_project.build_configurations.each do |config|
	      config.build_settings['SYMROOT'] = '${SRCROOT}/../build'
	    end
  	end
end
