//
//  PromptEditCell.h
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/13.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromptEditCell : UITableViewCell

@property (nonatomic, strong) UITextField *promptEditField;

+ (instancetype)initWith:(UITableView *)tableView andReuseIdentifier:(NSString *)identifier;

@end
