UIImage UIImageView 处理妙招（圆角卡顿、SDWebImage下载动画, 下载后展示动画

创建时间:2016.7.9

我尽量找出原创

1、 tableView cell 中的 UIImageView 圆角 后，滑动 MJRefresh 自动滑动cell （用UIImageView + fadeinfadeout 渐变0-1显示） 圆角暂时失效（在渐变为1后才显示出圆角，中间有四方形变圆角的bug）的解决办法，用下面的

    支持原创 https://github.com/liuzhiyi1992/ZYCornerRadius
    #import "UIImageView+CornerRadius.h"

    UIImageView *imageViewThird = [[UIImageView alloc] initWithFrame:CGRectMake(130, 480, 150, 150)];
    [imageViewThird zy_cornerRadiusAdvance:20.f rectCornerType:UIRectCornerBottomRight | UIRectCornerTopLeft];
    [imageViewThird zy_attachBorderWidth:5.f color:[UIColor blackColor]];
    [self.view addSubview:imageViewThird];

2. UIImageView 跟随scrollView滑动 渐变模糊效果（一点点的模糊、一点点的还原）卡顿中我用到中是最好的

    #import "UIImage+BlurEffects.h"

    _backImg.image = [UIImage ty_imageByApplyingBlurToImage:_backImgBlur withRadius: 变化数字float类型的  tintColor:nil saturationDeltaFactor:1 maskImage:nil];

    变化数字float类型的 -->> 越大越模糊、为0是还原

3、UIImageView 用SDWebImage下载过程中 带有 下载动画 的
    支持原创 https://github.com/kevinrenskers/SDWebImage-ProgressView
    #import "UIImageView+ProgressView.h"（外国人写的，很出名，3年以前写的）

4、UIImageView 用SDWebImage下载后 渐变显示动画
    这个是 结合前辈 方法，我再次封装的
    https://github.com/srxboys/SDWebImage-FadeInFadeOut
    #import "UIImageView+fadeInFadeOut.h"







