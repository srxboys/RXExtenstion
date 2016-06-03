//
//  RXExpansionContractionCell.m
//  RXExtenstion
//
//  Created by srx on 16/6/3.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
// 存代码

#import "RXExpansionContractionCell.h"


#import "RXExpanCCellHeightModel.h"
#import "RXDataModel.h"

@interface RXExpansionContractionCell ()
{
    UILabel  * _titleLabel;
    UILabel  * _txtLabel;
    UIButton * _openButton;
    
    NSInteger  _thisRow;
}
@end

@implementation RXExpansionContractionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    NSLog(@"2222=%s", __FUNCTION__);
    
    if(self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_titleLabel];
        
        _txtLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _txtLabel.backgroundColor = [UIColor yellowColor];
        _txtLabel.numberOfLines=0;
        _txtLabel.font = [UIFont systemFontOfSize:TextFontSize];
        [self.contentView addSubview:_txtLabel];
        
        _openButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _openButton.frame = CGRectZero;
        _openButton.hidden = YES;
        _openButton.selected = NO;
        
        _openButton.backgroundColor = [UIColor blueColor];
        [_openButton setTitle:@"展开" forState:UIControlStateNormal];
        [_openButton setTitle:@"收缩" forState:UIControlStateSelected];
        [_openButton setBackgroundImage:[self createImageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        [_openButton setBackgroundImage:[self createImageWithColor:[UIColor magentaColor]] forState:UIControlStateHighlighted];
        [_openButton addTarget:self action:@selector(openButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_openButton];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    _titleLabel.frame = CGRectMake(20, 0, 100, height);
    
    CGFloat labelWidth = width - 130 - 80 - 10;
    _txtLabel.frame = CGRectMake(130, 0, labelWidth, height);
    
    _openButton.frame = CGRectMake(labelWidth + 130, 0, 80, height);
}

- (void)setCellData:(RXExpanCCellHeightModel *)cellModel andRow:(NSInteger)row {
    _thisRow = row;
    
    RXExpansionContractionModel * model = cellModel.model;
    
    _titleLabel.text = model.title;
    
    _txtLabel.attributedText = cellModel.attri;
    
    _openButton.hidden = !cellModel.cellEnable;
    _openButton.tag = row;
    
    //是否为选中
    _openButton.selected = cellModel.isShowHigh;
}


- (void)openButtonClick {
    
    if([self.delegate respondsToSelector:@selector(pansionCCellClick:)]) {
        [self.delegate pansionCCellClick:_thisRow];
    }
}

#pragma mark - ~~~~~~~~~~~ 把颜色 转换成 UIImage ~~~~~~~~~~~~~~~
///把颜色 转换成 UIImage
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
