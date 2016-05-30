//
//  TabbarViewController.m
//  TabbarTest
//
//  Created by 刘国超 on 16/3/11.
//  Copyright © 2016年 刘国超. All rights reserved.
//

#import "LGCTabbarViewController.h"
#import "TestViewController.h"
#import "LGCAnimatedTabBarItem.h"
#import "AnimationFactory.h"
#import "RedViewController.h"
#import "BlueViewController.h"
#import "YellowViewController.h"
#import "GrayViewController.h"
#import "GreenViewController.h"

#import "AppDelegate.h"

#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND
#import <Masonry.h>

typedef enum
{
    ImageViewTag = 100,
    LabelTag,
}AnimatedTabBarControllerTag;

@interface LGCTabbarViewController ()
{
    NSMutableArray *_viewControllersArr;
    NSMutableArray *_containers;
    
    
}
@end

@implementation LGCTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _viewControllersArr = [NSMutableArray arrayWithCapacity:1];
    // 初始化所有的子控制器
    [self setupChildViewControllers];
    _containers = [self createViewContainers];
    [self createCustomIcons:_containers];
    //self.tabBar.userInteractionEnabled = NO;
    
    //tabbar上的view的tag值
    self.tabBarView.tag = 100;
    
}

/**
 * 初始化所有的子控制器
 */
- (void)setupChildViewControllers
{
    NSArray *titleArr = @[@"首页", @"分类", @"精华", @"购物车"];
    int animationArr[5] = {BounceAnimationType, TransitionAnimationType, FumeAnimationType, RotationAnimationType, FumeAnimationType};
    
    [self setupOneChildViewController:[[RedViewController alloc] init] title:titleArr[0] image:[NSString stringWithFormat:@"BarItemNormal1"] animationType:animationArr[0]];
    
    [self setupOneChildViewController:[[GreenViewController alloc] init] title:titleArr[1] image:[NSString stringWithFormat:@"BarItemNormal2"] animationType:animationArr[1]];

    [self setupOneChildViewController:[[GrayViewController alloc] init] title:titleArr[2] image:[NSString stringWithFormat:@"BarItemNormal3"] animationType:animationArr[2]];
    
    [self setupOneChildViewController:[[YellowViewController alloc] init] title:titleArr[3] image:[NSString stringWithFormat:@"BarItemNormal4"] animationType:animationArr[3]];
    
    //[self setupOneChildViewController:[[BlueViewController alloc] init] title:titleArr[3] image:[NSString stringWithFormat:@"BarItemNormal5"] animationType:animationArr[3]];
    
    
    self.viewControllers = _viewControllersArr;
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image animationType:(AnimationType)type
{
    vc.title = title;
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:vc];
    
    LGCAnimatedTabBarItem *animatedTb = [[LGCAnimatedTabBarItem alloc] init];
    animatedTb.animation = [AnimationFactory animationWithType:type];
    animatedTb.title = title;
    animatedTb.image = [UIImage imageNamed:image];
    vc.tabBarItem = animatedTb;
    [_viewControllersArr addObject:navigationVC];
}
/**
 *  创建tabbar的图片和label
 */
- (void)createCustomIcons:(NSMutableArray *)containers
{
    [self.tabBar.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LGCAnimatedTabBarItem *tabBarItem = obj;
        
        UIView *container = containers[idx];
        container.tag = idx;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:tabBarItem.image];
        imageView.tag = ImageViewTag;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [container addSubview:imageView];
        
        [imageView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(tabBarItem.image.size);
            make.centerY.equalTo(container).offset(-5);
            make.centerX.equalTo(container);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = LabelTag;
        label.text = tabBarItem.title;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [container addSubview:label];
        
        CGFloat width = self.tabBar.frame.size.width / self.tabBar.items.count;
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(width, 10));
            make.centerY.equalTo(container).offset(16);
            make.centerX.equalTo(container);
        }];
        
        if (idx == 0)
        {
            [tabBarItem selectedState:imageView textLabel:label];
        }
        
        // 去除原有设置
        tabBarItem.title = @"";
        tabBarItem.image = nil;
    }];
}


- (NSMutableArray *)createViewContainers
{
    //隐藏系统的tabbar
    self.tabBar.hidden = YES;
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    NSInteger count = self.tabBar.items.count;
    
    self.tabBarView = [[UIView alloc] initWithFrame:self.tabBar.frame];
    
    self.tabBarView.backgroundColor = [UIColor yellowColor];
    
    for (NSInteger i = 0; i < count; i++)
    {
        CGFloat containerViewW = self.view.frame.size.width/5;
        CGFloat containerViewX = containerViewW * i;
        CGFloat containerViewH = self.tabBar.bounds.size.height;
        
        UIView *viewContainer = [[UIView alloc] initWithFrame:CGRectMake(containerViewX, 0, containerViewW, containerViewH)];
        
        //标记item颜色
        viewContainer.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        
        viewContainer.tag = i;
        
        viewContainer.userInteractionEnabled = YES;
        
        [viewContainer addGestureRecognizer:tapGesture];
        
        [arr addObject:viewContainer];
        
        [self.tabBarView insertSubview:viewContainer atIndex:0];

    }
    
    [self.view addSubview:self.tabBarView];
    
    return arr;
}



- (void)tapAction:(UITapGestureRecognizer *)gesture
{
    NSLog(@"item被点击 %ld",gesture.view.tag);
    
    NSInteger currentIndex = gesture.view.tag;
    if (self.selectedIndex != currentIndex)
    {
        // 现在选中
        LGCAnimatedTabBarItem *item = (LGCAnimatedTabBarItem *)self.tabBar.items[currentIndex];
        UIView *container = _containers[currentIndex];
        
        //NSLog(@"frame == %@ ",NSStringFromCGRect(container.frame));
        
        UIImageView *imageView = (UIImageView *)[container viewWithTag:ImageViewTag];;
        UILabel *label = (UILabel *)[container viewWithTag:LabelTag];
        [item playAnimation:imageView textLabel:label];
        
        // 之前选中
        item = (LGCAnimatedTabBarItem *)self.tabBar.items[self.selectedIndex];
        container = _containers[self.selectedIndex];
        imageView = (UIImageView *)[container viewWithTag:ImageViewTag];;
        label = (UILabel *)[container viewWithTag:LabelTag];
        [item deselectAnimation:imageView textLabel:label];
        
        self.selectedIndex = currentIndex;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
