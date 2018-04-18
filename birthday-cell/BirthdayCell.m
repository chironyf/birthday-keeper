//
//  BirthdayCell.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/11.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "BirthdayCell.h"
#import "GCON.h"

@implementation BirthdayCell

+ (instancetype)initWithTableView:(UITableView *)tableView andReuseIdentifier:(NSString *)identifier {
    BirthdayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        NSLog(@"cell created +++");
        cell = [[BirthdayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.backgroundColor = [UIColor colorWithRed:themeCellRed green:themeCellGreen blue:themeCellBlue alpha:themeAlpha];
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:themeCellLineRed green:themeCellLineGreen blue:themeCellLineBlue alpha:themeAlpha];
        
        cell.prompt = [[UILabel alloc] init];
        //字体过大会导致cell高度奇怪变化
        [cell.prompt setFont:[UIFont systemFontOfSize:42 weight:UIFontWeightThin]];
        [cell.prompt setTextColor:UIColor.grayColor];
    
        cell.remindTime = [[UILabel alloc] init];
        cell.remindTime.textColor = UIColor.grayColor;

        cell.on = [[UISwitch alloc] init];
        cell.on.onTintColor = [UIColor colorWithRed:themeTextRed green:themeTextGreen blue:themeTextBlue alpha:themeAlpha];
    
        cell.isSwitchOn = @"FALSE";
        
        [cell.contentView addSubview:cell.prompt];
        [cell.contentView addSubview:cell.remindTime];
        [cell.contentView addSubview:cell.on];
    
        cell.prompt.translatesAutoresizingMaskIntoConstraints = NO;
        cell.remindTime.translatesAutoresizingMaskIntoConstraints = NO;
        cell.on.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *onCenterY = [NSLayoutConstraint constraintWithItem:cell.on attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        NSLayoutConstraint *onRight = [NSLayoutConstraint constraintWithItem:cell.on attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-18];
        
        NSLayoutConstraint *promptLeft = [NSLayoutConstraint constraintWithItem:cell.prompt attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:12];
        NSLayoutConstraint *promptTop = [NSLayoutConstraint constraintWithItem:cell.prompt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:12];
        NSLayoutConstraint *promptRight = [NSLayoutConstraint constraintWithItem:cell.prompt attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-78];
        
        NSLayoutConstraint *remindTimeTop= [NSLayoutConstraint constraintWithItem:cell.remindTime attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.prompt attribute:NSLayoutAttributeBottom multiplier:1 constant:2];
        
        NSLayoutConstraint *remindTimeLeft = [NSLayoutConstraint constraintWithItem:cell.remindTime attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:12];
        NSLayoutConstraint *remindTimeRight = [NSLayoutConstraint constraintWithItem:cell.remindTime attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-78];
        NSLayoutConstraint *remindTimeBottom = [NSLayoutConstraint constraintWithItem:cell.remindTime attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-12];
        
        [cell.contentView addConstraints:@[promptLeft, promptTop, promptRight, remindTimeTop, remindTimeLeft, remindTimeRight, remindTimeBottom, onCenterY, onRight]];
        [cell.prompt setNumberOfLines:1];
        [cell.prompt setLineBreakMode:NSLineBreakByTruncatingTail];
        
        [cell.remindTime setNumberOfLines:1];
        [cell.remindTime setLineBreakMode:NSLineBreakByTruncatingTail];
        
        [cell addObserver:cell forKeyPath:@"isSwitchOn" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isSwitchOn"]) {
        NSString *flag = [change valueForKey:NSKeyValueChangeNewKey];
        NSString *old = [change valueForKey:NSKeyValueChangeOldKey];
        if ([flag isEqualToString:@"FALSE"] && [old isEqualToString:@"TRUE"]) {
            [self.prompt setTextColor:UIColor.grayColor];
            [self.remindTime setTextColor:UIColor.grayColor];
        } else if ([flag isEqualToString:@"TRUE"] && [old isEqualToString:@"FALSE"]) {
            [self.prompt setTextColor:UIColor.whiteColor];
            [self.remindTime setTextColor:UIColor.whiteColor];
        }
    }
}

//
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"isSwitchOn"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end
