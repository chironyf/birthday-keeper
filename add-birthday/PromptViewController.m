//
//  PromptViewController.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/13.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "PromptViewController.h"
#import "PromptEditCell.h"

@interface PromptViewController ()

@end

@implementation PromptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _promptTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    
    [_promptTable setDelegate:self];
    [_promptTable setDataSource:self];
    
    _promptTable.estimatedRowHeight = 44;
    _promptTable.rowHeight = UITableViewAutomaticDimension;
    _promptTable.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_promptTable];
    
    NSLayoutConstraint *promptTableTop = [NSLayoutConstraint constraintWithItem:_promptTable attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSLayoutConstraint *promptTableBottom = [NSLayoutConstraint constraintWithItem:_promptTable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *promptTableLeft = [NSLayoutConstraint constraintWithItem:_promptTable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *promptTableRight = [NSLayoutConstraint constraintWithItem:_promptTable attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    [self.view addConstraints:@[promptTableTop, promptTableBottom, promptTableLeft, promptTableRight]];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const identifier = @"PromptEditCellIdentifier";
    PromptEditCell *cell = [[PromptEditCell alloc] initWith:tableView andReuseIdentifier:identifier];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
