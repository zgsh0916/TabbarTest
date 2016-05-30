//
//  ThreeViewController.m
//  TabbarTest
//
//  Created by 王猛 on 16/5/23.
//  Copyright © 2016年 刘国超. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    
}

#pragma mark -- 页面将要出现时 隐藏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIView *backView = [self.tabBarController.view viewWithTag:100];
    [UIView animateWithDuration:0.25 animations:^{
        
        backView.frame = CGRectMake(0, self.view.frame.size.height, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
        
    }];
    
}

#pragma mark -- 页面将要消失时 出现
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    UIView *backView = [self.tabBarController.view viewWithTag:100];
    [UIView animateWithDuration:0.25 animations:^{
        
        backView.frame = CGRectMake(0, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
        
    }];
    
}

@end
