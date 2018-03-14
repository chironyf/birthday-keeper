//
//  BirthdayTableViewController.h
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/12.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BirthdayCellModel.h"

@interface BirthdayTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *birthdayTableView;

@property (nonatomic, strong) NSMutableArray<BirthdayCellModel *> *birthdayInfo;

//tableView是否是编辑状态的观察，通过将cell添加为该属性的观察者，实现编辑状态下的switch按钮隐藏
@property (nonatomic, strong) NSString *isBirthdayTableEditing;



@end
