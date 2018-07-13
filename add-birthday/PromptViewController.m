//
//  PromptViewController.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/13.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "PromptViewController.h"
#import "PromptEditCell.h"
#import "Config.h"

static NSString *const promtpIdentifier = @"PromptEditCellIdentifier";

@interface PromptViewController ()

@end

@implementation PromptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标签";
    self.view.backgroundColor = UIColor.whiteColor;
    
    _promptTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    
    [_promptTable setDelegate:self];
    [_promptTable setDataSource:self];
    _promptTable.separatorColor = THEME_CELL_LINE_COLOR;
//    _promptTable.estimatedRowHeight = 44;
    _promptTable.rowHeight = 44;
    _promptTable.translatesAutoresizingMaskIntoConstraints = NO;
    _promptTable.backgroundColor = THEME_COLOR;
    
    [self.view addSubview:_promptTable];
    
    NSLayoutConstraint *promptTableTop = [NSLayoutConstraint constraintWithItem:_promptTable
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:0];
    
    NSLayoutConstraint *promptTableBottom = [NSLayoutConstraint constraintWithItem:_promptTable
                                                                         attribute:NSLayoutAttributeBottom
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeBottom
                                                                        multiplier:1
                                                                          constant:0];
    
    NSLayoutConstraint *promptTableLeft = [NSLayoutConstraint constraintWithItem:_promptTable
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeLeft
                                                                      multiplier:1
                                                                        constant:0];
    
    NSLayoutConstraint *promptTableRight = [NSLayoutConstraint constraintWithItem:_promptTable
                                                                        attribute:NSLayoutAttributeRight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:0];
    
    [self.view addConstraints:@[promptTableTop, promptTableBottom, promptTableLeft, promptTableRight]];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    NSLog(@"view will appear");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PromptEditCell *cell = [PromptEditCell initWith:tableView andReuseIdentifier:promtpIdentifier];
    
    //设置textField代理以及改换行为完成键
    [cell.promptEditField setDelegate:self];
    cell.promptEditField.returnKeyType = UIReturnKeyDone;
    cell.promptEditField.keyboardAppearance = UIKeyboardAppearanceDark;
    cell.promptEditField.textColor = UIColor.whiteColor;
    
    [cell.promptEditField setTintColor:THEME_TEXT_COLOR];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //赋值
    cell.promptEditField.text = _prompt;
    
    return cell;
}

//点击完成会触发该函数
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.prompt = textField.text;
    self.returnNewPromptBlock(self.prompt);
    [self.navigationController popViewControllerAnimated:TRUE];
    return TRUE;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"请输入新的标签";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
