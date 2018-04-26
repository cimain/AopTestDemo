//
//  Test1ViewController.m
//  AopTestDemo
//
//  Created by ChenMan on 2018/4/25.
//  Copyright © 2018年 cimain. All rights reserved.
//

#import "Test1ViewController.h"
#import "Test2ViewController.h"
#import "Test3ViewController.h"
#import "Test4ViewController.h"


@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Test1ViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
}

- (void)setupSubViews{
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 80, 100, 80)];
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(action1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 180, 100, 80)];
    [btn2 setTitle:@"btn2" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(action2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(100, 280, 100, 80)];
    [btn3 setTitle:@"btn3" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(action3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(100, 380, 100, 80)];
    [btn4 setTitle:@"btn4" forState:UIControlStateNormal];
    btn4.backgroundColor = [UIColor redColor];
    [btn4 addTarget:self action:@selector(action4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)action1{
    DDLogWarn(@"Test1ViewController -- NSLog -- btn2 is clicked");
}

- (void)action2{
    Test2ViewController *vc2 = [[Test2ViewController alloc] init];
    [self.navigationController pushViewController:vc2 animated:NO];
}

-(void)action3{
    Test3ViewController *vc3 = [[Test3ViewController alloc]init];
    [self.navigationController pushViewController:vc3 animated:YES];
}

-(void)action4{
    Test4ViewController *vc4 = [[Test4ViewController alloc]init];
    [self.navigationController pushViewController:vc4 animated:YES];
    
}

@end
