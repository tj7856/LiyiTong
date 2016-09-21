//
//  MBProgressHUD+Add.h
//  视频客户端
//
//  Created by niu mu on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
//带有指示器的
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
//只是显示文字
+ (MBProgressHUD *)showJustMessage:(NSString *)message toView:(UIView *)view;
@end
