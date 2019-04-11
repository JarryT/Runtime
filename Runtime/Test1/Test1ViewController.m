//
//  Test1ViewController.m
//  Runtime
//
//  Created by 汤军 on 2019/4/11.
//  Copyright © 2019年 汤军. All rights reserved.
//

#import "Test1ViewController.h"

@interface Person1 : NSObject

@property (nonatomic, copy)NSString *name;

- (void)print;

@end

@implementation Person1

- (void)print{
    NSLog(@"self.name = %@",self.name);
}

@end


@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    id cls = [Person1 class];
    
    void *obj = &cls;
    
    [(__bridge id)obj print];
}

@end
