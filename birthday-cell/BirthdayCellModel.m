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

- (instancetype)initWithPrompt:(NSDate *)prompt CreatedTime:(NSString *)createdTime RemindTime:(NSString *)remindTime Height:(double)cellHeight {
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
    _prompt = [NSDate date];
    _createdTime = @"";
    _remindTime = @"";
    _cellHeight = 0.0f;
    _on = FALSE;
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
    
//    [aCoder encodeObject:_prompt forKey:@"prompt"];
//    [aCoder encodeObject:_createdTime forKey:@"createdTime"];
//    [aCoder encodeObject:_remindTime forKey:@"remindTime"];
//    [aCoder encodeDouble:_cellHeight forKey:@"cellHeight"];
//    [aCoder encodeBool:_on forKey:@"on"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *list = class_copyIvarList(self.class, &count);
        for (int i = 0; i < count; i++) {
            Ivar tmp = list[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(tmp)];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(list);
        
        
//        self.prompt = [aDecoder decodeObjectForKey:@"prompt"];
//        self.createdTime = [aDecoder decodeObjectForKey:@"createdTime"];
//        self.remindTime = [aDecoder decodeObjectForKey:@"remindTime"];
//        self.cellHeight = [aDecoder decodeDoubleForKey:@"cellHeight"];
//        self.on = [aDecoder decodeBoolForKey:@"on"];
    }
    return self;
}

- (NSString *)description {
    return self.remindTime;
}

- (id)copyWithZone:(NSZone *)zone {
    BirthdayCellModel * copyedModel = [[self.class allocWithZone:zone] init];
    copyedModel.prompt = self.prompt;
    copyedModel.createdTime = self.createdTime;
    copyedModel.cellHeight = self.cellHeight;
    copyedModel.remindTime = self.remindTime;
    copyedModel.on = self.on;
    return copyedModel;
}




@end
