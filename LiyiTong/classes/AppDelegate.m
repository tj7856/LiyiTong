//
//  AppDelegate.m
//  LiyiTong
//
//  Created by zhangtijie on 16/7/27.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "AccountMgr.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "loginViewController.h"
#import <AFNetworking.h>
#import "WXApi.h"
#import "WXApiManager.h"
#import <AFHTTPSessionManager.h>
#import <TencentOpenAPI/TencentOAuth.h>
static void uncaughtExceptionHandler(NSException *exception) {
    
    NSLog(@"CRASH: %@", exception);
    
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    
    // Internal error reporting
    
}

@interface AppDelegate ()<WXApiDelegate>


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);

    [[AccountMgr instance] accountMgrInitialize];
   
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[MainViewController alloc] init];
    
    
    [self.window makeKeyAndVisible];

    [UMSocialData setAppKey:@"57abd5eae0f55a3a230035fb"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxa569aa9c820763f8" appSecret:@"dfb01834d478baae575446862212bcc1" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL
    [UMSocialQQHandler setQQWithAppId:@"1105518549" appKey:@"zCu8lrHM1Xrd1uHl" url:@"http://www.umeng.com/social"];
    //向微信注册
    [WXApi registerApp:@"wxa569aa9c820763f8"];
    

    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result =[UMSocialSnsService handleOpenURL:url]||[WXApi handleOpenURL:url delegate:self]||[TencentOAuth HandleOpenURL:url];
//    if (result==FALSE) {
//        result=[WXApi handleOpenURL:url delegate:self];
//    }
    return  result;
}
////系统回调，注意和支付宝冲突
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url]||[WXApi handleOpenURL:url delegate:self]||[TencentOAuth HandleOpenURL:url];
//    if (result == FALSE) {
//        result=[WXApi handleOpenURL:url delegate:self];
//        //调用其他SDK，例如支付宝SDK等
//    }
    NSLog(@"%d",result);
    return result;
}
-(void) onReq:(BaseReq*)reqonReq{
    
}
-(void) onResp:(BaseResp*)resp{
    switch (resp.errCode) {
        case 0://用户同意
        {
            SendAuthResp *aresp = (SendAuthResp *)resp;
            [self weChatCallBackWithCode:aresp.code];
            NSLog(@"用户同意");
        }
            break;
        case -4://用户拒绝授权
            //do ...
            break;
        case -2://用户取消
            //do ...
            break;
        default:
            break;
    }
}
- (void)weChatCallBackWithCode:(NSString *)code{
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wxa569aa9c820763f8",@"dfb01834d478baae575446862212bcc1",code];
//    loginViewController *loginVC = [[loginViewController alloc]init];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"获取用户信息" object:nil userInfo:dic];
//        [loginVC getUserInfoWithAccessToken:[dic objectForKey:@"access_token"] andOpenId:[dic objectForKey:@"openid"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取用户信息失败");
    }];
    
}
//wx获取用户信息
- (void)getUserInfoWithAccessToken:(NSString *)accessToken andOpenId:(NSString *)openId{
    
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openId];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"用户的信息%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取用户信息失败");
    }];
}
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options{
//    BOOL result = [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
//    if (result == FALSE) {
//        NSLog(@"失败");
//        //调用其他SDK，例如支付宝SDK等
//        
//    }
//    return result;
//}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 登录需要编写
    
    [UMSocialSnsService applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
