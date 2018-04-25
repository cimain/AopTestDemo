//
//  ViewController.m
//  AopTestDemo
//
//  Created by ChenMan on 2018/4/25.
//  Copyright © 2018年 cimain. All rights reserved.
//

#import "ViewController.h"
#import "Test1ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)  UINavigationController *naviVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Test1ViewController *test1 = [[Test1ViewController alloc] init];
    _naviVC = [[UINavigationController alloc] initWithRootViewController:test1];
    [self.view addSubview:_naviVC.view];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


@end
