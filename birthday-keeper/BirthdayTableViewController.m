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
#import "Config.h"
#import "Singleton.h"
#import <UserNotifications/UserNotifications.h>

static NSString *const BirthdayCellIdentifier = @"BirthdayCellIdentifier";
//用来记录当前数组的count,由于可变数组的监听,每次只能观察到一个元素的改变,无法观察count的变化
static int curBirthdayInfoCount = 0;

@interface BirthdayTableViewController ()
@property (nonatomic, strong) UIBarButtonItem *edit;
@property (nonatomic, strong) UIBarButtonItem *finished;
@end

@implementation BirthdayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生日管家";
    
    [self addObserver:self forKeyPath:@"birthdayInfo" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"isBirthdayTableEditing" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"isSaved" options:NSKeyValueObservingOptionNew context:nil];
    
    self.isBirthdayTableEditing = @"FALSE";
    
    curBirthdayInfoCount = (int)[_birthdayInfo count];
    _tempCellModel = [[BirthdayCellModel alloc] init];
    _curIndex = -1;
    
    self.edit = [[UIBarButtonItem alloc] initWithTitle:@"编辑"
                                                 style:UIBarButtonItemStylePlain
                                                target:self
                                                action:@selector(editBirthday)];
    self.finished = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                     style:UIBarButtonItemStylePlain
                                                    target:self
                                                    action:@selector(finishEditBirthday)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(addBirthday)];
    self.navigationItem.leftBarButtonItem = _edit;
    if (curBirthdayInfoCount == 0) {
        self.navigationItem.leftBarButtonItem.enabled = FALSE;
    }
    
    _birthdayTableView = [[UITableView alloc] init];
    _birthdayTableView.translatesAutoresizingMaskIntoConstraints = NO;
    _birthdayTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _birthdayTableView.separatorColor = THEME_CELL_LINE_COLOR;
    //隐藏多余的线条
    _birthdayTableView.tableFooterView = [[UIView alloc] init];
    _birthdayTableView.backgroundColor = THEME_COLOR;
    [self.view addSubview:_birthdayTableView];
    [_birthdayTableView setDelegate:self];
    [_birthdayTableView setDataSource:self];
    _birthdayTableView.estimatedRowHeight = 88;
    _birthdayTableView.rowHeight = UITableViewAutomaticDimension;
    self.birthdayTableView.editing = FALSE;
    
    self.navigationController.navigationBar.barTintColor = THEME_COLOR;
    self.navigationController.navigationBar.tintColor = THEME_TEXT_COLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.whiteColor};

    NSLayoutConstraint *birthdayTableViewLeft = [NSLayoutConstraint constraintWithItem:_birthdayTableView
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.view
                                                                             attribute:NSLayoutAttributeLeft
                                                                            multiplier:1
                                                                              constant:0];
    
    NSLayoutConstraint *birthdayTableViewRight = [NSLayoutConstraint constraintWithItem:_birthdayTableView
                                                                              attribute:NSLayoutAttributeRight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1
                                                                               constant:0];
    
    NSLayoutConstraint *birthdayTableViewTop = [NSLayoutConstraint constraintWithItem:_birthdayTableView
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.view
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:0];
    
    NSLayoutConstraint *birthdayTableViewBottom = [NSLayoutConstraint constraintWithItem:_birthdayTableView
                                                                               attribute:NSLayoutAttributeBottom
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1
                                                                                constant:0];
    
    [self.view addConstraints:@[birthdayTableViewLeft, birthdayTableViewRight, birthdayTableViewTop, birthdayTableViewBottom]];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isSaved"]) {
        NSString *flag = [change objectForKey:@"new"];
        if ([flag isEqualToString:@"TRUE"] && self.curIndex == -1) {
            //默认关闭, 这里不需要push
            curBirthdayInfoCount++;
            [[self mutableArrayValueForKeyPath:@"birthdayInfo"] insertObject:[_tempCellModel copy] atIndex:0];
            [self.birthdayTableView reloadData];
        } else if ([flag isEqualToString:@"TRUE"] && self.curIndex != -1) {
//            NSLog(@"保存了cell的编辑");
            [[self mutableArrayValueForKeyPath:@"birthdayInfo"] replaceObjectAtIndex:_curIndex withObject:[_tempCellModel copy]];
            [self.birthdayTableView reloadData];
            [self updateLocalNotification:_birthdayInfo[_curIndex]];
        } else if ([flag isEqualToString:@"FALSE"]) {
            //do nothing
            [self.birthdayTableView reloadData];
        } else if ([flag isEqualToString:@"DELETE"] && _curIndex != -1) {
            if (self.birthdayInfo[_curIndex].on) {
                [self cancelLocalNotifications:_birthdayInfo[_curIndex]];
            }
            curBirthdayInfoCount--;
            [[self mutableArrayValueForKeyPath:@"birthdayInfo"] removeObjectAtIndex:_curIndex];
            [self.birthdayTableView reloadData];
        }
        Singleton.sharedInstance.birthdayInfo = _birthdayInfo;
    }
    //监听数组的变化
    if ([keyPath isEqualToString:@"birthdayInfo"]) {
        if (curBirthdayInfoCount > 0) {
            self.navigationItem.leftBarButtonItem.enabled = TRUE;
        } else {
            self.navigationItem.leftBarButtonItem = _edit;
            self.navigationItem.leftBarButtonItem.enabled = FALSE;
            //当数组没有元素的时候一定要设置
            self.birthdayTableView.editing = FALSE;
            self.isBirthdayTableEditing = @"FALSE";
            self.navigationItem.rightBarButtonItem.enabled = TRUE;
        }
    }
    //监听是否在编辑状态, 编辑状态下cell不可点击
    if ([keyPath isEqualToString:@"isBirthdayTableEditing"]) {
        NSString *editFlag = [change objectForKey:@"new"];
        if ([editFlag isEqualToString:@"TRUE"]) {
            self.navigationItem.rightBarButtonItem.enabled = FALSE;
        } else {
            self.navigationItem.rightBarButtonItem.enabled = TRUE;
        }
    }
}

//添加的时候，需要将新的信息插入
- (void)addBirthday {
    BirthdayInfoAddedViewController *b = [[BirthdayInfoAddedViewController alloc] init];
    //表示添加新的info,直接传一个空的过去
    [b addObserver:b forKeyPath:@"isAdd" options:NSKeyValueObservingOptionNew context:nil];
    self.curIndex = -1;
    [self.tempCellModel clear];
    
    b.tempBirthdayInfo = [self.tempCellModel copy];
    b.isAdd = @"TRUE";
    
    __weak BirthdayTableViewController *weakSelf = self;
    b.isSavedBlock = ^(NSString *isSaved) {
        weakSelf.isSaved = isSaved;
    };
    
    b.returnPromptToBirthdayListBlock = ^(BirthdayCellModel *bcm) {
        weakSelf.tempCellModel = [bcm copy];
    };

    [self.navigationController pushViewController:b animated:YES];
}

- (void)editBirthday {
    [_birthdayTableView setEditing:TRUE animated:TRUE];
    self.isBirthdayTableEditing = @"TRUE";
    self.navigationItem.leftBarButtonItem = _finished;
}

- (void)finishEditBirthday {
    [_birthdayTableView setEditing:FALSE animated:TRUE];
    self.isBirthdayTableEditing = @"FALSE";
    self.navigationItem.leftBarButtonItem = _edit;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"isSaved"];
    [self removeObserver:self forKeyPath:@"birthdayInfo"];
    [self removeObserver:self forKeyPath:@"isBirthdayTableEditing"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _birthdayInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BirthdayCell *item = [BirthdayCell initWithTableView:tableView andReuseIdentifier:BirthdayCellIdentifier];
    //设置时间
    NSDate *date = _birthdayInfo[indexPath.row].prompt;
    //保存时间
    item.date = date;
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate *currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    
    //设置时间输出格式：
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM月dd日"];
    NSString *na = [df stringFromDate:currentDate];
    
    [item.prompt setText:na];

    [item.createdTime setText:_birthdayInfo[indexPath.row].createdTime];
    [item.remindTime setText:_birthdayInfo[indexPath.row].remindTime];
    //保持数据与视图显示的数据一致
    [item.on addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    if (_birthdayInfo[indexPath.row].isOn) {
        [item.on setOn:TRUE];
        item.isSwitchOn = @"TRUE";
    } else {
        [item.on setOn:FALSE];
        item.isSwitchOn = @"FALSE";
    }
    return item;
}

//用来添加或者取消推送
- (void)switchChanged:(id)sender {
    BirthdayCell *curCell = (BirthdayCell *)[[sender superview] superview];
    NSIndexPath *curIndexPath = [_birthdayTableView indexPathForCell:curCell];
    if ([curCell.isSwitchOn isEqualToString:@"TRUE"]) {
        curCell.isSwitchOn = @"FALSE";
        self.birthdayInfo[curIndexPath.row].on = FALSE;
        Singleton.sharedInstance.birthdayInfo = _birthdayInfo;
        //取消本地推送
        [self cancelLocalNotifications:self.birthdayInfo[curIndexPath.row]];
    } else {
        curCell.isSwitchOn = @"TRUE";
        self.birthdayInfo[curIndexPath.row].on = TRUE;
        Singleton.sharedInstance.birthdayInfo = _birthdayInfo;
        //添加本地推送
        [self addLocalNotifications:self.birthdayInfo[curIndexPath.row]];
    }
}

- (NSDate *)calcuFireDate:(NSDate *)remindDate {
    NSCalendar *calender = [NSCalendar autoupdatingCurrentCalendar];
    unsigned unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponents = [[calender components:unitFlags fromDate:remindDate] copy];
    //提醒的时间转换为1年的同年同月
    NSDate *mdDate = [[calender dateFromComponents:dateComponents] copy];
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    dateComponents = [[calender components:unitFlags fromDate:now] copy];
    //将当前的日期转换为1年的同年同月
    NSDate *curDate = [[calender dateFromComponents:dateComponents] copy];
    NSTimeInterval ti = [curDate timeIntervalSinceDate:mdDate];
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:-ti + 20];
    return fireDate;
}

//添加本地推送
- (void)addLocalNotifications:(BirthdayCellModel *)bcm {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.fireDate = [self calcuFireDate:bcm.prompt];
    // 触发后，弹出警告框中显示的内容
    localNotification.alertBody = bcm.remindTime;
    // 触发时的声音（这里选择的系统默认声音）
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.repeatInterval = kCFCalendarUnitYear;
    localNotification.applicationIconBadgeNumber = 1;
    localNotification.userInfo = @{@"createdTime" : bcm.createdTime};
    // 注册本地通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}
//取消本地推送
- (void)cancelLocalNotifications:(BirthdayCellModel *)bcm {
    NSArray *notifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    NSString *notificationId = bcm.createdTime;
    for (UILocalNotification *localNotification in notifications) {
        if ([[localNotification.userInfo objectForKey:@"createdTime"] isEqualToString:notificationId]) {
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
        }
    }
}

- (void)updateLocalNotification:(BirthdayCellModel *)bcm {
    //由于直接更新fireDate无法更新, 首先取消原来的通知
    [self cancelLocalNotifications:bcm];
    //加入新的通知
    [self addLocalNotifications:bcm];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<NSIndexPath *> *d = @[indexPath];
    BirthdayCell *c = [self.birthdayTableView cellForRowAtIndexPath:indexPath];
    if ([c.isSwitchOn isEqualToString:@"TRUE"]) {
        [self cancelLocalNotifications:_birthdayInfo[indexPath.row]];
    }
    curBirthdayInfoCount--;
    [[self mutableArrayValueForKeyPath:@"birthdayInfo"] removeObjectAtIndex:indexPath.row];
    Singleton.sharedInstance.birthdayInfo = _birthdayInfo;
    [self.birthdayTableView deleteRowsAtIndexPaths:d withRowAnimation:UITableViewRowAnimationLeft];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BirthdayInfoAddedViewController *b = [[BirthdayInfoAddedViewController alloc] init];
    
    self.curIndex = indexPath.row;
    self.tempCellModel = [_birthdayInfo[_curIndex] copy];
    b.tempBirthdayInfo = self.tempCellModel;
    //标志不是添加而是选择的cell
    [b addObserver:b forKeyPath:@"isAdd" options:NSKeyValueObservingOptionNew context:nil];
    b.isAdd = @"FALSE";
    
    __weak BirthdayTableViewController *weakSelf = self;
    b.returnPromptToBirthdayListBlock = ^(BirthdayCellModel *model) {
        weakSelf.tempCellModel = [model copy];
    };
    b.isSavedBlock = ^(NSString *isSaved) {
        weakSelf.isSaved = [isSaved copy];
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
