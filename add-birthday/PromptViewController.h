//
//  PromptViewController.h
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/13.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnNewPrompt)(NSString *newPrompt);

@interface PromptViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextInputTraits>

//接收传过来的prompt
@property (nonatomic, copy) NSString *prompt;
//就一行
@property (nonatomic, strong) UITableView *promptTable;

@property (nonatomic, copy)  returnNewPrompt returnNewPromptBlock;


@end
