//
//  Singleton.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/4/18.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "Singleton.h"
#import "BirthdayCellModel.h"
#import <Foundation/Foundation.h>

@implementation Singleton

+ (instancetype)sharedInstance {
    static Singleton *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
