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
@property (nonatomic, copy) NSString *isBirthdayTableEditing;
//用来保存上一个控制器返回时按下的是取消(FALSE)还是保存(TRUE)还是删除(DELETE)按钮，
@property (nonatomic, copy)  NSString *isSaved;
//保存当前传入的cell的行号，默认为-1
@property (nonatomic, assign) NSInteger curIndex;
//保存传出去的cell，作为一个中介，用isSaved来判断是否将其插入本数据源
@property (nonatomic, strong)  BirthdayCellModel *tempCellModel;

@end
