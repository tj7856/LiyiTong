//
//  LoginVC.m
//  LiyiTong
//
//  Created by zhangtijie on 16/9/5.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "LoginVC.h"
#import "YFAlert.h"
#import "LYTAfnetworkingManager.h"
#import "login.h"
#import "CodeLogin.h"
#import "sendSMS.h"
#import "userRegister.h"
#import "CheckPhone.h"
#import "UIViewController+SLHUD.h"
#import <AFNetworking.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "PreferencesMgr.h"


#define KEY_USER_PRELOGIN_MODE                   @"lyt.per.login.mode"

@interface LoginVC ()<UITextFieldDelegate>
{
     TencentOAuth *tencentOAuth;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginLeading;
@property (weak, nonatomic) IBOutlet UITextField *normalShoujihao;
@property (weak, nonatomic) IBOutlet UITextField *normalMIma;
@property (weak, nonatomic) IBOutlet UIButton *normalLogBTN;
@property (weak, nonatomic) IBOutlet UITextField *YZshouji;
@property (weak, nonatomic) IBOutlet UITextField *YZmima;
@property (weak, nonatomic) IBOutlet UIButton *YZyanzhengBTN;
@property (weak, nonatomic) IBOutlet UILabel *daojishi;
@property (weak, nonatomic) IBOutlet UITextField *ZCshoujihao;
@property (weak, nonatomic) IBOutlet UITextField *ZCyanzhengma;
@property (weak, nonatomic) IBOutlet UITextField *ZCmima;
@property (weak, nonatomic) IBOutlet UIButton *xieyiBTN;
@property (weak, nonatomic) IBOutlet UIButton *ZClogBTN;
@property (weak, nonatomic) IBOutlet UILabel *ZCdaojishi;
@property (weak, nonatomic) IBOutlet UIButton *YZloginBTN;
@property (weak, nonatomic) IBOutlet UIButton *ZCyanzhengBTN;
@property (weak, nonatomic) IBOutlet UIButton *ZYyanzhengBTN;
@property (weak, nonatomic) IBOutlet UIView *PreLoginMode;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Prelog;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PrelogBottom;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setup];
}
-(void)setup
{
    
    self.title = @"登录";
    
    self.ZCyanzhengma.tintColor =self.YZmima.tintColor=self.ZCyanzhengma.tintColor =self.normalMIma.tintColor=self.ZCshoujihao.tintColor=self.YZshouji.tintColor =self.normalShoujihao.tintColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(action:) name:@"获取用户信息" object:nil];
//    self.navigationController.navigationBar.
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                    [UIColor whiteColor], UITextAttributeTextColor,[UIFont systemFontOfSize:18], UITextAttributeFont,
                                                                     nil]];
    // 自定义返回按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:(CGRectMake(0, 0, 25, 25))];
    [btn setImage:[UIImage imageNamed:@"x_03"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [btn sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:(UIBarButtonItemStylePlain) target:self action:@selector(regist)];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor colorWithRed:0 green:1 blue:204/255.0 alpha:1];
    
    // 设置导航条透明
    // UIBarMetricsDefault:必须传入这个家伙
    // 传入一个空的UIImage
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航条阴影背景
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    NSString *mode = [PreferencesMgr getObject:KEY_USER_PRELOGIN_MODE];
    CGPoint start = self.PreLoginMode.center;
    if ([mode isEqualToString:@"QQ"]) {
//        self.Prelog.constant = -92;
        CGPoint temp = start;
        temp.x +=92;
        start = temp;
        
        
    }
    else if([mode isEqualToString:@"weixin"])
    {
//        self.Prelog.constant = 92;
//        self.Prelog.constant = -92;
        CGPoint temp = start;
        temp.x -=92;
        start = temp;

    }
    else if([mode isEqualToString:@"weibo"])
    {
//          self.Prelog.constant = 0;
    }
    else
    {
        self.PreLoginMode.hidden = YES;
    }
    //1.创建核心动画
        //    CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:<#(NSString *)#>]
         CABasicAnimation *anima=[CABasicAnimation animation];
    
         //1.1告诉系统要执行什么样的动画
         anima.keyPath=@"position";
         //设置通过动画，将layer从哪儿移动到哪儿
    
         anima.fromValue=[NSValue valueWithCGPoint:start
                          ];
         anima.toValue=[NSValue valueWithCGPoint:CGPointMake(start.x, start.y-2)];
    
    NSString *str=NSStringFromCGRect(self.PreLoginMode.frame);
        NSLog(@"执行前：%@",str);
         //1.2设置动画执行完毕之后不删除动画
         anima.removedOnCompletion=NO;
         //1.3设置保存动画的最新状态
         anima.fillMode=kCAFillModeForwards;
         anima.delegate=self;
    anima.repeatCount = 1000;
    anima.duration = 1;
    anima.autoreverses = YES;
         //打印
//         NSString *str=NSStringFromCGPoint(self.myLayer.position);
//         NSLog(@"执行前：%@",str);
    
        //2.添加核心动画到layer
         [self.PreLoginMode.layer addAnimation:anima forKey:@"position"];
    
    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)regist
{
    self.title = @"注册";
    self.LoginLeading.constant=[UIScreen mainScreen].bounds.size.width;
    // 执行动画
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.navigationItem.rightBarButtonItem.title=@"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)xieyiClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)changeMode:(UIButton *)sender {
//    [UIView animateWithDuration:0.5 animations:^{
//              }];
           if (sender.tag==1||sender.tag==2) {
       
               if (sender.tag==2) {
                   self.navigationItem.rightBarButtonItem.title=@"注册";
                   self.title = @"登录";
               }
               

            self.LoginLeading.constant=-[UIScreen mainScreen].bounds.size.width;}
   
        else
        {
            self.LoginLeading.constant = 0;
        }

    
    // 执行动画
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
  
    
}
- (IBAction)ForgotPwd:(id)sender {
}
- (IBAction)getYanzhengma:(UIButton *)sender {
    if (sender.tag ==1) {
        
//        [self getPassNum:self.ZCshoujihao];
        [self isNotRegister:self.ZCshoujihao WithBTN:sender];
    }
    else
    {
        [self getPassNum:self.YZshouji WithBTN:sender];
    }
    
   
}
-(void)getPassNum:(UITextField *)phoneNum WithBTN:(UIButton *)sender{
    
    LYTAfnetworkingManager *manager = [LYTAfnetworkingManager new];
    [self showHint:@"验证码发送中..."];
    sendSMS *sendSms=[[sendSMS alloc]init];
    sendSms.parameters=@{@"phone":phoneNum.text};
    [manager sendRequest:sendSms response:^(NSError *err) {
        if (!err) {
            //            [self makeLabelAtLeft:sender]; UILabel *label;
            UILabel *label;
            if (sender.tag==1) {
                label = self.ZCdaojishi;
            }
            else
            {
                label = self.daojishi;
            }
            
            __block int timeout=30; //倒计时时间
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            
            dispatch_source_set_event_handler(_timer, ^{
                
                if(timeout<=0){ //倒计时结束，关闭
                    
                    dispatch_source_cancel(_timer);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //设置界面的按钮显示 根据自己需求设置
                        //                    _getPassNum.titleLabel.text=@"获取验证码";
                        [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                        
                        sender.enabled = YES;
                        
                        label.text=nil;
                        //                self.daojishi.text = nil;
                    });
                    
                }else{
                    
                    //            int minutes = timeout / 60;
                    
                    int seconds = timeout % 59;
                    
                    NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //设置界面的按钮显示 根据自己需求设置
                        
                        NSLog(@"____%@",strTime);
                        label.text=strTime;
                        //                self.daojishi.text =strTime;
                        [sender setTitle:@"秒后重新获取" forState:UIControlStateNormal];
                        //                sender.userInteractionEnabled = NO;
                        
                    });
                    
                    timeout--;
                    
                }
                
            });
            
            dispatch_resume(_timer);
        }else{
            [YFAlert showAlertViewCertainWithTitle:@"未知错误" WithUIViewController:self];
        }
    }];
}

//发送验证码结果
-(void)isNotRegister:(UITextField *)mobileNum WithBTN:(UIButton *)Btn{
    
    LYTAfnetworkingManager *manager = [LYTAfnetworkingManager new];
    CheckPhone *req = [CheckPhone new];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    req.parameters =  @{@"phone":mobileNum.text}; //@(month)
    [manager sendRequest:req response:^(NSError *err) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!err) {
            int regisrered=[req.success[@"status"] intValue];
            NSLog(@"%d",regisrered);
            if (regisrered==1) {
                [MBProgressHUD hideHUDForView:self.view animated:NO];
                [self getPassNum:mobileNum WithBTN:Btn];
                //                isNot=@"尚未注册";
                NSLog(@"isNot%@",@"尚未注册");
//                [self returnIsNot:isNot];
            }else{
                [YFAlert showAlertViewCertainWithTitle:@"手机号已被注册" WithUIViewController:self];
                //                isNot=@"已经注册";
//                [self returnIsNot:@"已经注册"];
//                NSLog(@"isNot%@",isNot);
            }
        }else{
            //            isNot=@"服务器错误";
            [YFAlert showAlertViewCertainWithTitle:@"服务器开小差了o(╯□╰)o" WithUIViewController:self];
//            [self returnIsNot:@"服务器错误"];
//            NSLog(@"err%@",err);
        }
        
        //        NSLog(@"isNot%@",isNot);
    }];
    
}

- (IBAction)Login:(UIButton *)sender {
    NSLog(@"登录");
    NSInteger networkState=[self reachability];
    if (networkState==0||networkState==1) {
        if (networkState==0) {
            [YFAlert showAlertViewCertainWithTitle:@"未检测到网络" WithUIViewController:self];
        }
        if (networkState==1) {
            [YFAlert showAlertViewCertainWithTitle:@"请打开您的网络设置" WithUIViewController:self];
        }
    } else {
        if (sender.tag == 1) {
            [self NormalLogin];
        }
        else if (sender.tag == 2)
        {
            [self shortcutLogin];
        }
        else if (sender.tag == 3)
        {
            if (!self.xieyiBTN.selected) {
                [self RegisterLogin];
            }
            else
            {
                [YFAlert showAlertViewCertainWithTitle:@"请阅读并同意服务协议" WithUIViewController:self];
            }
            
        }
           }

}

-(void)NormalLogin
{
    LYTAfnetworkingManager *manager = [LYTAfnetworkingManager new];
    login *userlogin=[login new];
    userlogin.parameters=@{@"phone":self.normalShoujihao.text,@"password":self.normalMIma.text};
    [manager sendRequest:userlogin response:^(NSError *err) {
        if (!err) {
            [self showHint:@"登录成功"];
        }else{
            [YFAlert showAlertViewCertainWithTitle:@"登录失败" WithUIViewController:self];
        }
    }];

}

-(void)shortcutLogin
{
    LYTAfnetworkingManager *manager = [LYTAfnetworkingManager new];
    CodeLogin *codelogin=[CodeLogin new];
    codelogin.parameters=@{@"phone":self.YZshouji.text,@"code":self.YZmima.text};
    [manager sendRequest:codelogin response:^(NSError *err) {
        if (!err) {
            [self showHint:@"登录成功"];
        }else{
            [YFAlert showAlertViewCertainWithTitle:@"登录失败" WithUIViewController:self];
        }
    }];

}
-(void)RegisterLogin
{
    LYTAfnetworkingManager *manager = [LYTAfnetworkingManager new];
    userRegister *sendSms=[userRegister new];
    sendSms.parameters=@{@"phone":self.ZCshoujihao.text,@"password":self.ZCmima.text,@"code":self.ZCyanzhengma.text};
    [manager sendRequest:sendSms response:^(NSError *err) {
        if (!err) {
            [self showHint:@"注册成功"];
        }else{
            [YFAlert showAlertViewCertainWithTitle:@"注册失败" WithUIViewController:self];
        }
    }];

}
//监测网络状态
-(NSInteger )reachability{
    __block NSInteger statusR;
    AFNetworkReachabilityManager *reachabilityManager= [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                statusR=status;
                NSLog(@"当前网络>>>未检测到网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                statusR=status;
                NSLog(@"当前网络>>>网络关闭");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                statusR=status;
                NSLog(@"当前网络>>>蜂窝网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                statusR=status;
                NSLog(@"当前网络>>>WIFI");
                break;
                
            default:
                break;
        }
        NSLog(@"statusR %ld",statusR);
    }];
    
    return statusR;
    
    
}
// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}


#pragma mark UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ((textField == self.normalShoujihao&&![self.normalShoujihao.text isEqualToString:@""])||(textField == self.YZshouji&&![self.YZshouji.text isEqualToString:@""])||(textField == self.ZCshoujihao&&![self.ZCshoujihao.text isEqualToString:@""])) {
        if (![self isMobileNumber:textField.text]) {
             [YFAlert showAlertViewCertainWithTitle:@"请检查您的手机号是否有误" WithUIViewController:self];
            self.YZyanzhengBTN.enabled = NO;
             self.ZCyanzhengBTN.enabled = NO;
        }
        else
        {
            if (textField == self.YZshouji) {
                self.YZyanzhengBTN.enabled = YES;
            }
            if (textField == self.ZCshoujihao) {
                self.ZCyanzhengBTN.enabled = YES;
            }
        }
       
    }
    if (![self.normalShoujihao.text isEqualToString:@""]&&![self.normalMIma.text isEqualToString:@""]) {
        self.normalLogBTN.enabled = YES;
    }
    else
    {
        self.normalLogBTN.enabled = NO;
    }
    if (![self.YZshouji.text isEqualToString:@""]&&![self.YZmima.text isEqualToString:@""]) {
        self.YZloginBTN.enabled = YES;
    }
    else
    {
        self.YZloginBTN.enabled = NO;
    }
    if (![self.ZCshoujihao.text isEqualToString:@""]&&![self.ZCmima.text isEqualToString:@""]&&![self.ZCyanzhengma.text isEqualToString:@""]) {
        self.ZClogBTN.enabled = YES;
    }
    else
    {
        self.ZClogBTN.enabled = NO;
    }
}

#pragma mark---QQ与微信登录---
-(IBAction)QQLogin:(UIButton *)sender{
    tencentOAuth=[[TencentOAuth alloc]initWithAppId:@"1105518549"andDelegate:self];
    NSArray *permissions= [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo",@"get_vip_info",@"get_vip_rich_info",@"get_info",@"add_t",nil];
    //    permissions = [NSArray arrayWithObjects:
    //                   kOPEN_PERMISSION_GET_USER_INFO,
    //                   kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
    //                   kOPEN_PERMISSION_ADD_SHARE,
    //                   kOPEN_PERMISSION_CHECK_PAGE_FANS,
    //                   kOPEN_PERMISSION_GET_INFO,
    //                   kOPEN_PERMISSION_GET_OTHER_INFO,
    //                   kOPEN_PERMISSION_GET_VIP_INFO,
    //                   kOPEN_PERMISSION_GET_VIP_RICH_INFO,
    //                   nil];
    [tencentOAuth authorize:permissions inSafari:NO];
}
#pragma mark -- TencentSessionDelegate
//登陆完成调用
- (void)tencentDidLogin
{
    //    resultLable.text =@"登录完成";
    //    [YFAlert showAlertViewCertainWithTitle:@"登录完成" WithUIViewController:self];
    if (tencentOAuth.accessToken &&0 != [tencentOAuth.accessToken length])
    {
        //  记录登录用户的OpenID、Token以及过期时间
        //        tokenLable.text =tencentOAuth.accessToken;
        [tencentOAuth getUserInfo];
        [self getuserJson:tencentOAuth.accessToken openid:tencentOAuth.openId];
        [PreferencesMgr saveObject:@"QQ" with:KEY_USER_PRELOGIN_MODE];
    }
    else
    {
        //        tokenLable.text =@"登录不成功没有获取accesstoken";
        [YFAlert showAlertViewCertainWithTitle:@"登录失败" WithUIViewController:self];
    }
}
-(void)getuserJson:(NSString *)accessToken openid:(NSString *)openId{
    __weak __typeof(self) weakSelf = self;
    NSString *urlString =[NSString stringWithFormat:@"https://graph.qq.com/user/get_user_info?access_token=%@&oauth_consumer_key=1105518549&openid=%@&format=json",accessToken,openId];
    //    NSDictionary *parameters =@{@"access_token":accessToken,@"oauth_consumer_key":@"12345",@"openid":openId,@"format":@"json"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"用户的信息%@",dic);
        //        NSLog(@"用户的名字%@",dic[@"nickname"]);
        //        [[NSUserDefaults standardUserDefaults] setObject:dic[@"nickname"] forKey:@"nickname"];
        //        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取用户信息失败");
    }];
}

//非网络错误导致登录失败：
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"tencentDidNotLogin");
    if (cancelled)
    {
        //        resultLable.text =@"用户取消登录";
        [YFAlert showAlertViewCertainWithTitle:@"您已取消登录" WithUIViewController:self];
    }else{
        //        resultLable.text =@"登录失败";
        [YFAlert showAlertViewCertainWithTitle:@"登录失败" WithUIViewController:self];
    }
}
// 网络错误导致登录失败：
-(void)tencentDidNotNetWork
{
    NSLog(@"tencentDidNotNetWork");
    //    resultLable.text =@"无网络连接，请设置网络";
    [YFAlert showAlertViewCertainWithTitle:@"无网络连接，请设置网络" WithUIViewController:self];
}

-(IBAction)weixinLogin:(UIButton *)sender{
    //    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    //
    //    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
    //
    //        if (response.responseCode == UMSResponseCodeSuccess) {
    //
    //            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
    //            NSLog(@"%@",dict);
    //            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
    //            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
    //
    //        }
    //
    //    });
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}
//wx获取用户信息
- (void)getUserInfoWithAccessToken:(NSString *)accessToken andOpenId:(NSString *)openId{
    __weak __typeof(self) weakSelf = self;
    
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo"];
    NSDictionary *parameters =@{@"access_token":accessToken,@"openid":openId};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"用户的信息%@",dic);
        NSLog(@"用户的名字%@",dic[@"nickname"]);
        [[NSUserDefaults standardUserDefaults] setObject:dic[@"nickname"] forKey:@"nickname"];
         [PreferencesMgr saveObject:@"weixin" with:KEY_USER_PRELOGIN_MODE];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取用户信息失败");
    }];
}
-(void)action:(NSNotification *)not{
    NSLog(@"接到通知%@",not.name);
    NSLog(@"接到通知%@",not.userInfo);
    NSDictionary *dic=not.userInfo;
    [self getUserInfoWithAccessToken:[dic objectForKey:@"access_token"] andOpenId:[dic objectForKey:@"openid"]];
}


@end
