//
//  BirthdayInfoAddedViewController.h
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/12.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 添加, 编辑都是这个页面
 
 */


@class BirthdayCellModel;
typedef void(^returnPromptToBirthdayList)(BirthdayCellModel *);

//在当前界面是保存还是取消
typedef void(^isSaved)(NSString *);

@interface BirthdayInfoAddedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

//实际操作的model
@property (nonatomic, strong) BirthdayCellModel *birthdayInfo;

//临时保存的cell，例如需要取消的话，直接将这个temp传回去即可
@property (nonatomic, strong) BirthdayCellModel *tempBirthdayInfo;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, copy) returnPromptToBirthdayList returnPromptToBirthdayListBlock;

@property (nonatomic, copy) isSaved isSavedBlock;

//标记是点击cell进来的还是点击添加进来的
@property (nonatomic, strong) NSString *isAdd;

//保存多段的cell标签
@property (nonatomic, copy) NSMutableArray<NSMutableArray *> *list;

@end
