//
//  TestViewController.m
//  TabbarTest
//
//  Created by 刘国超 on 16/3/11.
//  Copyright © 2016年 刘国超. All rights reserved.
//

#import "TestViewController.h"
#import "TowViewController.h"
#import "LGCTabbarViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *go = [[UIButton alloc]initWithFrame:CGRectMake(150, 300, 100, 100)];
    go.backgroundColor = [UIColor blueColor];
    [go setTitle:@"FUCKING" forState:0];
    [go addTarget: self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:go];
    
}

-(void)go{
    
    TowViewController *v = [[TowViewController alloc]init];
    
    [self.navigationController pushViewController:v animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
