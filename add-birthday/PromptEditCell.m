//
//  PromptEditCell.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/13.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "PromptEditCell.h"
#import "GCON.h"

@implementation PromptEditCell

+ (instancetype)initWith:(UITableView *)tableView andReuseIdentifier:(NSString *)identifier {
    PromptEditCell *pCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!pCell) {
        pCell = [[PromptEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

        pCell.promptEditField = [[UITextField alloc] init];
        pCell.promptEditField.translatesAutoresizingMaskIntoConstraints = NO;
        [pCell.contentView addSubview:pCell.promptEditField];
        pCell.backgroundColor = [UIColor colorWithRed:themeCellRed green:themeCellGreen blue:themeCellBlue alpha:themeAlpha];
        
        NSLayoutConstraint *promptEditFieldCenterY = [NSLayoutConstraint constraintWithItem:pCell.promptEditField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:pCell.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        
        NSLayoutConstraint *promptEditFieldLeft = [NSLayoutConstraint constraintWithItem:pCell.promptEditField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:pCell.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:12];
        
        NSLayoutConstraint *promptEditFieldRight = [NSLayoutConstraint constraintWithItem:pCell.promptEditField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:pCell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-12];

        [pCell.contentView addConstraints:@[promptEditFieldCenterY, promptEditFieldLeft, promptEditFieldRight]];
        //设置编辑的时候右边的删除符号
        [pCell.promptEditField setClearButtonMode:UITextFieldViewModeWhileEditing];
    }
    NSLog(@"created pCell is %@", pCell);
    return pCell;
}

- (void)dealloc {
    NSLog(@"promt cell dealloc");
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
