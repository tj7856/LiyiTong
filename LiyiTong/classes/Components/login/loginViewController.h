//
//  loginViewController.h
//  LiyiTong
//
//  Created by 耿远风 on 16/8/4.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController
- (void)getUserInfoWithAccessToken:(NSString *)accessToken andOpenId:(NSString *)openId;
@end
