//
//  MineInfoCell.m
//  Test_数组里存cell
//
//  Created by srx on 16/8/9.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXMineInfoMessageCell.h"
#import "RXDataModel.h"



/// 下面是 RunTime 中最常见的 事件
#import <objc/message.h>
#define RXMsgSend(...) ((void (*)(void *, SEL, RXMineInfoMessageCell *))objc_msgSend)(__VA_ARGS__)
#define RXMsgTarget(target) (__bridge void *)(target)



@interface RXMineInfoMessageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
- (IBAction)detailButtonClick:(id)sender;


@end


@implementation RXMineInfoMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    /** 初始化内部控件 设置信息 */
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)setOneCellModel:(OneXibModel *)model {
    if(model == nil) {
        return;
    }
    _dataModel = model.DataModelInfo;
    
//    [_headImgView ..... [NSURL URLWithString:model.avaster]];
    
    _nameLabel.text = model.name;
    
    NSString * sexStr = [NSString stringWithFormat:@"%zd", model.sex];
    _sexLabel.text = sexStr.length <= 0 ? @"默认" : sexStr;
    if(_sexLabel == nil) {
        RXLog(@"%s all cell.content=nil -- 0", __FUNCTION__);
    }
}

- (void)setTwoCellModel:(TwoXibModel *)model {
    if(model == nil) {
        return;
    }
    _dataModel = model.DataModelInfo;
    
    _nameLabel.text = model.profession;
    
    NSString * seniorityStr = [NSString stringWithFormat:@"%.2f", model.seniority];
    _sexLabel.text = seniorityStr.length <= 0 ? @"不知道" : seniorityStr;
    
    if(_sexLabel == nil) {
        RXLog(@"%s all cell.content=nil -- 0", __FUNCTION__);
    }
}


- (void)setCellData:(id)modelObject andSection:(NSInteger)section {
    if(section == 0) {
        [self setOneCellModel:modelObject];
    }
    else if(section == 1){
        [self setTwoCellModel:modelObject];
    }
}


- (IBAction)detailButtonClick:(id)sender {
    [self buttonClick];
}



/** 传递事件 */
- (void)buttonClick {
    if([self ifDataModelEquelNil:_dataModel]) {
        //判断 是否可以 传递事件
        if([_dataModel.object respondsToSelector:_dataModel.selecter]) {
            RXMsgSend(RXMsgTarget(_dataModel.object), _dataModel.selecter, self);
        }
    }
    
    //在tableView中，根据数据模型的 cell标识、tag来做处理
}

/** 判断数据源是否 有数据 */
- (BOOL)ifDataModelEquelNil:(RXXibModel *)dataModel {
    if(dataModel != nil) {
        if(dataModel.modelTag >= 0) {
            return YES;
        }
        return NO;
    }
    return NO;
}

@end
