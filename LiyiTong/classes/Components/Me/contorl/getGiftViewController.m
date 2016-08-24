//
//  getGiftViewController.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/18.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "getGiftViewController.h"
#import "GGImagePageView.h"
#import <SDAutoLayout.h>
#import "allAddressViewController.h"
#import "GetSuccessViewController.h"
@interface getGiftViewController ()<GGImagePageViewDelegate>
{
    UIScrollView *backScroll;
    UIView *navview;
    UIView *viwepager;
    UIView *statusBack;
    UIView *viewBack3;
    UIView *addAddress;
    UIView *chooseAddress;
}
@end

@implementation getGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    backScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight+20)];
    //    backScroll.contentSize=CGSizeMake(0, 338*WidthScale+10+80*WidthScale+[_newCityDic allKeys].count*20+_oldCityList.count*53+64);
    backScroll.backgroundColor=Color(232, 232, 232);
    backScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:backScroll];
    
    [self navView];
    [self view1];
    [self view2];
    [self view3];
//    [self addAddressView];
    [self chooseAddressView];
}
//自定义导航栏
-(void)navView{
    navview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    navview.backgroundColor=[UIColor clearColor];
//    navview.alpha=0.3;
    [self.view addSubview:navview];
    //自定义返回按钮
    UIButton *backButton = [[UIButton alloc]init];
    backButton.frame=CGRectMake(10, 25, 25, 25);
    //设置UIButton的图像
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [navview addSubview:backButton];
    
    UILabel *title=[[UILabel alloc]init];
    title.text=@"提取礼物";
    title.font=[UIFont systemFontOfSize:21];
    title.textAlignment=NSTextAlignmentCenter;
    title.textColor=[UIColor whiteColor];
    [navview addSubview:title];
    title.sd_layout.leftSpaceToView(navview,276*WidthScale).rightSpaceToView(navview,276*WidthScale).bottomEqualToView(backButton).heightIs(20);

}
-(void)view1{
    viwepager=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 750*WidthScale)];
    viwepager.backgroundColor=[UIColor lightGrayColor];
    [backScroll addSubview:viwepager];
    GGImagePageView *imagePageView = [[GGImagePageView alloc]initWithFrame:viwepager.frame];
    imagePageView.lazyDelegate=self;
    imagePageView.isTimer = YES;
    
    imagePageView.showPageControl = YES;
    
    imagePageView.imageAarray = @[@"LI_01",@"LI_01",@"LI_01",@"手链"];
    
    [viwepager addSubview:imagePageView];
}
-(void)view2{
    statusBack=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(viwepager.frame), ScreenWidth, 186*WidthScale)];
    statusBack.backgroundColor=[UIColor whiteColor];
    [backScroll addSubview:statusBack];
    
    UILabel *title=[[UILabel alloc]init];
//    title.backgroundColor=[UIColor redColor];
    title.text=@"多彩女人运四叶草钻石切边手链";
    title.textColor=[UIColor blackColor];
    title.textAlignment=NSTextAlignmentLeft;
    [statusBack addSubview:title];
    title.sd_layout.leftSpaceToView(statusBack,8).topSpaceToView(statusBack,5).rightSpaceToView(statusBack,8).heightIs(20);
    
    UILabel *guige=[[UILabel alloc]init];
    guige.text=@"规格参数";
    guige.textColor=Color(204, 204, 204);
    guige.textAlignment=NSTextAlignmentLeft;
    [statusBack addSubview:guige];
    guige.sd_layout.leftEqualToView(title).topSpaceToView(title,18*WidthScale).widthIs(90).heightIs(20);
    
    UILabel *giftNum=[[UILabel alloc]init];
    giftNum.text=@"5份";
    giftNum.textColor=Color(204, 204, 204);
    giftNum.textAlignment=NSTextAlignmentRight;
    [statusBack addSubview:giftNum];
    giftNum.sd_layout.rightSpaceToView(statusBack,200*WidthScale).topEqualToView(guige).bottomEqualToView(guige).widthIs(40);
    
    UILabel *value=[[UILabel alloc]init];
    value.text=@"礼品价值:";
    value.textColor=[UIColor blackColor];
    value.textAlignment=NSTextAlignmentLeft;
    [statusBack addSubview:value];
    value.sd_layout.leftEqualToView(guige).topSpaceToView(guige,18*WidthScale).widthIs(90).heightIs(20);
    
    NSString *priceNum=@"13960.00";
    UILabel *price=[[UILabel alloc]init];
//    price.text=@"¥13960.00";
//    price.font=[UIFont systemFontOfSize:25];
    price.textColor=Color(0, 239, 200);
    price.textAlignment=NSTextAlignmentRight;
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",priceNum]];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0,1)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(1,priceNum.length)];
    price.attributedText=str1;
    [statusBack addSubview:price];
    price.sd_layout.rightEqualToView(giftNum).bottomEqualToView(value).widthIs(130).heightIs(25);
}
- (void)didSelectViewWithIndex:(NSInteger)index{
    NSLog(@"选中了第%ld个图片",index);
}
-(void)view3{
    viewBack3=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(statusBack.frame), ScreenWidth, 130*WidthScale)];
    viewBack3.backgroundColor=[UIColor clearColor];
    [backScroll addSubview:viewBack3];
    
    UIView *view1=[[UIView alloc]init];
    view1.backgroundColor=Color(238, 238, 238);
    [viewBack3 addSubview:view1];
    view1.sd_layout.leftSpaceToView(viewBack3,0).topSpaceToView(viewBack3,1).rightSpaceToView(viewBack3,0).heightIs(50*WidthScale);
    UILabel *text1=[[UILabel alloc]init];
    text1.text=@"该商品由商家发货并提供售后服务";
    text1.font=[UIFont systemFontOfSize:12];
    text1.textColor=Color(119, 119, 119);
    text1.textAlignment=NSTextAlignmentLeft;
    [view1 addSubview:text1];
    text1.sd_layout.leftSpaceToView(view1,8).topSpaceToView(view1,14*WidthScale).widthIs(300).heightIs(13);
    
    UIView *view2=[[UIView alloc]init];
    view2.backgroundColor=[UIColor whiteColor];
    [viewBack3 addSubview:view2];
    view2.sd_layout.leftSpaceToView(viewBack3,0).topSpaceToView(view1,1).rightSpaceToView(viewBack3,0).bottomSpaceToView(viewBack3,1);
    UILabel *text2=[[UILabel alloc]init];
    text2.text=@"礼物寄送到";
//    text2.font=[UIFont systemFontOfSize:20];
    text2.textColor=[UIColor blackColor];
    text2.textAlignment=NSTextAlignmentLeft;
    [view2 addSubview:text2];
    text2.sd_layout.leftSpaceToView(view2,8).topSpaceToView(view2,18*WidthScale).widthIs(100).heightIs(20);
}
-(void)addAddressView{
    addAddress=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(viewBack3.frame), ScreenWidth, backScroll.height-CGRectGetMaxY(viewBack3.frame)-20)];
    addAddress.backgroundColor=[UIColor whiteColor];
    [backScroll addSubview:addAddress];
    
    UIView *view=[[UIView alloc]init];
    view.userInteractionEnabled=YES;
//    view.backgroundColor=[UIColor yellowColor];
    [addAddress addSubview:view];
    view.sd_layout.leftSpaceToView(addAddress,0).topSpaceToView(addAddress,0).rightSpaceToView(addAddress,0).heightIs(78*WidthScale);
    UIImageView *pinImage=[[UIImageView alloc]init];
    pinImage.image=[UIImage imageNamed:@"dingwei_da"];
    pinImage.contentMode=UIViewContentModeScaleAspectFit;
    [view addSubview:pinImage];
    pinImage.sd_layout.leftSpaceToView(view,24*WidthScale).topSpaceToView(view,19*WidthScale).widthIs(34*WidthScale).heightIs(44*WidthScale);
    UILabel *label=[[UILabel alloc]init];
    label.text=@"请填写收货地址";
    label.textColor=[UIColor blackColor];
    label.textAlignment=NSTextAlignmentLeft;
    [view addSubview:label];
    label.sd_layout.leftSpaceToView(pinImage,5).topSpaceToView(view,20*WidthScale).widthIs(120).heightIs(20);
    UIImageView *chooseImage=[[UIImageView alloc]init];
    chooseImage.image=[UIImage imageNamed:@"choose"];
    [view addSubview:chooseImage];
    chooseImage.sd_layout.rightSpaceToView(view,8).topSpaceToView(view,0).widthIs(76*WidthScale).heightIs(76*WidthScale);
    UIButton *button=[[UIButton alloc]init];
//    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(addAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    button.sd_layout.leftSpaceToView(view,0).topSpaceToView(view,0).rightSpaceToView(view,0).bottomSpaceToView(view,0);
    UIView *line=[[UIView alloc]init];
    line.backgroundColor=Color(232, 232, 232);
    [addAddress addSubview:line];
    line.sd_layout.leftSpaceToView(addAddress,0).rightSpaceToView(addAddress,0).topSpaceToView(view,0).heightIs(1);
    
    UIButton *confirmBtn=[[UIButton alloc]init];
    confirmBtn.backgroundColor=Color(221, 221, 221);
    [confirmBtn setTitle:@"确认提取" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addAddress addSubview:confirmBtn];
    confirmBtn.sd_layout.leftSpaceToView(addAddress,0).rightSpaceToView(addAddress,0).bottomSpaceToView(addAddress,0).heightIs(98*WidthScale);
}
-(void)chooseAddressView{
    chooseAddress=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(viewBack3.frame), ScreenWidth, backScroll.height-CGRectGetMaxY(viewBack3.frame)-20)];
    chooseAddress.backgroundColor=[UIColor whiteColor];
    [backScroll addSubview:chooseAddress];
    
    UIView *view=[[UIView alloc]init];
    view.userInteractionEnabled=YES;
//        view.backgroundColor=[UIColor yellowColor];
    [chooseAddress addSubview:view];
    view.sd_layout.leftSpaceToView(chooseAddress,0).topSpaceToView(chooseAddress,0).rightSpaceToView(chooseAddress,0).heightIs(169*WidthScale);
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(78*WidthScale, 30*WidthScale, 60, 20)];
    name.text=@"黄先生";
    [name sizeToFit];
    name.textColor=[UIColor blackColor];
    name.textAlignment=NSTextAlignmentLeft;
    [view addSubview:name];
//    name.sd_layout.leftSpaceToView(view,78*WidthScale).topSpaceToView(view,30*WidthScale).widthIs(60).heightIs(20);
    UILabel *telephone=[[UILabel alloc]init];
    telephone.text=@"13654895578";
    telephone.textColor=[UIColor blackColor];
    telephone.textAlignment=NSTextAlignmentLeft;
    [view addSubview:telephone];
    telephone.sd_layout.leftSpaceToView(name,5).topSpaceToView(view,30*WidthScale).widthIs(120).heightIs(20);
    
    UIImageView *pinImage=[[UIImageView alloc]init];
    pinImage.image=[UIImage imageNamed:@"dingwei_xiao"];
    pinImage.contentMode=UIViewContentModeScaleAspectFit;
    [view addSubview:pinImage];
    pinImage.sd_layout.leftSpaceToView(view,26*WidthScale).topSpaceToView(view,90*WidthScale).widthIs(28*WidthScale).heightIs(38*WidthScale);
    UILabel *address=[[UILabel alloc]init];
    address.text=@"上海市黄浦区复兴中路125号";
    address.textColor=[UIColor blackColor];
    address.textAlignment=NSTextAlignmentLeft;
    [view addSubview:address];
    address.sd_layout.leftSpaceToView(pinImage,6).topEqualToView(pinImage).widthIs(300).heightIs(20);
    
    UIImageView *chooseImage=[[UIImageView alloc]init];
    chooseImage.image=[UIImage imageNamed:@"choose"];
    [view addSubview:chooseImage];
    chooseImage.sd_layout.rightSpaceToView(view,8).topSpaceToView(view,50*WidthScale).widthIs(76*WidthScale).heightIs(76*WidthScale);
    UIButton *button=[[UIButton alloc]init];
    //    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(chooseAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    button.sd_layout.leftSpaceToView(view,0).topSpaceToView(view,0).rightSpaceToView(view,0).bottomSpaceToView(view,0);
    
    UIView *line=[[UIView alloc]init];
    line.backgroundColor=Color(232, 232, 232);
    [chooseAddress addSubview:line];
    line.sd_layout.leftSpaceToView(chooseAddress,0).rightSpaceToView(chooseAddress,0).topSpaceToView(view,0).heightIs(1);
    UIButton *confirmBtn=[[UIButton alloc]init];
    confirmBtn.backgroundColor=Color(0, 239, 200);
    [confirmBtn setTitle:@"确认提取" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmGet:) forControlEvents:UIControlEventTouchUpInside];
    [chooseAddress addSubview:confirmBtn];
    confirmBtn.sd_layout.leftSpaceToView(chooseAddress,0).rightSpaceToView(chooseAddress,0).bottomSpaceToView(chooseAddress,0).topSpaceToView(line,0);
}
-(void)confirmGet:(UIButton *)sender{
    GetSuccessViewController *getSuccess=[[GetSuccessViewController alloc]init];
    [self.navigationController pushViewController:getSuccess animated:YES];
}
-(void)addAddressBtn:(UIButton *)sender{
    allAddressViewController *add=[[allAddressViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}
-(void)chooseAddressBtn:(UIButton *)sender{
    NSLog(@"-----------");
    allAddressViewController *add=[[allAddressViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}
//返回
-(void)backItemClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
