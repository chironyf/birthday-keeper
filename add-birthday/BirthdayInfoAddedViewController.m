//
//  BirthdayInfoAddedViewController.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/12.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "BirthdayInfoAddedViewController.h"
#import "BirthdayCellModel.h"
#import "PromptViewController.h"

@interface BirthdayInfoAddedViewController ()

@end

@implementation BirthdayInfoAddedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加生日";
    
    
    _list = [NSMutableArray<NSMutableArray *> array];
    NSMutableArray *section1 = [@[@"标签"] mutableCopy];
    NSMutableArray *section2 = [@[@"删除生日"] mutableCopy];
    [_list addObject:section1];
    [_list addObject:section2];

    self.view.backgroundColor = UIColor.whiteColor;
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    _datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_datePicker];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.estimatedRowHeight = 44;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    NSLayoutConstraint *datePickerTop = [NSLayoutConstraint constraintWithItem:_datePicker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSLayoutConstraint *datePickerLeft = [NSLayoutConstraint constraintWithItem:_datePicker attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *datePickerRight = [NSLayoutConstraint constraintWithItem:_datePicker attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    NSLayoutConstraint *tableTop = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_datePicker attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSLayoutConstraint *tableBottom = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSLayoutConstraint *tableLeft = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *tableRight = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    [self.view addSubview:_tableView];
    [self.view addConstraints:@[tableTop, tableBottom, tableLeft, tableRight, datePickerTop, datePickerLeft, datePickerRight]];
    
    // Do any additional setup after loading the view.
}

//选中cell之后返回取消cell的选中状态
- (void)viewWillAppear:(BOOL)animated {
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:TRUE];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list[section].count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PromptViewController *b = [[PromptViewController alloc] init];
        [self.navigationController pushViewController:b animated:YES];
    } else {
        NSLog(@"section2 called");
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const identifer = @"addBirthdayCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        NSLog(@"创建了新的单元格");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.textLabel.text = _list[indexPath.section][indexPath.row];
        if (indexPath.section == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        } else {
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = UIColor.redColor;
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return cell;
}


- (void)addSubviews {
    
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
