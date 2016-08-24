//
//  addAddressViewController.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/18.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "addAddressViewController.h"
#import <SDAutoLayout.h>
#import "OSAddressPickerView.h"
#import "YFAlert.h"
@interface addAddressViewController ()<UITextViewDelegate>
{
    NSDictionary *addressDic;
    UITextField *personName;
    UITextField *telephone;
    UIButton *choose;
    UILabel *chooseLabel;
    UIImageView *chooseImage;
    UITextView *address;
    OSAddressPickerView *_pickerview;
    UIButton *defaultBtn;
}
@end

@implementation addAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpForDismissKeyboard];
    self.view.backgroundColor=Color(238, 238, 238);
    addressDic=[NSDictionary dictionary];
 
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backItem;
    
    NSArray *array=@[@"收货人  :",@"联系电话  :",@"所在地区  :",@"详细地址  :"];
    for (int i=0; i<4; i++) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 118*WidthScale*i, ScreenWidth, 116*WidthScale)];
        if (i==3) {
            view.frame=CGRectMake(0, 118*WidthScale*i, ScreenWidth, 179*WidthScale);
        }
        view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(8, 40*WidthScale+118*WidthScale*i, 100, 20)];
        label.text=array[i];
        label.textColor=[UIColor blackColor];
        label.textAlignment=NSTextAlignmentLeft;
        [self.view addSubview:label];
        switch (i) {
            case 0:
                personName=[[UITextField alloc]init];
                personName.placeholder=@"请输入姓名";
                [view addSubview:personName];
                personName.sd_layout.leftSpaceToView(label,10).rightSpaceToView(view,0).topSpaceToView(view,0).bottomSpaceToView(view,0);
                break;
            case 1:
                telephone=[[UITextField alloc]init];
                telephone.placeholder=@"请输入联系电话";
                [view addSubview:telephone];
                telephone.sd_layout.leftSpaceToView(label,10).rightSpaceToView(view,0).topSpaceToView(view,0).bottomSpaceToView(view,0);
                break;
            case 2:
                chooseImage=[[UIImageView alloc]init];
                chooseImage.image=[UIImage imageNamed:@"choose_huise"];
                [view addSubview:chooseImage];
                chooseImage.sd_layout.rightSpaceToView(view,8).topSpaceToView(view,36*WidthScale).bottomSpaceToView(view,36*WidthScale).widthIs(24*WidthScale);
                chooseLabel=[[UILabel alloc]init];
                chooseLabel.text=@"请选择";
                chooseLabel.textColor=Color(199, 199, 205);
                chooseLabel.textAlignment=NSTextAlignmentRight;
                [view addSubview:chooseLabel];
                chooseLabel.sd_layout.rightSpaceToView(chooseImage,10).topSpaceToView(view,40*WidthScale).bottomSpaceToView(view,40*WidthScale).widthIs(60);
                
                choose=[[UIButton alloc]init];
                choose.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
                [choose setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                choose.titleLabel.font=[UIFont systemFontOfSize:17];
                [choose addTarget:self action:@selector(chooseBtn) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:choose];
                choose.sd_layout.leftSpaceToView(label,10).rightSpaceToView(view,0).topSpaceToView(view,0).bottomSpaceToView(view,0);
                break;
            case 3:
                address=[[UITextView alloc]init];
                address.text=@"街道、楼号等";
                address.font=[UIFont systemFontOfSize:17];
                address.textColor=Color(221, 221, 221);
//                address.backgroundColor=[UIColor yellowColor];
                address.delegate=self;
                [view addSubview:address];
                address.sd_layout.leftSpaceToView(label,10).rightSpaceToView(view,0).topSpaceToView(view,25*WidthScale).bottomSpaceToView(view,0);
                break;
                
            default:
                break;
        }
    }
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 553*WidthScale, ScreenWidth, 118*WidthScale)];
    view2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view2];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(8, 40*WidthScale, 140, 20)];
    label2.text=@"设为默认地址:";
    label2.textColor=[UIColor blackColor];
    [view2 addSubview:label2];
    defaultBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [defaultBtn setImage:[UIImage imageNamed:@"dadui_hui_03"] forState:UIControlStateNormal];
    [defaultBtn setImage:[UIImage imageNamed:@"dadui_lv_03"] forState:UIControlStateSelected];
    [defaultBtn addTarget:self action:@selector(changeDefault:) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:defaultBtn];
    defaultBtn.sd_layout.rightSpaceToView(view2,8).topEqualToView(label2).widthIs(20).heightIs(20);
    
    UIButton *queren=[UIButton buttonWithType:UIButtonTypeCustom];
    queren.backgroundColor=Color(0, 239, 200);
    [queren setTitle:@"保存" forState:UIControlStateNormal];
    [queren addTarget:self action:@selector(querenBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queren];
    queren.sd_layout.leftSpaceToView(self.view,8).rightSpaceToView(self.view,8).topSpaceToView(view2,20*WidthScale).heightIs(98*WidthScale);
    
    if (self.changeDic!=nil) {
        NSLog(@"/////");
        [self changeView];
    }
}
-(void)changeView{
    personName.text=self.changeDic[@"name"];
    telephone.text=self.changeDic[@"telePhone"];
    [choose setTitle:self.changeDic[@"releaseAddress"] forState:UIControlStateNormal];
    address.text=self.changeDic[@"detailAddress"];
    address.textColor=[UIColor blackColor];
    if ([self.changeDic[@"default"] isEqualToString:@"1"]) {
        defaultBtn.selected=YES;
    }
}
-(void)changeDefault:(UIButton *)sender{
    sender.selected=!sender.selected;
}
-(void)chooseBtn{
    _pickerview = [OSAddressPickerView shareInstance];
    [_pickerview showBottomView];
    [self.view addSubview:_pickerview];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    __weak UIButton *temp = choose;
    __weak UIImageView *imageview=chooseImage;
    __weak UILabel *label=chooseLabel;
    _pickerview.block = ^(NSString *province,NSString *city,NSString *district)
    {
        if (imageview) {
            [imageview removeFromSuperview];
        }
        if (label) {
            [label removeFromSuperview];
        }
        [temp setTitle:[NSString stringWithFormat:@"%@%@%@",province,city,district] forState:UIControlStateNormal];
//        [defaults setObject:[NSString stringWithFormat:@"%@ %@ %@",province,city,district] forKey:@"address"];
    };

}
-(void)querenBtn:(UIButton *)sender{
    BOOL isPhone=[self isMobileNumber:telephone.text];
    if (personName.text.length!=0) {
        if (isPhone==YES) {
            if (choose.currentTitle.length!=0) {
                if (address.text.length!=0) {
                    YFAlert *yfAlert = [[YFAlert alloc] initWithTitle:@"提示" message:@"要提交了哦，检查清楚哦O(∩_∩)O~"];
                    
                    [yfAlert addBtnAlertTitle:@"取消" action:^{
                        
                    }];
                    [yfAlert addBtnAlertTitle:@"确认" action:^{
                        if (defaultBtn.selected==YES) {
                            addressDic=@{@"name":personName.text,@"telePhone":telephone.text,@"releaseAddress":choose.currentTitle,@"detailAddress":address.text,@"default":@"1"};
                        }else{
                            addressDic=@{@"name":personName.text,@"telePhone":telephone.text,@"releaseAddress":choose.currentTitle,@"detailAddress":address.text,@"default":@"1"};
                        }
                        NSLog(@"%@",addressDic);
                        [self.navigationController popViewControllerAnimated:YES];

                    }];
                    
                    
                    [yfAlert showAlertWithSender:self];
                    
                }else{
                    [YFAlert showAlertViewCertainWithTitle:@"请填写详细地址" WithUIViewController:self];
                }
            }else{
                [YFAlert showAlertViewCertainWithTitle:@"请选择您所在的地区" WithUIViewController:self];
            }
        }else{
            [YFAlert showAlertViewCertainWithTitle:@"请输入正确的手机号" WithUIViewController:self];
        }
    }else{
        [YFAlert showAlertViewCertainWithTitle:@"您还没有填写姓名" WithUIViewController:self];
    }
    
}
//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"街道、楼号等"]) {
        textView.text=nil;
    }
    textView.textColor=[UIColor blackColor];
    return YES;
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
- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
