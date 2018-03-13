//
//  PromptEditCell.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/13.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "PromptEditCell.h"

@implementation PromptEditCell

- (instancetype)initWith:(UITableView *)tableView andReuseIdentifier:(NSString *)identifier {
    PromptEditCell *pCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!pCell) {
        PromptEditCell *pCell = [[PromptEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        pCell.promptEditField = [[UITextField alloc] init];
        pCell.promptEditField.translatesAutoresizingMaskIntoConstraints = NO;
        [pCell.contentView addSubview:pCell.promptEditField];
        
        NSLayoutConstraint *promptEditFieldTop = [NSLayoutConstraint constraintWithItem:pCell.promptEditField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:pCell.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        
        NSLayoutConstraint *promptEditFieldBottom = [NSLayoutConstraint constraintWithItem:pCell.promptEditField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:pCell.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        
        NSLayoutConstraint *promptEditFieldLeft = [NSLayoutConstraint constraintWithItem:pCell.promptEditField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:pCell.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        
        NSLayoutConstraint *promptEditFieldRight = [NSLayoutConstraint constraintWithItem:pCell.promptEditField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:pCell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        
        [self.contentView addConstraints:@[promptEditFieldTop, promptEditFieldBottom, promptEditFieldLeft, promptEditFieldRight]];
        NSLog(@"prompt cell created");
        
    }
    return pCell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
