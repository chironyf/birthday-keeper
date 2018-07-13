//
//  BirthdayCellModel.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/11.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "BirthdayCellModel.h"
#import <objc/runtime.h>

@implementation BirthdayCellModel

- (instancetype)initWithPrompt:(NSDate *)prompt
                   CreatedTime:(NSString *)createdTime
                    RemindTime:(NSString *)remindTime
                        Height:(double)cellHeight {
    self = [super init];
    if (self) {
        _prompt = prompt;
        _createdTime = createdTime;
        _remindTime = remindTime;
        _cellHeight = cellHeight;
        _on = FALSE;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _prompt = [NSDate date];
        _createdTime = @"null";
        _remindTime = @"null";
        _cellHeight = 0.0f;
        _on = FALSE;
    }
    return self;
}

- (void)clear {
    self.prompt = [NSDate date];
    self.createdTime = @"";
    self.remindTime = @"";
    self.cellHeight = 0.0f;
    self.on = FALSE;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *list = class_copyIvarList(self.class, &count);
    for (int i = 0; i < count; i++) {
        Ivar tmp = list[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(tmp)];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(list);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *list = class_copyIvarList(self.class, &count);
        for (int i = 0; i < count; i++) {
            Ivar tmp = list[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(tmp)];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(list);
    }
    return self;
}

- (NSString *)description {
    return self.remindTime;
}

- (id)copyWithZone:(NSZone *)zone {
    BirthdayCellModel *copyedModel = [[self.class allocWithZone:zone] init];
    copyedModel.prompt = self.prompt;
    copyedModel.createdTime = self.createdTime;
    copyedModel.cellHeight = self.cellHeight;
    copyedModel.remindTime = self.remindTime;
    copyedModel.on = self.on;
    return copyedModel;
}

@end
