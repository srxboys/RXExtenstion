//
//  RXExpanCCellHeightModel.m
//  RXExtenstion
//
//  Created by srx on 16/6/3.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
// 存代码

#import "RXExpanCCellHeightModel.h"
#import "RXDataModel.h"
#import "RXCharacter.h"

@implementation RXExpanCCellHeightModel
- (void)setModel:(RXExpansionContractionModel *)model {
    _model = model;
    
    _cellEnable = NO; //默认不能展开操作
    _isShowHigh = NO; //默认不是展开，返回各个高度
    
    CGFloat labelHeight = 21;
    
    _textHeight     = labelHeight;
    _textHighHeight = labelHeight;
    _cellHeight     = labelHeight;
    _cellHighHeight = labelHeight;
    
    if(![model.text strBOOL]) {
        //不是字符串、字符串为空  防止崩溃
        return;
    }
    
    CGFloat left = 100; //cell 标题的宽度
    CGFloat right = 80; // cell 按钮的宽度
    CGFloat width = ScreenWidth - left - right - 20 - 20;
    
    CGRect frame = CGRectMake(left, 0, width, labelHeight);
    
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    //    label.text = model.text;
    label.font = [UIFont systemFontOfSize:TextFontSize];
    label.numberOfLines = 1;
    _attri = [self setAttri:model.text];
    
    [label setAttributedText:_attri];
    
    
    //第一种处理，，好像不好使
    //    _textHeight = [label textRectForBounds:frame limitedToNumberOfLines:1].size.height;
    //    _cellHeight     = _textHeight;
    //
    //
    //    _textHighHeight = [label textRectForBounds:frame limitedToNumberOfLines:0].size.height;
    //    _cellHighHeight = _textHighHeight;
    
    
    //第二种
    [label sizeToFit];
    _textHeight    = label.frame.size.height;
    _cellHeight     = _textHeight;
    
    
    label.frame = CGRectMake(0, 0, width, CGFLOAT_MAX);
    label.numberOfLines = 0;
    [label sizeToFit];
    _textHighHeight = label.frame.size.height;
    _cellHighHeight = _textHighHeight;
    
    
    
    //计算出来的高度，小于设计的高度时
    if(_textHeight < labelHeight) {
        _textHeight = labelHeight;
        _cellHeight = labelHeight;
    }
    
    //展开高度 < 默认高度
    if(_textHighHeight < _textHeight) {
        _textHighHeight = _textHeight;
        _cellHighHeight = _cellHeight;
    }
    else {
        //可以显示展开的 button.hidden
        _cellEnable = YES;
    }
    
    
}



- (NSMutableAttributedString *)setAttri:(NSString *)string {
    NSMutableAttributedString * comment = [[NSMutableAttributedString alloc] initWithString:string];
    //字体大小、颜色
    [comment setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:TextFontSize], NSForegroundColorAttributeName : [UIColor lightGrayColor]} range:NSMakeRange(0, comment.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //行间距
    [paragraphStyle setLineSpacing:Text_lineHight];
    //文本 后面显示不下 ...结尾
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    [comment addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, comment.length)];
    
    return comment;
}
@end
