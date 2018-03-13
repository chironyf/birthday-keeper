//
//  BirthdayCellModel.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/11.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "BirthdayCellModel.h"

@implementation BirthdayCellModel

- (instancetype)initWithPrompt:(NSString *)prompt CreatedTime:(NSString *)createdTime RemindTime:(NSString *)remindTime Height:(double)cellHeight {
    self = [super init];
    if (self) {
        _prompt = prompt;
        _createdTime = createdTime;
        _remindTime = remindTime;
        _cellHeight = cellHeight;
        _on = TRUE;
    }
    return self;
}


@end
