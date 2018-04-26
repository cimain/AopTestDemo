//
//  Test3ViewController.m
//  AopTestDemo
//
//  Created by ChenMan on 2018/4/26.
//  Copyright © 2018年 cimain. All rights reserved.
//

#import "Test3ViewController.h"

@interface Test3ViewController ()

@end

@implementation Test3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我" forState:UIControlStateNormal];
    
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 300, 90, 30);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
-(void)buttonClick{
    
    DDLogWarn(@"Test3ViewController -- -- NSLog -- btn is clicked ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
