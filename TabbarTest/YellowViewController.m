//
//  YellowViewController.m
//  TabbarTest
//
//  Created by 王猛 on 16/5/30.
//  Copyright © 2016年 刘国超. All rights reserved.
//

#import "YellowViewController.h"
#import "TowViewController.h"
@interface YellowViewController ()

@end

@implementation YellowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *go = [[UIButton alloc]initWithFrame:CGRectMake(150, 300, 100, 100)];
    go.backgroundColor = [UIColor blueColor];
    [go setTitle:@"FUCKING" forState:0];
    [go addTarget: self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:go];
    
    self.view.backgroundColor = [UIColor yellowColor];
}

-(void)go{
    
    TowViewController *v = [[TowViewController alloc]init];
    
    [self.navigationController pushViewController:v animated:YES];
    
    
}


@end
