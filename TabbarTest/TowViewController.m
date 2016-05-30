//
//  WMViewController.m
//  TabbarTest
//
//  Created by 王猛 on 16/5/18.
//  Copyright © 2016年 刘国超. All rights reserved.
//

#import "TowViewController.h"
#import "LGCTabbarViewController.h"
#import "ThreeViewController.h"

@interface TowViewController ()

@end

@implementation TowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    
    NSLog(@"subviews = %@",self.tabBarController.view.subviews);
    
    UIButton *go = [[UIButton alloc]initWithFrame:CGRectMake(150, 300, 100, 100)];
    go.backgroundColor = [UIColor blueColor];
    [go setTitle:@"跳转" forState:0];
    [go addTarget: self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:go];
    // Do any additional setup after loading the view.
}

-(void)go{
    
    ThreeViewController *v = [[ThreeViewController alloc]init];
    
    [self.navigationController pushViewController:v animated:YES];
    
    
}


#warning 可以将以下两个方法写在基类中

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
