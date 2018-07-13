//
//  BirthdayCell.h
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/11.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BirthdayCell : UITableViewCell
//标签
@property (nonatomic, strong) UILabel *prompt;

@property (nonatomic, strong) UILabel *createdTime;

@property (nonatomic, strong) UILabel *remindTime;

//是否推送开关, 默认不推送
@property (nonatomic, getter=isOn, strong) UISwitch *on;
//日期
@property (nonatomic, strong) NSDate *date;
//对switch值的观察
@property (nonatomic, copy) NSString *isSwitchOn;

+ (instancetype)initWithTableView:(UITableView *)tableView andReuseIdentifier:(NSString *)identifier;

@end
