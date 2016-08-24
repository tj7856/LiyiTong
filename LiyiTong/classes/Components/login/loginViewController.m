//
//  loginViewController.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/4.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "loginViewController.h"
#import <SDAutoLayout.h>
#import "findPassWordViewController.h"
#import <AFNetworking.h>
#import "YFAlert.h"
#import "LYTAfnetworkingManager.h"
#import "CheckPhone.h"
#import "UIViewController+SLHUD.h"
#import "sendSMS.h"
#import "userRegister.h"
#import "login.h"
#import "AFNetworkReachabilityManager.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface loginViewController ()<TencentSessionDelegate>
{
    NSString *isNot;
    TencentOAuth *tencentOAuth;
}
@property (nonatomic,strong)UIView *view1;
@property (nonatomic,strong)UITextField *view1PhoneNum;
@property (nonatomic,strong)UITextField *view1PassWord;
@property (nonatomic,strong)UIButton *loginBtn;

@property (nonatomic,strong)UIView *view2;
@property (nonatomic,strong)UITextField *view2PhoneNum;
@property (nonatomic,strong)UITextField *view2CodeNum;
@property (nonatomic,strong)UIButton *view2GetCode;
@property (nonatomic,strong)UIButton *loginByCode;

@property (nonatomic,strong)UIView *view3;
@property (nonatomic,strong)UITextField *view3PhoneNum;
@property (nonatomic,strong)UITextField *view3CodeNum;
@property (nonatomic,strong)UIButton *view3GetCode;
@property (nonatomic,strong)UITextField *view3PassWord;
@property (nonatomic,strong)UIButton *agree;
@property (nonatomic,strong)UIButton *registerBtn;
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden=YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(action:) name:@"获取用户信息" object:nil];
    
    
    UIImageView *img =
    [[UIImageView alloc]initWithFrame:
     [UIScreen mainScreen].bounds];
    img.image=[UIImage imageNamed:@"密码登录"];
    [self.view addSubview:img];
    
    UIButton *dismissBtn=[[UIButton alloc]init];
    [dismissBtn setImage:[UIImage imageNamed:@"x_03"] forState:UIControlStateNormal];
    [self.view addSubview:dismissBtn];
    [dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    dismissBtn.sd_layout.leftSpaceToView(self.view,10).topSpaceToView(self.view,50*WidthScale).widthIs(25).heightIs(25);
    
    UIImageView *userHeader=[[UIImageView alloc]init];
    userHeader.image=[UIImage imageNamed:@"tou_03"];
    userHeader.layer.cornerRadius=5;
    [self.view addSubview:userHeader];
    userHeader.sd_layout.topSpaceToView(self.view,130*WidthScale).leftSpaceToView(self.view,305*WidthScale).widthIs(150*WidthScale).heightIs(150*WidthScale);
    
    UILabel *lyitong=[[UILabel alloc]init];
    lyitong.textAlignment=NSTextAlignmentCenter;
    lyitong.textColor=[UIColor whiteColor];
    lyitong.text=@"登录礼意通";
    lyitong.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:lyitong];
    lyitong.sd_layout.topSpaceToView(userHeader,10).leftSpaceToView(self.view,275*WidthScale).rightSpaceToView(self.view,275*WidthScale).heightIs(35*WidthScale);
    
    [self loginView];
    [self codeLoginView];
    [self userRegister];

    NSInteger networkState=[self reachability];
    switch (networkState) {
        case AFNetworkReachabilityStatusUnknown:
            NSLog(@"当前网络>>>未检测到网络");
            break;
        case AFNetworkReachabilityStatusNotReachable:
            NSLog(@"当前网络>>>网络关闭");
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            NSLog(@"当前网络>>>蜂窝网络");
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            NSLog(@"当前网络>>>WIFI");
            break;
            
        default:
            break;
    }

    UIView *leftView=[[UIView alloc]init];
    leftView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:leftView];
    leftView.sd_layout.leftSpaceToView(self.view,99*WidthScale).bottomSpaceToView(self.view,240*WidthScale).widthIs(80*WidthScale).heightIs(1);
    UIView *rightView=[[UIView alloc]init];
    rightView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:rightView];
    rightView.sd_layout.rightSpaceToView(self.view,99*WidthScale).bottomSpaceToView(self.view,240*WidthScale).widthIs(80*WidthScale).heightIs(1);
    UILabel *label=[[UILabel alloc]init];
    label.text=@"使用社交账号登录";
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    label.sd_layout.leftSpaceToView(leftView,0).rightSpaceToView(rightView,0).heightIs(20).bottomSpaceToView(self.view,220*WidthScale);
    
    UIButton *weixin=[[UIButton alloc]init];
    [weixin setTitle:@"微信登录" forState:UIControlStateNormal];
    [weixin  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    weixin.backgroundColor=[UIColor whiteColor];
    [weixin addTarget:self action:@selector(weixinLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weixin];
    weixin.sd_layout.leftSpaceToView(self.view,90*WidthScale).bottomSpaceToView(self.view,97*WidthScale).widthIs(280*WidthScale).heightIs(80*WidthScale);
    
    UIButton *QQ=[[UIButton alloc]init];
    [QQ setTitle:@"QQ登录" forState:UIControlStateNormal];
    [QQ  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    QQ.backgroundColor=[UIColor whiteColor];
    [QQ addTarget:self action:@selector(QQLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QQ];
    QQ.sd_layout.rightSpaceToView(self.view,90*WidthScale).bottomSpaceToView(self.view,97*WidthScale).widthIs(280*WidthScale).heightIs(80*WidthScale);

}
#pragma mark---view1 登录---
-(void)loginView{
    self.view1=[[UIView alloc]init];
    self.view1.backgroundColor=[UIColor clearColor];
    self.view1.frame=CGRectMake(0, 326*WidthScale, ScreenWidth, 700*WidthScale);
    [self.view addSubview:self.view1];
    
    self.view1PhoneNum=[[UITextField alloc]init];
    //    phoneNum.borderStyle=UITextBorderStyleNone;
    self.view1PhoneNum.keyboardType=UIKeyboardTypePhonePad;
    self.view1PhoneNum.clearButtonMode=UITextFieldViewModeAlways;
    self.view1PhoneNum.placeholder=@"请输入手机号";
    self.view1PhoneNum.frame=CGRectMake(95*WidthScale, 68*WidthScale, ScreenWidth-95*2*WidthScale, 70*WidthScale);
    [self.view1 addSubview:self.view1PhoneNum];
    UIImageView *phone=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60*WidthScale, 58*WidthScale)];
    phone.image=[UIImage imageNamed:@"phone_03"];
    phone.contentMode=UIViewContentModeScaleAspectFit;
    self.view1PhoneNum.leftView=phone;
    self.view1PhoneNum.leftViewMode=UITextFieldViewModeAlways;
//    phoneNum.sd_layout.leftSpaceToView(self.view1,-645*WidthScale).topSpaceToView(self.view1,-485*WidthScale).rightSpaceToView(self.view1,-645*WidthScale).heightIs(70*WidthScale);
    
    UIView *view1=[[UIView alloc]init];
    view1.backgroundColor=[UIColor whiteColor];
    [self.view1 addSubview:view1];
    view1.sd_layout.leftEqualToView(self.view1PhoneNum).rightEqualToView(self.view1PhoneNum).topSpaceToView(self.view1PhoneNum,1).heightIs(1);
    
    self.view1PassWord=[[UITextField alloc]init];
    self.view1PassWord.clearButtonMode=UITextFieldViewModeAlways;
    self.view1PassWord.placeholder=@"请输入密码";
    self.view1PassWord.secureTextEntry=YES;
    [self.view1 addSubview:self.view1PassWord];
    UIImageView *lock=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60*WidthScale, 58*WidthScale)];
    lock.image=[UIImage imageNamed:@"lock_03"];
    lock.contentMode=UIViewContentModeScaleAspectFit;
    self.view1PassWord.leftView=lock;
    self.view1PassWord.leftViewMode=UITextFieldViewModeAlways;
    self.view1PassWord.sd_layout.leftEqualToView(self.view1PhoneNum).rightEqualToView(self.view1PhoneNum).heightIs(70*WidthScale).topSpaceToView(view1,40*WidthScale);
    UIView *view2=[[UIView alloc]init];
    view2.backgroundColor=[UIColor whiteColor];
    [self.view1 addSubview:view2];
    view2.sd_layout.leftEqualToView(self.view1PassWord).rightEqualToView(self.view1PassWord).topSpaceToView(self.view1PassWord,1).heightIs(1);
    
    UIButton *findBtn=[[UIButton alloc]init];
    [findBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [findBtn setTitleColor:Color(171, 188, 199) forState:UIControlStateNormal];
    findBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    findBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [findBtn addTarget:self action:@selector(findPassWord:) forControlEvents:UIControlEventTouchUpInside];
    [self.view1 addSubview:findBtn];
    findBtn.sd_layout.topSpaceToView(view2,25*WidthScale).rightEqualToView(view2).widthIs(80).heightIs(35*WidthScale);
    
    self.loginBtn=[[UIButton alloc]init];
    self.loginBtn.backgroundColor=Color(11, 231, 196);
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font=[UIFont systemFontOfSize:24];
    [self.loginBtn addTarget:self action:@selector(passWordLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view1 addSubview:self.loginBtn];
    self.loginBtn.sd_layout.leftEqualToView(self.view1PassWord).rightEqualToView(self.view1PassWord).topSpaceToView(findBtn,100*HeightScale).heightIs(80*WidthScale);
    
    UIButton *loginByNum=[[UIButton alloc]init];
    [loginByNum setTitle:@"使用验证码登录" forState:UIControlStateNormal];
    [loginByNum setTitleColor:Color(171, 188, 199) forState:UIControlStateNormal];
    loginByNum.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    loginByNum.titleLabel.font=[UIFont systemFontOfSize:16];
    [loginByNum addTarget:self action:@selector(gotoView2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view1 addSubview:loginByNum];
    loginByNum.sd_layout.leftEqualToView(self.loginBtn).topSpaceToView(self.loginBtn,35*HeightScale).widthRatioToView(self.loginBtn,0.5).heightIs(35*WidthScale);
    
    UIButton *registerBtn=[[UIButton alloc]init];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:Color(171, 188, 199) forState:UIControlStateNormal];
    registerBtn.tag=10;
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    registerBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [registerBtn addTarget:self action:@selector(gotoView3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view1 addSubview:registerBtn];
    registerBtn.sd_layout.topEqualToView(loginByNum).rightEqualToView(self.loginBtn).bottomEqualToView(loginByNum).widthIs(50);
}
#pragma mark---view2 验证码登录---
-(void)codeLoginView{
    self.view2=[[UIView alloc]init];
    self.view2.backgroundColor=[UIColor clearColor];
    self.view2.frame=CGRectMake(-ScreenWidth, 326*WidthScale, ScreenWidth, 700*WidthScale);
    [self.view addSubview:self.view2];
    
    self.view2PhoneNum=[[UITextField alloc]init];
    //    phoneNum.borderStyle=UITextBorderStyleNone;
    self.view2PhoneNum.keyboardType=UIKeyboardTypePhonePad;
    self.view2PhoneNum.clearButtonMode=UITextFieldViewModeAlways;
    self.view2PhoneNum.placeholder=@"请输入手机号";
    self.view2PhoneNum.frame=CGRectMake(95*WidthScale, 68*WidthScale, ScreenWidth-95*2*WidthScale, 70*WidthScale);
    [self.view2 addSubview:self.view2PhoneNum];
    UIImageView *phone=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60*WidthScale, 58*WidthScale)];
    phone.image=[UIImage imageNamed:@"phone_03"];
    phone.contentMode=UIViewContentModeScaleAspectFit;
    self.view2PhoneNum.leftView=phone;
    self.view2PhoneNum.leftViewMode=UITextFieldViewModeAlways;
    
    UIView *view1=[[UIView alloc]init];
    view1.backgroundColor=[UIColor whiteColor];
    [self.view2 addSubview:view1];
    view1.sd_layout.leftEqualToView(self.view2PhoneNum).rightEqualToView(self.view2PhoneNum).topSpaceToView(self.view2PhoneNum,1).heightIs(1);
    
    self.view2GetCode=[[UIButton alloc]init];
    self.view2GetCode.tag=12;
    [self.view2GetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view2GetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.view2GetCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.view2GetCode.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.view2GetCode addTarget:self action:@selector(view2GetCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view2 addSubview:self.view2GetCode];
    self.view2GetCode.sd_layout.topSpaceToView(self.view2PhoneNum,20*WidthScale).rightEqualToView(self.view2PhoneNum).heightIs(45*WidthScale).widthIs(230*WidthScale);
    
    self.view2CodeNum=[[UITextField alloc]init];
    self.view2CodeNum.keyboardType=UIKeyboardTypePhonePad;
    self.view2CodeNum.clearButtonMode=UITextFieldViewModeAlways;
    self.view2CodeNum.placeholder=@"请输入验证码";
    [self.view2 addSubview:self.view2CodeNum];
    UIImageView *email=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60*WidthScale, 58*WidthScale)];
    email.image=[UIImage imageNamed:@"xinfeng"];
    email.contentMode=UIViewContentModeScaleAspectFit;
    self.view2CodeNum.leftView=email;
    self.view2CodeNum.leftViewMode=UITextFieldViewModeAlways;
    self.view2CodeNum.sd_layout.leftEqualToView(self.view2PhoneNum).rightEqualToView(self.view2PhoneNum).heightIs(70*WidthScale).topSpaceToView(view1,80*WidthScale);
    UIView *view2=[[UIView alloc]init];
    view2.backgroundColor=[UIColor whiteColor];
    [self.view2 addSubview:view2];
    view2.sd_layout.leftEqualToView(self.view2CodeNum).rightEqualToView(self.view2CodeNum).topSpaceToView(self.view2CodeNum,1).heightIs(1);
    
    self.loginByCode=[[UIButton alloc]init];
    self.loginByCode.backgroundColor=Color(11, 231, 196);
    [self.loginByCode setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginByCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginByCode.titleLabel.font=[UIFont systemFontOfSize:24];
    [self.view2 addSubview:self.loginByCode];
    self.loginByCode.sd_layout.leftEqualToView(self.view2CodeNum).rightEqualToView(self.view2CodeNum).topSpaceToView(view2,160*HeightScale).heightIs(80*WidthScale);
    
    UIButton *loginByNum=[[UIButton alloc]init];
    [loginByNum setTitle:@"使用密码登录" forState:UIControlStateNormal];
    [loginByNum setTitleColor:Color(171, 188, 199) forState:UIControlStateNormal];
    loginByNum.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    loginByNum.titleLabel.font=[UIFont systemFontOfSize:16];
    [loginByNum addTarget:self action:@selector(gotoView1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view2 addSubview:loginByNum];
    loginByNum.sd_layout.leftEqualToView(self.loginByCode).topSpaceToView(self.loginByCode,35*HeightScale).widthRatioToView(self.loginByCode,0.5).heightIs(35*WidthScale);
    
    UIButton *registerBtn=[[UIButton alloc]init];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:Color(171, 188, 199) forState:UIControlStateNormal];
    registerBtn.tag=20;
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    registerBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [registerBtn addTarget:self action:@selector(gotoView3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view2 addSubview:registerBtn];
    registerBtn.sd_layout.topEqualToView(loginByNum).rightEqualToView(self.loginByCode).bottomEqualToView(loginByNum).widthIs(50);

}
#pragma mark---view3 注册---
-(void)userRegister{
    self.view3=[[UIView alloc]init];
    self.view3.backgroundColor=[UIColor clearColor];
    self.view3.frame=CGRectMake(ScreenWidth, 326*WidthScale, ScreenWidth, 700*WidthScale);
    [self.view addSubview:self.view3];
    
    self.view3PhoneNum=[[UITextField alloc]init];
    //    phoneNum.borderStyle=UITextBorderStyleNone;
    self.view3PhoneNum.keyboardType=UIKeyboardTypePhonePad;
    self.view3PhoneNum.clearButtonMode=UITextFieldViewModeAlways;
    self.view3PhoneNum.placeholder=@"请输入手机号";
    self.view3PhoneNum.frame=CGRectMake(95*WidthScale, 68*WidthScale, ScreenWidth-95*2*WidthScale, 70*WidthScale);
    [self.view3 addSubview:self.view3PhoneNum];
    UIImageView *phone=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60*WidthScale, 58*WidthScale)];
    phone.image=[UIImage imageNamed:@"phone_03"];
    phone.contentMode=UIViewContentModeScaleAspectFit;
    self.view3PhoneNum.leftView=phone;
    self.view3PhoneNum.leftViewMode=UITextFieldViewModeAlways;
    
    self.view3GetCode=[[UIButton alloc]init];
    self.view3GetCode.tag=13;
    [self.view3GetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view3GetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.view3GetCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.view3GetCode.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.view3GetCode addTarget:self action:@selector(view3GetCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view3 addSubview:self.view3GetCode];
    self.view3GetCode.sd_layout.topSpaceToView(self.view3PhoneNum,20*WidthScale).rightEqualToView(self.view3PhoneNum).heightIs(45*WidthScale).widthIs(230*WidthScale);
    
    UIView *view1=[[UIView alloc]init];
    view1.backgroundColor=[UIColor whiteColor];
    [self.view3 addSubview:view1];
    view1.sd_layout.leftEqualToView(self.view3PhoneNum).rightEqualToView(self.view3PhoneNum).topSpaceToView(self.view3PhoneNum,1).heightIs(1);
    
    self.view3CodeNum=[[UITextField alloc]init];
    //    phoneNum.borderStyle=UITextBorderStyleNone;
    self.view3CodeNum.keyboardType=UIKeyboardTypePhonePad;
    self.view3CodeNum.clearButtonMode=UITextFieldViewModeAlways;
    self.view3CodeNum.placeholder=@"请输入验证码";
    [self.view3 addSubview:self.view3CodeNum];
    UIImageView *email=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60*WidthScale, 58*WidthScale)];
    email.image=[UIImage imageNamed:@"xinfeng"];
    email.contentMode=UIViewContentModeScaleAspectFit;
    self.view3CodeNum.leftView=email;
    self.view3CodeNum.leftViewMode=UITextFieldViewModeAlways;
    self.view3CodeNum.sd_layout.leftEqualToView(self.view3PhoneNum).rightEqualToView(self.view3PhoneNum).heightIs(70*WidthScale).topSpaceToView(view1,80*WidthScale);
    UIView *view2=[[UIView alloc]init];
    view2.backgroundColor=[UIColor whiteColor];
    [self.view3 addSubview:view2];
    view2.sd_layout.leftEqualToView(self.view3CodeNum).rightEqualToView(self.view3CodeNum).topSpaceToView(self.view3CodeNum,1).heightIs(1);
    
    self.view3PassWord=[[UITextField alloc]init];
    self.view3PassWord.clearButtonMode=UITextFieldViewModeAlways;
    self.view3PassWord.placeholder=@"请输入密码";
    self.view3PassWord.secureTextEntry=YES;
    [self.view3 addSubview:self.view3PassWord];
    UIImageView *lock=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60*WidthScale, 58*WidthScale)];
    lock.image=[UIImage imageNamed:@"lock_03"];
    lock.contentMode=UIViewContentModeScaleAspectFit;
    self.view3PassWord.leftView=lock;
    self.view3PassWord.leftViewMode=UITextFieldViewModeAlways;
    self.view3PassWord.sd_layout.leftEqualToView(self.view3CodeNum).rightEqualToView(self.view3CodeNum).heightIs(70*WidthScale).topSpaceToView(self.view3CodeNum,40*WidthScale);
    UIView *view3=[[UIView alloc]init];
    view3.backgroundColor=[UIColor whiteColor];
    [self.view3 addSubview:view3];
    view3.sd_layout.leftEqualToView(self.view3PassWord).rightEqualToView(self.view3PassWord).topSpaceToView(self.view3PassWord,1).heightIs(1);
    
    _agree=[[UIButton alloc]init];
    [_agree setImage:[UIImage imageNamed:@"d"] forState:UIControlStateNormal];
    [_agree setImage:[UIImage imageNamed:@"d_active"] forState:UIControlStateSelected];
    [_agree addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    [self.view3 addSubview:_agree];
    _agree.sd_layout.topSpaceToView(view3,25*WidthScale).leftEqualToView(view3).heightIs(35*WidthScale).widthIs(35*WidthScale);
    
    UIButton *findBtn=[[UIButton alloc]init];
    [findBtn setTitle:@"我已阅读并同意礼意通服务协议" forState:UIControlStateNormal];
    [findBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    findBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    findBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.view3 addSubview:findBtn];
    findBtn.sd_layout.topSpaceToView(view3,25*WidthScale).leftSpaceToView(_agree,1).widthIs(300).heightIs(35*WidthScale);
    
    self.registerBtn=[[UIButton alloc]init];
    self.registerBtn.backgroundColor=Color(11, 231, 196);
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font=[UIFont systemFontOfSize:24];
    [self.registerBtn addTarget:self action:@selector(userRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view3 addSubview:self.registerBtn];
    self.registerBtn.sd_layout.leftEqualToView(self.view3PassWord).rightEqualToView(self.view3PassWord).topSpaceToView(findBtn,100*HeightScale).heightIs(80*WidthScale);
    
    UIButton *registerBtn=[[UIButton alloc]init];
    [registerBtn setTitle:@"登录" forState:UIControlStateNormal];
    [registerBtn setTitleColor:Color(171, 188, 199) forState:UIControlStateNormal];
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    registerBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [registerBtn addTarget:self action:@selector(backView1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view3 addSubview:registerBtn];
    registerBtn.sd_layout.rightEqualToView(self.registerBtn).topSpaceToView(self.registerBtn,35*HeightScale).widthRatioToView(self.registerBtn,0.5).heightIs(35*WidthScale);
}
#pragma mark---页面的滑动---
-(void)gotoView2:(UIButton *)sender{
    [UIView animateWithDuration:0.5 animations:^{
        self.view1.x=ScreenWidth;
        self.view2.x=0;
    }];
}
-(void)gotoView1:(UIButton *)sender{
    [UIView animateWithDuration:0.5 animations:^{
        self.view1.x=0;
        self.view2.x=-ScreenWidth;
    }];
}
-(void)gotoView3:(UIButton *)sender{
    if (sender.tag==10) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view1.x=-ScreenWidth;
            self.view3.x=0;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.view1.x=-ScreenWidth;
            self.view2.x=-2*ScreenWidth;
            self.view3.x=0;
        }];
    }
    
}
-(void)backView1:(UIButton *)sender{
    [UIView animateWithDuration:0.5 animations:^{
        self.view1.x=0;
        self.view3.x=ScreenWidth;
    }];
}
-(void)agree:(UIButton *)sender{
    sender.selected=!sender.selected;
}
-(void)findPassWord:(UIButton *)sender{
    findPassWordViewController *find=[[findPassWordViewController alloc]init];
    [self presentViewController:find animated:YES completion:nil];
}
-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark---获取验证码---
-(void)view3GetCode:(UIButton *)sender{
    BOOL isPhone=[self isMobileNumber:self.view3PhoneNum.text];
    
    NSInteger networkState=[self reachability];
        if (networkState==0||networkState==1) {
        if (networkState==0) {
            [YFAlert showAlertViewCertainWithTitle:@"未检测到网络" WithUIViewController:self];
        }
        if (networkState==1) {
            [YFAlert showAlertViewCertainWithTitle:@"请打开您的网络设置" WithUIViewController:self];
        }
    } else {

    if (isPhone==YES) {
        [self isNotRegister:self.view3PhoneNum.text];
            } else {
        [YFAlert showAlertViewCertainWithTitle:@"请检查您的手机号是否有误" WithUIViewController:self];
    }
    
    }
    
}
-(void)view2GetCode:(UIButton *)sender{
    BOOL isPhone=[self isMobileNumber:self.view2PhoneNum.text];
    [self isNotRegister:self.view2PhoneNum.text];
    NSString *isnot=@"";
    NSInteger networkState=[self reachability];
    if (networkState==0||networkState==1) {
        if (networkState==0) {
            [YFAlert showAlertViewCertainWithTitle:@"未检测到网络" WithUIViewController:self];
        }
        if (networkState==1) {
            [YFAlert showAlertViewCertainWithTitle:@"请打开您的网络设置" WithUIViewController:self];
        }
    } else {
    if (isPhone==YES) {
        if ([isnot isEqualToString:@"尚未注册"]) {
            [self getPassNum:self.view2GetCode withPhoneNum:self.view2PhoneNum];
        }if ([isnot isEqualToString:@"已经注册"]) {
            [YFAlert showAlertViewCertainWithTitle:@"手机号已被注册" WithUIViewController:self];
        }else {
            [YFAlert showAlertViewCertainWithTitle:@"服务器开小差了o(╯□╰)o" WithUIViewController:self];
        }
    } else {
        [YFAlert showAlertViewCertainWithTitle:@"请检查您的手机号是否有误" WithUIViewController:self];
    }
    }
}
-(void)getPassNum:(UIButton *)sender withPhoneNum:(UITextField *)phoneNum{
    
    LYTAfnetworkingManager *manager = [LYTAfnetworkingManager new];
    [self showHint:@"验证码发送中..."];
    sendSMS *sendSms=[sendSMS new];
    sendSms.parameters=@{@"phone":phoneNum.text};
    [manager sendRequest:sendSms response:^(NSError *err) {
        if (!err) {
            [self makeLabelAtLeft:sender];
        }else{
            [YFAlert showAlertViewCertainWithTitle:@"未知错误" WithUIViewController:self];
        }
    }];
}
-(void)makeLabelAtLeft:(UIButton *)sender{
    UILabel *label=[[UILabel alloc]init];
    label.textColor=[UIColor orangeColor];
    label.textAlignment=NSTextAlignmentRight;
    label.font=[UIFont systemFontOfSize:16];
    if (sender.tag==12) {
        [self.view2 addSubview:label];
    } else {
        [self.view3 addSubview:label];
    }
    
    label.sd_layout.bottomEqualToView(sender).rightSpaceToView(sender,0).widthIs(40).heightIs(45*WidthScale);
    
    
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
                
                sender.userInteractionEnabled = YES;
                
                label.text=nil;
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 59;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                NSLog(@"____%@",strTime);
                label.text=strTime;
                [sender setTitle:@"秒后重新获取" forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);

}
#pragma mark---状态监测---
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
//发送验证码结果
-(void)isNotRegister:(NSString *)mobileNum{
    
    LYTAfnetworkingManager *manager = [LYTAfnetworkingManager new];
    CheckPhone *req = [CheckPhone new];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    req.parameters =  @{@"phone":mobileNum}; //@(month)
    [manager sendRequest:req response:^(NSError *err) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!err) {
            int regisrered=[req.success[@"status"] intValue];
            NSLog(@"%d",regisrered);
            if (regisrered==1) {
                [MBProgressHUD hideHUDForView:self.view animated:NO];
                [self getPassNum:self.view3GetCode withPhoneNum:self.view3PhoneNum];
//                isNot=@"尚未注册";
                NSLog(@"isNot%@",@"尚未注册");
                [self returnIsNot:isNot];
            }else{
                [YFAlert showAlertViewCertainWithTitle:@"手机号已被注册" WithUIViewController:self];
//                isNot=@"已经注册";
                [self returnIsNot:@"已经注册"];
                NSLog(@"isNot%@",isNot);
            }
        }else{
//            isNot=@"服务器错误";
            [YFAlert showAlertViewCertainWithTitle:@"服务器开小差了o(╯□╰)o" WithUIViewController:self];
            [self returnIsNot:@"服务器错误"];
            NSLog(@"err%@",err);
        }
        
//        NSLog(@"isNot%@",isNot);
    }];
    
}
-(void)returnIsNot:(NSString *)isnot{
    isNot=isnot;
    NSLog(@"isNot%@",isNot);
    
}
-(NSString *)isnotregister{
    NSString *notregister=[isNot copy];
    return notregister;
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
#pragma mark---注册 与 登录---
//view1密码登录
-(void)passWordLogin:(UIButton *)sender{
    NSInteger networkState=[self reachability];
    if (networkState==0||networkState==1) {
        if (networkState==0) {
            [YFAlert showAlertViewCertainWithTitle:@"未检测到网络" WithUIViewController:self];
        }
        if (networkState==1) {
            [YFAlert showAlertViewCertainWithTitle:@"请打开您的网络设置" WithUIViewController:self];
        }
    } else {
    LYTAfnetworkingManager *manager = [LYTAfnetworkingManager new];
    login *userlogin=[login new];
    userlogin.parameters=@{@"phone":self.view1PhoneNum.text,@"password":self.view1PassWord.text};
    [manager sendRequest:userlogin response:^(NSError *err) {
        if (!err) {
            [self showHint:@"登录成功"];
        }else{
            [YFAlert showAlertViewCertainWithTitle:@"登录失败" WithUIViewController:self];
        }
    }];
    }
}
//view2验证码登录
-(void)codeNumLogin:(UIButton *)sender{
    NSInteger networkState=[self reachability];
    if (networkState==0||networkState==1) {
        if (networkState==0) {
            [YFAlert showAlertViewCertainWithTitle:@"未检测到网络" WithUIViewController:self];
        }
        if (networkState==1) {
            [YFAlert showAlertViewCertainWithTitle:@"请打开您的网络设置" WithUIViewController:self];
        }
    } else {
        
    }
}
//view3注册
-(void)userRegister:(UIButton *)sender{
    NSInteger networkState=[self reachability];
    if (networkState==0||networkState==1) {
        if (networkState==0) {
            [YFAlert showAlertViewCertainWithTitle:@"未检测到网络" WithUIViewController:self];
        }
        if (networkState==1) {
            [YFAlert showAlertViewCertainWithTitle:@"请打开您的网络设置" WithUIViewController:self];
        }
    } else {
    if (self.agree.selected==YES) {
        sendSMS *req = [sendSMS new];
        if ([self.view3CodeNum.text isEqualToString:req.success[@"msg"]]) {
            LYTAfnetworkingManager *manager = [LYTAfnetworkingManager new];
            userRegister *sendSms=[userRegister new];
            sendSms.parameters=@{@"phone":self.view3PhoneNum.text,@"password":self.view3PassWord.text,@"code":self.view3CodeNum.text};
            [manager sendRequest:sendSms response:^(NSError *err) {
                if (!err) {
                    [self showHint:@"注册成功"];
                }else{
                    [YFAlert showAlertViewCertainWithTitle:@"注册失败" WithUIViewController:self];
                }
            }];
        }else{
            [YFAlert showAlertViewCertainWithTitle:@"验证码错误" WithUIViewController:self];
        }

    }else{
        [YFAlert showAlertViewCertainWithTitle:@"请阅读并同意服务协议" WithUIViewController:self];
    }
    }
    
}
#pragma mark---QQ与微信登录---
-(void)QQLogin:(UIButton *)sender{
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

-(void)weixinLogin:(UIButton *)sender{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
