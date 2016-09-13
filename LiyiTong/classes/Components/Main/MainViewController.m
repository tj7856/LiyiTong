//
//  MainViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/7/27.
//  Copyright © 2016年 WanYu. All rights reserved.
//
#import <CoreText/CoreText.h>
#import "MainViewController.h"
#import "LytNavigationViewController.h"
#import "bangbangViewController.h"
#import "ConnectionViewController.h"
#import "HomeViewController.h"
#import "MeViewController.h"
#import "WishViewController.h"
#import "TColorfulTabBar.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
    
//    self.toolbarItems
}

-(void)setup
{
    
    TColorfulTabBar *tabBar = [[TColorfulTabBar alloc] initWithFrame:self.tabBar.frame];
    [self setValue:tabBar forKey:@"tabBar"];

    [self addChildViewController:[[HomeViewController alloc] init] imageNamed:@"toolbar_home"title:@"主页"];
    
    [self addChildViewController:[[WishViewController alloc] init] imageNamed:@"toolbar_vow" title:@"许愿"];
    [self addChildViewController:[[bangbangViewController alloc] init] imageNamed:@"toolbar_help" title:@"帮帮"];
    
    [self addChildViewController:[[ConnectionViewController alloc] init] imageNamed:@"toolbar_contacts" title:@"人脉"];
    [self addChildViewController:[[MeViewController alloc] init] imageNamed:@"toolbar_me" title:@"我"];
}

- (void)addChildViewController:(UIViewController *)childController imageNamed:(NSString *)imageName title:(NSString *)title
{
    LytNavigationViewController *nav = [[LytNavigationViewController alloc] initWithRootViewController:childController];
//    childController.tabBarItem.title = title;
    
//    NSDictionary *dic =@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor colorWithRed:11/255.0 green:231/255.0 blue:196/255.0 alpha:1]};
//    colorWithRed:141 green:216 blue:178 alpha:0
//    [childController.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel", imageName]];
    // 设置图片居中, 这儿需要注意top和bottom必须绝对值一样大
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor cyanColor];
    UIBarButtonItem *BTN = [[UIBarButtonItem alloc]initWithCustomView:v];
    childController.toolbarItems =@[BTN];
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    // 设置导航栏为透明的
    //    if ([childController isKindOfClass:[ProfileController class]]) {
    //        [nav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //        nav.navigationBar.shadowImage = [[UIImage alloc] init];
    //        nav.navigationBar.translucent = YES;
    //    }
    [self addChildViewController:nav];
}
@end
