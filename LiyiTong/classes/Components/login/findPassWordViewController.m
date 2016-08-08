//
//  findPassWordViewController.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/5.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "findPassWordViewController.h"
#import <SDAutoLayout.h>
@interface findPassWordViewController ()

@property (nonatomic,strong)UIView *view1;

@end

@implementation findPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden=YES;
    
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
    
    [self findPassWord];
}
-(void)findPassWord{
    self.view1=[[UIView alloc]init];
    self.view1.backgroundColor=[UIColor clearColor];
    self.view1.frame=CGRectMake(0, 326*WidthScale, ScreenWidth, 700*WidthScale);
    [self.view addSubview:self.view1];
    
    UITextField *phoneNum=[[UITextField alloc]init];
    //    phoneNum.borderStyle=UITextBorderStyleNone;
    phoneNum.keyboardType=UIKeyboardTypePhonePad;
    phoneNum.clearButtonMode=UITextFieldViewModeAlways;
    phoneNum.placeholder=@"请输入手机号";
    phoneNum.frame=CGRectMake(95*WidthScale, 68*WidthScale, ScreenWidth-95*2*WidthScale, 70*WidthScale);
    [self.view1 addSubview:phoneNum];
    UIImageView *phone=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60*WidthScale, 58*WidthScale)];
    phone.image=[UIImage imageNamed:@"phone_03"];
    phone.contentMode=UIViewContentModeScaleAspectFit;
    phoneNum.leftView=phone;
    phoneNum.leftViewMode=UITextFieldViewModeAlways;
    
    UIView *view1=[[UIView alloc]init];
    view1.backgroundColor=[UIColor whiteColor];
    [self.view1 addSubview:view1];
    view1.sd_layout.leftEqualToView(phoneNum).rightEqualToView(phoneNum).topSpaceToView(phoneNum,1).heightIs(1);
    
    UIButton *getCode=[[UIButton alloc]init];
    [getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    getCode.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.view1 addSubview:getCode];
    getCode.sd_layout.topSpaceToView(phoneNum,20*WidthScale).rightEqualToView(phoneNum).heightIs(45*WidthScale).widthIs(180*WidthScale);
    
    UITextField *codeNum=[[UITextField alloc]init];
    //    phoneNum.borderStyle=UITextBorderStyleNone;
    codeNum.keyboardType=UIKeyboardTypePhonePad;
    codeNum.clearButtonMode=UITextFieldViewModeAlways;
    codeNum.placeholder=@"请输入验证码";
    [self.view1 addSubview:codeNum];
    UIImageView *email=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60*WidthScale, 58*WidthScale)];
    email.image=[UIImage imageNamed:@"xinfeng"];
    email.contentMode=UIViewContentModeScaleAspectFit;
    codeNum.leftView=email;
    codeNum.leftViewMode=UITextFieldViewModeAlways;
    codeNum.sd_layout.leftEqualToView(phoneNum).rightEqualToView(phoneNum).heightIs(70*WidthScale).topSpaceToView(view1,80*WidthScale);
    UIView *view2=[[UIView alloc]init];
    view2.backgroundColor=[UIColor whiteColor];
    [self.view1 addSubview:view2];
    view2.sd_layout.leftEqualToView(codeNum).rightEqualToView(codeNum).topSpaceToView(codeNum,1).heightIs(1);
    
    UITextField *passWord=[[UITextField alloc]init];
    passWord.clearButtonMode=UITextFieldViewModeAlways;
    passWord.placeholder=@"请输入密码";
    passWord.secureTextEntry=YES;
    [self.view1 addSubview:passWord];
    UIImageView *lock=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60*WidthScale, 58*WidthScale)];
    lock.image=[UIImage imageNamed:@"lock_03"];
    lock.contentMode=UIViewContentModeScaleAspectFit;
    passWord.leftView=lock;
    passWord.leftViewMode=UITextFieldViewModeAlways;
    passWord.sd_layout.leftEqualToView(phoneNum).rightEqualToView(phoneNum).heightIs(70*WidthScale).topSpaceToView(codeNum,40*WidthScale);
    UIView *view3=[[UIView alloc]init];
    view3.backgroundColor=[UIColor whiteColor];
    [self.view1 addSubview:view3];
    view3.sd_layout.leftEqualToView(passWord).rightEqualToView(passWord).topSpaceToView(passWord,1).heightIs(1);
    
    UIButton *loginBtn=[[UIButton alloc]init];
    loginBtn.backgroundColor=Color(11, 231, 196);
    [loginBtn setTitle:@"确定" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:24];
    [self.view1 addSubview:loginBtn];
    loginBtn.sd_layout.leftEqualToView(codeNum).rightEqualToView(codeNum).topSpaceToView(view3,160*HeightScale).heightIs(80*WidthScale);

}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
