//
//  BirthdayCell.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/11.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "BirthdayCell.h"

@implementation BirthdayCell

+ (instancetype)initWithTableView:(UITableView *)tableView andReuseIdentifier:(NSString *)identifier {
    BirthdayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        NSLog(@"cell created +++");
        cell = [[BirthdayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.prompt = [[UILabel alloc] init];
        [cell.prompt setFont:[UIFont systemFontOfSize:36.f]];
    
        cell.remindTime = [[UILabel alloc] init];
        

        cell.on = [[UISwitch alloc] init];
        
        [cell.contentView addSubview:cell.prompt];
        [cell.contentView addSubview:cell.remindTime];
         [cell.contentView addSubview:cell.on];
        
        //设置右侧的小箭头
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.prompt.translatesAutoresizingMaskIntoConstraints = NO;
        cell.remindTime.translatesAutoresizingMaskIntoConstraints = NO;
        cell.on.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *onCenterY = [NSLayoutConstraint constraintWithItem:cell.on attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        NSLayoutConstraint *onRight = [NSLayoutConstraint constraintWithItem:cell.on attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-18];
//        NSLayoutConstraint *onLeft = [NSLayoutConstraint constraintWithItem:cell.on attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.prompt attribute:NSLayoutAttributeRight multiplier:1 constant:12];
        
        NSLayoutConstraint *promptLeft = [NSLayoutConstraint constraintWithItem:cell.prompt attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:12];
        NSLayoutConstraint *promptTop = [NSLayoutConstraint constraintWithItem:cell.prompt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:12];
        NSLayoutConstraint *promptRight = [NSLayoutConstraint constraintWithItem:cell.prompt attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-78];
        
//        NSLayoutConstraint *createTimeLeft = [NSLayoutConstraint constraintWithItem:cell.createdTime attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:12];
//        NSLayoutConstraint *createTimeTop = [NSLayoutConstraint constraintWithItem:cell.createdTime attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.prompt attribute:NSLayoutAttributeBottom multiplier:1 constant:12];
//        NSLayoutConstraint *createTimeRight = [NSLayoutConstraint constraintWithItem:cell.createdTime attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-12];
//        NSLayoutConstraint *createTimeBottom = [NSLayoutConstraint constraintWithItem:cell.createdTime attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.remindTime attribute:NSLayoutAttributeTop multiplier:1 constant:-12];
        
        NSLayoutConstraint *remindTimeTop= [NSLayoutConstraint constraintWithItem:cell.remindTime attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.prompt attribute:NSLayoutAttributeBottom multiplier:1 constant:12];
        
        NSLayoutConstraint *remindTimeLeft = [NSLayoutConstraint constraintWithItem:cell.remindTime attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:12];
        NSLayoutConstraint *remindTimeRight = [NSLayoutConstraint constraintWithItem:cell.remindTime attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-78];
        NSLayoutConstraint *remindTimeBottom = [NSLayoutConstraint constraintWithItem:cell.remindTime attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-12];
        
        [cell.contentView addConstraints:@[promptLeft, promptTop, promptRight, remindTimeTop, remindTimeLeft, remindTimeRight, remindTimeBottom, onCenterY, onRight]];
//        [cell.contentView setNeedsUpdateConstraints];
//        [cell layoutIfNeeded];
        
//        [cell.prompt setText:@"prompt"];
        [cell.prompt setNumberOfLines:0];
        [cell.prompt setLineBreakMode:NSLineBreakByWordWrapping];
        
//        [cell.createdTime setText:@"created time"];
//        [cell.createdTime setNumberOfLines:0];
//        [cell.createdTime setLineBreakMode:NSLineBreakByWordWrapping];
        
//        [cell.remindTime setText:@"remind time"];
        [cell.remindTime setNumberOfLines:0];
        [cell.remindTime setLineBreakMode:NSLineBreakByWordWrapping];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
