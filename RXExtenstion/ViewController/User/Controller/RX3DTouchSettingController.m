//
//  RX3DTouchSettingController.m
//  RXExtenstion
//
//  Created by srx on 16/6/16.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RX3DTouchSettingController.h"
#import "TTCacheUtil.h"
#import "RXShortcutItem.h"
#import "RX3DCell.h"
#import "AppDelegate.h"

@interface RX3DTouchSettingController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * _souceArray;
    NSMutableArray * _ALLArray;
    UIButton * _3DTouchButton;
    BOOL  _isNeedReload;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RX3DTouchSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"3D Touch定制";
    [self configUI];
}

- (void)configUI {
    
    _3DTouchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _3DTouchButton.frame = CGRectMake(0, 0, 70, 20);
    [_3DTouchButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_3DTouchButton setTitle:@"完成" forState:UIControlStateSelected];
    [_3DTouchButton setTitleColor:UIColorHexStr(@"333333") forState:UIControlStateNormal];
    [_3DTouchButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_3DTouchButton addTarget:self action:@selector(navRightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _3DTouchButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _3DTouchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _3DTouchButton.titleLabel.font = [UIFont systemFontOfSize:14];
    //    btn.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:_3DTouchButton];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    _tableView.tableFooterView = [[UIView alloc] init];
    _souceArray = [[NSMutableArray alloc] init];
    _ALLArray = [[NSMutableArray alloc] init];
    [_tableView registerClass:[RX3DCell class] forCellReuseIdentifier:@"3DTouchCell"];
    
    NSArray * array = [RXShortcutItem readerLocalData];
    if(array.count > 0 && array != nil) {
        [_souceArray addObjectsFromArray:array];
    }
    [_ALLArray  addObjectsFromArray:[RXShortcutItem readerCanSettingAllReject:array]];
    [_tableView reloadData];
}

- (void)navRightButtonClick {
    _3DTouchButton.selected = !_3DTouchButton.selected;
    if(_3DTouchButton.selected) {
        _isNeedReload = NO;
        [_tableView setEditing:YES animated:YES];
    }
    else {
        _3DTouchButton.enabled = NO;
        [_tableView setEditing:NO animated:NO];
        if(_isNeedReload == YES) [_tableView reloadData];
        _3DTouchButton.enabled = YES;
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSInteger section0 = sourceIndexPath.section;
    NSInteger row0 = sourceIndexPath.row;
    NSInteger section1 = destinationIndexPath.section;
    NSInteger row1 = destinationIndexPath.row;
    
    if(section0 == 0 && section0 == section1) {
        [_souceArray exchangeObjectAtIndex:row0 withObjectAtIndex:row1];
    }
    else if(section0 == 1 && section0 == section1) {
        [_ALLArray exchangeObjectAtIndex:row0 withObjectAtIndex:row1];
    }
    else {
        if(section0 == 0) {
            [_ALLArray insertObject:_souceArray[row0] atIndex:row1];
            [_souceArray removeObjectAtIndex:row0];
        }
        else {
            [_souceArray insertObject:_ALLArray[row0] atIndex:row1];
            [_ALLArray removeObjectAtIndex:row0];
        }
    }
    _isNeedReload = YES;
    
    //最多显示 4个
    if(_souceArray.count > 3) {
        for(NSInteger i = 4; i < _souceArray.count; i++) {
            [_ALLArray insertObject:_souceArray[i] atIndex:0];
            [_souceArray removeObjectAtIndex:i];
            [_tableView reloadData];
        }
        _isNeedReload = NO;//已经刷新过了，就不要在刷新了
    }
    
    [SharedAppDelegate setShortcutItem:_souceArray];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return _souceArray.count;
    }
    return _ALLArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RX3DCell * cell = [tableView dequeueReusableCellWithIdentifier:@"3DTouchCell"];
    
    RXShortcutItem * model;
    if(indexPath.section == 0) {
        model = _souceArray[indexPath.row];
    }
    else {
        model = _ALLArray[indexPath.row];
    }
    
    cell.textLabel.text = model.rxItemTitle;
//    cell.editingAccessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"包括";
    }
    return @"不包括";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
