//
//  ViewController.m
//  Runtime
//
//  Created by 汤军 on 2019/4/11.
//  Copyright © 2019年 汤军. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *array = @[@{@"class":@"Test1ViewController", @"info":@"2019.04.11 runtime面试题"},
                       ];    
    _dataSource = [NSMutableArray arrayWithArray:array];
    _tableView.delegate= self;
    _tableView.dataSource = self;
//    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.textLabel.text = dict[@"class"];
    cell.detailTextLabel.text = dict[@"info"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.dataSource[indexPath.row];
    NSString *className = dict[@"class"];
    Class class = NSClassFromString(className);
    [self.navigationController pushViewController:[class new] animated:true];
}

@end
