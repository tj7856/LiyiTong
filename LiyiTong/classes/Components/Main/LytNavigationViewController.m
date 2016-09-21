//
//  LytViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/7/27.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "LytNavigationViewController.h"
#import "SelectedView.h"
#import "confrimOrderViewController.h"


@interface LytNavigationViewController ()

@end

@implementation LytNavigationViewController

+ (void)initialize
{
//    UINavigationBar *bar = [UINavigationBar appearance];
//    [bar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count) { // 隐藏导航栏
        viewController.hidesBottomBarWhenPushed = YES;
        if (self.childViewControllers.count ==1) {
            for (UIView *view in self.navigationBar.subviews) {
            if ([view isKindOfClass:[SelectedView class]]) {
                [view removeFromSuperview];
            }
        }
        }
        
        // 自定义返回按钮
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"back_9x16"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        // 如果自定义返回按钮后, 滑动返回可能失效, 需要添加下面的代码
        __weak typeof(viewController)Weakself = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
    }
    [super pushViewController:viewController animated:animated];
}

//-(UIViewController *)popViewControllerAnimated:(BOOL)animated
//{
//   return  [super popViewControllerAnimated:animated];
//}

- (void)back
{
//    // 判断两种情况: push 和 present
//    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }else
//        [self popViewControllerAnimated:YES];
//}
    NSLog(@"%@, %@",self.presentingViewController,self.presentedViewController);
    if ( [self.presentingViewController isKindOfClass:[confrimOrderViewController class]]) {
        [(confrimOrderViewController *)self.presentedViewController rightButtonAction];
    
    }
    else
    {
        [self popViewControllerAnimated:YES];
    }
}

@end
