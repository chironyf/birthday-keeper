//
//  Singleton.h
//  birthday-keeper
//
//  Created by   chironyf on 2018/4/18.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BirthdayCellModel;
@interface Singleton : NSObject
@property (nonatomic, strong) NSMutableArray<BirthdayCellModel *> *birthdayInfo;

+ (instancetype)sharedInstance;

@end
