//
//  BirthdayCell.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/11.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "BirthdayCell.h"
#import "Config.h"

@implementation BirthdayCell

+ (instancetype)initWithTableView:(UITableView *)tableView andReuseIdentifier:(NSString *)identifier {
    BirthdayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell) return cell;
    NSLog(@"cell created +++");
    
    cell = [[BirthdayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.backgroundColor = THEME_CELL_COLOR;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = THEME_CELL_LINE_COLOR;
    
    cell.prompt = [[UILabel alloc] init];
    [cell.prompt setFont:[UIFont systemFontOfSize:42 weight:UIFontWeightThin]];
    [cell.prompt setTextColor:UIColor.grayColor];
    [cell.prompt setNumberOfLines:1];
    [cell.prompt setLineBreakMode:NSLineBreakByTruncatingTail];
    
    cell.remindTime = [[UILabel alloc] init];
    cell.remindTime.textColor = UIColor.grayColor;
    [cell.remindTime setNumberOfLines:1];
    [cell.remindTime setLineBreakMode:NSLineBreakByTruncatingTail];
    
    cell.on = [[UISwitch alloc] init];
    cell.on.onTintColor = THEME_TEXT_COLOR;
    
    cell.isSwitchOn = @"FALSE";
    
    [cell.contentView addSubview:cell.prompt];
    [cell.contentView addSubview:cell.remindTime];
    [cell.contentView addSubview:cell.on];

    cell.prompt.translatesAutoresizingMaskIntoConstraints = NO;
    cell.remindTime.translatesAutoresizingMaskIntoConstraints = NO;
    cell.on.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *onCenterY = [NSLayoutConstraint constraintWithItem:cell.on
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:cell.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1
                                                                  constant:0];
    
    NSLayoutConstraint *onRight = [NSLayoutConstraint constraintWithItem:cell.on
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:cell.contentView
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1
                                                                constant:-18];
    
    NSLayoutConstraint *promptLeft = [NSLayoutConstraint constraintWithItem:cell.prompt
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:cell.contentView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1
                                                                   constant:12];
    
    NSLayoutConstraint *promptTop = [NSLayoutConstraint constraintWithItem:cell.prompt
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:cell.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1
                                                                  constant:12];
    
    NSLayoutConstraint *promptRight = [NSLayoutConstraint constraintWithItem:cell.prompt
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:cell.contentView
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1
                                                                    constant:-78];
    
    NSLayoutConstraint *remindTimeTop= [NSLayoutConstraint constraintWithItem:cell.remindTime
                                                                    attribute:NSLayoutAttributeTop
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:cell.prompt
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1
                                                                     constant:2];
    
    NSLayoutConstraint *remindTimeLeft = [NSLayoutConstraint constraintWithItem:cell.remindTime
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:cell.contentView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:12];
    
    NSLayoutConstraint *remindTimeRight = [NSLayoutConstraint constraintWithItem:cell.remindTime
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:cell.contentView
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:-78];
    
    NSLayoutConstraint *remindTimeBottom = [NSLayoutConstraint constraintWithItem:cell.remindTime
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:cell.contentView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:-12];
    
    [cell.contentView addConstraints:@[promptLeft, promptTop, promptRight, remindTimeTop, remindTimeLeft, remindTimeRight, remindTimeBottom, onCenterY, onRight]];
    
    [cell addObserver:cell forKeyPath:@"isSwitchOn" options:NSKeyValueObservingOptionNew context:nil];

    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (![keyPath isEqualToString:@"isSwitchOn"]) return;
    NSString *new = [change valueForKey:NSKeyValueChangeNewKey];
    if ([new isEqualToString:@"FALSE"]) {
        [self.prompt setTextColor:UIColor.grayColor];
        [self.remindTime setTextColor:UIColor.grayColor];
    } else {
        [self.prompt setTextColor:UIColor.whiteColor];
        [self.remindTime setTextColor:UIColor.whiteColor];
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"isSwitchOn"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
