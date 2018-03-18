//
//  BirthdayCellModel.h
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/11.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BirthdayCellModel : NSObject <NSCopying, NSCoding>

//设置为日期类型
@property (nonatomic, strong) NSDate *prompt;

@property (nonatomic, strong) NSString *createdTime;

@property (nonatomic, strong) NSString *remindTime;

@property (nonatomic, assign) double cellHeight;

//标记是否被取消，默认是TRUE
@property (nonatomic,  getter=isOn, assign) BOOL on;

- (instancetype)initWithPrompt:(NSString *)prompt CreatedTime:(NSString *)createdTime RemindTime:(NSString *)remindTime Height:(double)cellHeight;

- (instancetype)init;
//清空数据
- (void)clear;

@end
