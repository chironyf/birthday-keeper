//
//  PromptViewController.h
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/13.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromptViewController : UIViewController 

@property (nonatomic, strong) NSString *prompt;

//就一行
@property (nonatomic, strong) UITableView *promptTable;


@end
