//
//  BirthdayCellModel.h
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/11.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BirthdayCellModel : NSObject <NSCopying, NSCoding>
///提示标签
@property (nonatomic, copy) NSDate *prompt;

@property (nonatomic, copy) NSString *createdTime;

@property (nonatomic, copy) NSString *remindTime;

@property (nonatomic, assign) double cellHeight;
///默认推送关闭
@property (nonatomic,  getter=isOn, assign) BOOL on;

- (instancetype)initWithPrompt:(NSDate *)prompt
                   CreatedTime:(NSString *)createdTime
                    RemindTime:(NSString *)remindTime
                        Height:(double)cellHeight;

- (instancetype)init;

- (void)clear;

@end
