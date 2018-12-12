

Pod::Spec.new do |s|

  s.name              = "RXExtenstion"
  s.version           = "0.0.0.2"
  s.summary           = "iOS 项目基本框架"
  s.description       = <<-DESC
                        iOS 项目基本框架(label自适应高度、菜单功能、地址选择器、日期时间选择器、自动生成假数据......)
                        /
                        iOS Project basic framework (Label adaptive height, menu function, 
                                    address selector, date time selector, 
                                    automatic generation of false data, etc.).

                        -----------------------------------------------------------------------------

                        - Subspecs:
                           - RXComment        (通用的)[包括:UIColor(颜色处理)、random(随机假数据)]
                           - RXUUID           (实现设备唯一标识)
                           - RXTranslation    (简单转换 --- 还在构思中...)
                           - RXGradient       (颜色渐变)
                           - RXBlockTextField (功能输入框)
                           - RXPickerView     (选择滚动器)
                           - RXAlertView      (系统Alert封装)
                           - RXSwizzle        (runtime Swizzle)

 						-----------------------------------------------------------------------------
                        Example 1:  

                        pod 'RXExtenstion', :subspecs => [
					         'RXUUID',
					         'RXTranslation',
					         'RXGradient',
					         'RXBlockTextField',
					         'RXPickerView',
                             'RXAlertView',
                             'RXSwizzle'
					    ]

					    -----------------------------------------------------------------------------
                        Example 2:  (Notice the subspecs in each version number)

                        pod 'RXExtenstion', '0.0.0.2', :subspecs => [
					         'RXUUID',
					         'RXGradient',
					         'RXBlockTextField',
					         'RXPickerView'
					    ]
                         DESC

  s.homepage          = "https://github.com/srxboys/RXExtenstion.git"
  s.license           = "MIT"
  s.author            = { "srxboys" => "srxboys@126.com" }
  s.platform          = :ios, "8.0"
  s.source            = { :git => "https://github.com/srxboys/RXExtenstion.git", :tag => "#{s.version}" }
  s.requires_arc      = true
  s.default_subspec   = "RXComment"


  s.subspec "RXComment" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/{UIColor/*,random/*,*}.{h,m}"
    ss.header_dir     = "RXComment"
  end

  s.subspec "RXUUID" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/RXUUID/**/*.{h,m}"
    ss.header_dir     = "RXUUID"
    ss.framework      = "Security"
  end

  s.subspec "RXTranslation" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/Translation/**/*.{h,m}"
    ss.header_dir     = "RXTranslation"
    ss.framework      = "QuartzCore"
  end

  s.subspec "RXGradient" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/Gradient/**/*.{h,m}"
    ss.header_dir     = "RXGradient"
  end

  s.subspec "RXBlockTextField" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/RXBlockTextField/**/*.{h,m}"
    ss.header_dir     = "RXBlockTextField"
  end

  s.subspec "RXPickerView" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/RXDatePicker/**/RXPickerView.{h,m}"
    ss.header_dir     = "RXPickerView"
  end

  s.subspec "RXAlertView" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/RXAlert/**/*.{h,m}"
    ss.header_dir     = "RXAlertView"
  end

  s.subspec "RXSwizzle" do |ss|
    ss.source_files   = "RXExtenstion/RXExtenstion/runtime/**/NSObject+RXSwizzle.{h,m}"
    ss.header_dir     = "RXSwizzle"
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
