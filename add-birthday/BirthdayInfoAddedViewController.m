//
//  BirthdayInfoAddedViewController.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/12.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "BirthdayInfoAddedViewController.h"
#import "BirthdayCellModel.h"
#import "PromptViewController.h"
#import "Config.h"

@interface BirthdayInfoAddedViewController ()

@property (nonatomic, strong) UILocalNotification *notifi;
@end

@implementation BirthdayInfoAddedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _list = [NSMutableArray<NSMutableArray *> array];
    NSMutableArray *section1 = [@[@"标签"] mutableCopy];
    NSMutableArray *section2 = [@[@"删除"] mutableCopy];
    [_list addObject:section1];
    [_list addObject:section2];

    self.view.backgroundColor = UIColor.whiteColor;
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker setTimeZone:[NSTimeZone defaultTimeZone]];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    _datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24];
    //1920
    NSDate *minDate = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24 * 365 * 50 * -1];
    
    _datePicker.maximumDate = maxDate;
    _datePicker.minimumDate = minDate;
    [_datePicker setDate:_tempBirthdayInfo.prompt];
    [_datePicker setBackgroundColor:THEME_COLOR];
    //设置成功字体为白色
    [_datePicker setValue:UIColor.whiteColor forKey:@"textColor"];
    [self.view addSubview:_datePicker];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
     _tableView.separatorColor = THEME_CELL_LINE_COLOR;
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.estimatedRowHeight = 44;
    _tableView.rowHeight = UITableViewAutomaticDimension;
     _tableView.backgroundColor = THEME_COLOR;
    
    NSLayoutConstraint *datePickerTop = [NSLayoutConstraint constraintWithItem:_datePicker
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.topLayoutGuide
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:0];
    
    NSLayoutConstraint *datePickerLeft = [NSLayoutConstraint constraintWithItem:_datePicker
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:0];
    
    NSLayoutConstraint *datePickerRight = [NSLayoutConstraint constraintWithItem:_datePicker
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:0];
    
    NSLayoutConstraint *tableTop = [NSLayoutConstraint constraintWithItem:_tableView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_datePicker
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1
                                                                 constant:0];
    
    NSLayoutConstraint *tableBottom = [NSLayoutConstraint constraintWithItem:_tableView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:0];
    
    NSLayoutConstraint *tableLeft = [NSLayoutConstraint constraintWithItem:_tableView
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1
                                                                  constant:0];
    
    NSLayoutConstraint *tableRight = [NSLayoutConstraint constraintWithItem:_tableView
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1
                                                                   constant:0];
    
    [self.view addSubview:_tableView];
    [self.view addConstraints:@[tableTop, tableBottom, tableLeft, tableRight, datePickerTop, datePickerLeft, datePickerRight]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(save)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancel)];
    
}


//- (void)enterBackground {
//    NSLog(@"(void)addNotification");
//    _notifi = [[UILocalNotification alloc] init];
//    //5s
//    _notifi.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
//
//    _notifi.repeatInterval =  kCFCalendarUnitMinute;
//
//    _notifi.alertBody = @"birdat eee";
//
//    _notifi.userInfo = @{@"key":@"value"};
//    [[UIApplication sharedApplication] scheduleLocalNotification:_notifi];
//
//}

//- (void)enterForeground {
//    [[UIApplication sharedApplication] cancelLocalNotification:_notifi];
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isAdd"]) {
        NSString *flag = [change objectForKey:@"new"];
        if ([flag isEqualToString:@"TRUE"]) {
            self.title = @"添加";
        } else if ([flag isEqualToString:@"FALSE"]) {
            self.title = @"编辑";
        }
    }
}

- (void)save {
    self.tempBirthdayInfo.prompt = [[_datePicker date] copy];
    //确保创建时间不会被盖掉
    if ([self.tempBirthdayInfo.createdTime isEqualToString:@""]) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy年MM月dd日 HH时mm分ss秒 zzz"];
        NSString *na = [df stringFromDate:[NSDate date]];
        NSString *curDateString = [na copy];
        self.tempBirthdayInfo.createdTime = [curDateString copy];
    }
    self.returnPromptToBirthdayListBlock(self.tempBirthdayInfo);
    self.isSavedBlock(@"TRUE");
    [self removeObserver:self forKeyPath:@"isAdd"];
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)cancel {
    self.returnPromptToBirthdayListBlock(self.tempBirthdayInfo);
    self.isSavedBlock(@"FALSE");
    [self removeObserver:self forKeyPath:@"isAdd"];
    [self.navigationController popViewControllerAnimated:TRUE];
}

//选中cell之后返回取消cell的选中状态
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:TRUE];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list[section].count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PromptViewController *b = [[PromptViewController alloc] init];
        //将label text 传到下一个控制器中
        b.prompt = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        __weak BirthdayInfoAddedViewController *weakSelf = self;
        b.returnNewPromptBlock = ^(NSString *newPrompt) {
            [tableView cellForRowAtIndexPath:indexPath].textLabel.text = newPrompt;
            weakSelf.tempBirthdayInfo.remindTime = newPrompt;
        };
        [self.navigationController pushViewController:b animated:YES];
    } else {
        NSLog(@"section2 called");
        self.returnPromptToBirthdayListBlock(self.tempBirthdayInfo);
        self.isSavedBlock(@"DELETE");
        [self removeObserver:self forKeyPath:@"isAdd"];
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const identifer = @"addBirthdayCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        NSLog(@"创建了新的单元格");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.backgroundColor = cell.backgroundColor = THEME_CELL_COLOR;
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = THEME_CELL_LINE_COLOR;
        
        if (indexPath.section == 0) {
            cell.imageView.image = [UIImage imageNamed:@"标签"];
            //remindTime实际上是prompt
            cell.textLabel.text = self.tempBirthdayInfo.remindTime;
            cell.textLabel.textAlignment = NSTextAlignmentRight;
            cell.textLabel.textColor = UIColor.whiteColor;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.textLabel.text = _list[indexPath.section][indexPath.row];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = UIColor.redColor;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
