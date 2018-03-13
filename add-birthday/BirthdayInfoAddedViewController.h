//
//  BirthdayInfoAddedViewController.h
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/12.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BirthdayCellModel;
@interface BirthdayInfoAddedViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BirthdayCellModel *birthdayInfo;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIDatePicker *datePicker;

//保存多段的cell标签
@property (nonatomic, copy) NSMutableArray<NSMutableArray *> *list;

@end
