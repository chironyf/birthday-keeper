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
    
    
    self.title = @"生日管家";
    //    self.navigationItem.title = @"生日管家";
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


- (void)addBirthday {
    BirthdayInfoAddedViewController *b = [[BirthdayInfoAddedViewController alloc] init];
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.6f;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//    transition.type = kCATransitionFromBottom;
//    transition.subtype = kCATransitionFromTop;
////    transition.delegate = self;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//    self.navigationController.navigationBarHidden = NO;
 
    [self.navigationController pushViewController:b animated:YES];
}

- (void)editBirthday {

    [_birthdayTableView setEditing:TRUE animated:TRUE];

    //不设置为true的时候，编辑状态下无法响应cell的didselect
    [_birthdayTableView setAllowsSelectionDuringEditing:TRUE];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishEditBirthday)];
    
}

- (void)finishEditBirthday {
    [_birthdayTableView setEditing:FALSE animated:TRUE];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editBirthday)];
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
    [item.on setOn:_birthdayInfo[indexPath.row].isOn];

    //设置所有cell为不可编辑状态;
    [item setSelectionStyle:UITableViewCellSelectionStyleNone];

    NSLog(@"第%ld个cell, height = %f", indexPath.row, item.frame.size.height);
    return item;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"当前选中的是第%ld行", indexPath.row);
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
