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



@end
