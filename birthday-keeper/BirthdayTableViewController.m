//
//  BirthdayTableViewController.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/12.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "BirthdayTableViewController.h"
#import "BirthdayCell.h"
#import "BirthdayCellModel.h"
#import "BirthdayInfoAddedViewController.h"

static NSString *const BirthdayCellIdentifier = @"BirthdayCellIdentifier";

@interface BirthdayTableViewController ()

@end

@implementation BirthdayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //没初始化的话，不会报错，但是没有数据显示
    _birthdayInfo = [[NSMutableArray alloc] init];
    //第一次加载初始化中介
    _tempCellModel = [[BirthdayCellModel alloc] init];
    _curIndex = -1;
    
    [self addObserver:self forKeyPath:@"isSaved" options:NSKeyValueObservingOptionNew context:nil];

    self.isBirthdayTableEditing = @"FALSE";
    self.title = @"生日管家";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addBirthday)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editBirthday)];

    for (int i = 0; i < 20; i++) {
        NSDate *date = [NSDate date];
        NSTimeInterval sec = [date timeIntervalSinceNow];
        NSDate *currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
        
        //设置时间输出格式：
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MM月dd日"];
        NSString *na = [df stringFromDate:currentDate];
        
        if (i % 2 == 0) {
            BirthdayCellModel *item = [[BirthdayCellModel alloc] initWithPrompt:@"09月14日" CreatedTime:na RemindTime:na Height:0.0f];
            [_birthdayInfo addObject:item];
        } else {
            BirthdayCellModel *item = [[BirthdayCellModel alloc] initWithPrompt:@"09月14日" CreatedTime:[NSString stringWithFormat:@"这发素返回加快速度发是好过分放寒假倒计时咖啡符合健康的撒后方可返回的手机卡花覅合肥的还符号阿富汗凯撒红福克斯是第%@条提醒", na] RemindTime:na Height:0.0f];
            [_birthdayInfo addObject:item];
        }
        
    }
    
    _birthdayTableView = [[UITableView alloc] init];
    
    _birthdayTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_birthdayTableView];
    
    [_birthdayTableView setDelegate:self];
    [_birthdayTableView setDataSource:self];
    
    NSLayoutConstraint *birthdayTableViewLeft = [NSLayoutConstraint constraintWithItem:_birthdayTableView  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *birthdayTableViewRight = [NSLayoutConstraint constraintWithItem:_birthdayTableView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    NSLayoutConstraint *birthdayTableViewTop = [NSLayoutConstraint constraintWithItem:_birthdayTableView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    NSLayoutConstraint *birthdayTableViewBottom = [NSLayoutConstraint constraintWithItem:_birthdayTableView  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [self.view addConstraints:@[birthdayTableViewLeft, birthdayTableViewRight, birthdayTableViewTop, birthdayTableViewBottom]];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    _birthdayTableView.estimatedRowHeight = 88;
    _birthdayTableView.rowHeight = UITableViewAutomaticDimension;
    
    //    [_birthdayTableView registerClass:[BirthdayCell class] forCellReuseIdentifier:BirthdayCellIdentifier];
    //
    //    [_birthdayTableView registerClass:[BirthdayCell class] forCellReuseIdentifier:BirthdayCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSString *flag = [change objectForKey:@"new"];
    if ([keyPath isEqualToString:@"isSaved"]) {
        if ([flag isEqualToString:@"TRUE"] && self.curIndex == -1) {
            [self.birthdayInfo insertObject:_tempCellModel atIndex:0];
        } else if ([flag isEqualToString:@"TRUE"] && self.curIndex != -1) {
            self.birthdayInfo[_curIndex] = _tempCellModel;
        }
        [self.birthdayTableView reloadData];
    }
}

//添加的时候，需要将新的信息插入
- (void)addBirthday {
    BirthdayInfoAddedViewController *b = [[BirthdayInfoAddedViewController alloc] init];
    //表示添加新的info,直接传一个空的过去
    [b addObserver:b forKeyPath:@"isAdd" options:NSKeyValueObservingOptionNew context:nil];
    b.isAdd = @"TRUE";
    self.curIndex = -1;
    //清空数据
    [_tempCellModel clear];
    
    b.tempBirthdayInfo = _tempCellModel;
 
    __weak BirthdayTableViewController *weakSelf = self;
    
    //在编辑vc中，返回时调用block给其赋值
    b.isSavedBlock = ^(NSString *isSaved) {
        weakSelf.isSaved = isSaved;
    };
    
    b.returnPromptToBirthdayListBlock = ^(BirthdayCellModel *bcm) {
        weakSelf.tempCellModel = bcm;
    };

    [self.navigationController pushViewController:b animated:YES];
}

- (void)editBirthday {

    [_birthdayTableView setEditing:TRUE animated:TRUE];
    self.isBirthdayTableEditing = @"TRUE";

    //不设置为true的时候，编辑状态下无法响应cell的didselect
    [_birthdayTableView setAllowsSelectionDuringEditing:TRUE];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishEditBirthday)];
    
}

- (void)finishEditBirthday {
    [_birthdayTableView setEditing:FALSE animated:TRUE];
    self.isBirthdayTableEditing = @"FALSE";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editBirthday)];
    //添加reloadData动画

}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"isSaved"];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    CGFloat h = cell.frame.size.height;
    NSLog(@"willDisplayCell, frame height = %f, systemLayoutSizeFittingSize = %f", h, height.height);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_birthdayInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BirthdayCell *item = [BirthdayCell initWithTableView:tableView andReuseIdentifier:BirthdayCellIdentifier];

    [item.prompt setText:_birthdayInfo[indexPath.row].prompt];
    [item.createdTime setText:_birthdayInfo[indexPath.row].createdTime];
    [item.remindTime setText:_birthdayInfo[indexPath.row].remindTime];
    //保持数据与视图显示的数据一致
    
    if (_birthdayInfo[indexPath.row].isOn) {
        [item.on setOn:TRUE];
        item.isSwitchOn = @"TRUE";
    } else {
        [item.on setOn:FALSE];
        item.isSwitchOn = @"FALSE";
    }
    //UIControlEventValueChanged与touchupinside的区别，后者会发生按钮值改变了，但是没有触发点击事件
    [item.on addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    return item;
}

- (void)switchChanged:(id)sender {
    BirthdayCell *curCell = (BirthdayCell *)[[sender superview] superview];
    NSIndexPath *curIndexPath = [_birthdayTableView indexPathForCell:curCell];
    if ([curCell.isSwitchOn isEqualToString:@"TRUE"]) {
        curCell.isSwitchOn = @"FALSE";
        self.birthdayInfo[curIndexPath.row].on = FALSE;
    } else {
        curCell.isSwitchOn = @"TRUE";
        self.birthdayInfo[curIndexPath.row].on = TRUE;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"当前选中的是第%d行", (long)indexPath.row);
    BirthdayInfoAddedViewController *b = [[BirthdayInfoAddedViewController alloc] init];
    
    
    self.curIndex = indexPath.row;
    self.tempCellModel = _birthdayInfo[_curIndex];
    //标志不是添加而是选择的cell
    [b addObserver:b forKeyPath:@"isAdd" options:NSKeyValueObservingOptionNew context:nil];
    b.isAdd = @"FALSE";
    b.tempBirthdayInfo = _tempCellModel;
    
    __weak BirthdayTableViewController *weakSelf = self;
    b.returnPromptToBirthdayListBlock = ^(BirthdayCellModel *model) {
        weakSelf.tempCellModel = model;
    };
    b.isSavedBlock = ^(NSString *isSaved) {
        weakSelf.isSaved = isSaved;
    };
    
    [self.navigationController pushViewController:b animated:TRUE];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
