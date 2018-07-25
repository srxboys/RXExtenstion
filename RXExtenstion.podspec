

Pod::Spec.new do |s|

  s.name              = "RXExtenstion"
  s.version           = "0.0.0.1"
  s.summary           = "iOS 项目基本框架"
  s.description       = <<-DESC
                        iOS 项目基本框架(label自适应高度、菜单功能、地址选择器、日期时间选择器、自动生成假数据......)
                        /
                        iOS Project basic framework (Label adaptive height, menu function, 
                                    address selector, date time selector, 
                                    automatic generation of false data, etc.).

                        -----------------------------------------------------------------------------

                        - Subspecs:
                           - RXExComment       (通用的)[包括:UIColor(颜色处理)、random(随机假数据)]
                           - RXExRXUUID        (实现设备唯一标识) 
                           - RXExTranslation   (简单转换 --- 还在构思中...) 
                           - RXExGradient      (颜色渐变) 
                           - RXExRXPickerView  (选择滚动器) 

 						-----------------------------------------------------------------------------
                        Example 1:  

                        pod 'RXExtenstion', :subspecs => [
					         'RXExRXUUID',
					         'RXExTranslation',
					         'RXExGradient',
					         'RXExRXBlockTextField',
					         'RXExRXPickerView'
					    ]

					    -----------------------------------------------------------------------------
                        Example 2:  (Notice the subspecs in each version number)

                        pod 'RXExtenstion', '0.0.0.1', :subspecs => [
					         'RXExRXUUID',             
					         'RXExTranslation',        
					         'RXExGradient',           
					         'RXExRXBlockTextField',   
					         'RXExRXPickerView'        
					    ]
                         DESC

  s.homepage          = "https://github.com/srxboys/RXExtenstion.git"
  s.license           = "MIT"
  s.author            = { "srxboys" => "srxboys@126.com" }
  s.platform          = :ios, "8.0"
  s.source            = { :git => "https://github.com/srxboys/RXExtenstion.git", :tag => "#{s.version}" }
  s.requires_arc      = true
  s.default_subspec   = "RXExComment"


  s.subspec "RXExComment" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/{UIColor/*,random/*,*}.{h,m}"
    ss.header_dir     = "RXExComment"
  end

  s.subspec "RXExRXUUID" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/RXUUID/**/*.{h,m}"
    ss.header_dir     = "RXExRXUUID"
    ss.framework      = "Security"
  end

  s.subspec "RXExTranslation" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/Translation/**/*.{h,m}"
    ss.header_dir     = "RXExTranslation"
    ss.framework      = "QuartzCore"
  end

  s.subspec "RXExGradient" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/Gradient/**/*.{h,m}"
    ss.header_dir     = "RXExGradient"
  end

  s.subspec "RXExRXBlockTextField" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/RXBlockTextField/**/*.{h,m}"
    ss.header_dir     = "RXExRXBlockTextField"
  end

  s.subspec "RXExRXPickerView" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/RXDatePicker/**/RXPickerView.{h,m}"
    ss.header_dir     = "RXExRXPickerView"
  end




  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
