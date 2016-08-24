//
//  deleteOrderViewController.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/16.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "orderStatusViewController.h"
#import <SDAutoLayout.h>
#import "YFAlert.h"
#import "orderStatusTableViewCell.h"

@interface orderStatusViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *backview1;
    UIView *backview2;
    UIView *backview3;
    UIView *backview4;
    UIView *backview5;
    NSDictionary *dataDic;
    NSDictionary *orderDic;
    NSDictionary *presentDic;
    UITableView *waitTabview;
    UITableView *waitGetTabview;
    UITableView *refundTabview;
}
@end

@implementation orderStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=Color(238, 238, 238);
    self.navigationItem.title=@"送出的礼物";
    
    presentDic=@{
                @"alreadyGet":@{@"getNumber":@"2",
                                  @"allGetNumber":@"5"},
                
                @"getPeople":@[@{@"heard":@"kawayi",
                              @"name":@"雨过天晴",
                              @"time":@"2016-07-21  12:56:23"},
                            @{@"heard":@"moximoxi",
                              @"name":@"雨过天晴",
                              @"time":@"2016-07-21  12:56:23"}],
                
                @"alreadyPresent":@{@"presentNumber":@"0",
                                  @"allPresentNumber":@"5"},

                @"presentPerson":@[@{@"heard":@"kawayi",
                                     @"name":@"雨过天晴",
                                     @"time":@"2016-07-21  12:56:23"},
                                   @{@"heard":@"moximoxi",
                                     @"name":@"雨过天晴",
                                     @"time":@"2016-07-21  12:56:23"}]};
    
    orderDic=@{@"prompt":@"您的订单已关闭",@"status":@"已取消",@"greetings":@"想念的话说也说不完，关怀的心，永远都不变。送你一份小礼物，希望你喜欢!",@"orderImage":@"shoulian_order",@"title1":@"多彩女人  幸运四叶草钻石切边手链",@"price":@"139.00",@"number":@"5",@"priceAll":@"13960.00",@"Ediscount":@"11.00",@"priceEnd":@"13960.00"};
    dataDic=[NSDictionary dictionary];
    dataDic=[orderDic copy];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [addButton setTitle:@"联系客服" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [addButton addTarget:self action:@selector(addItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = addItem;
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self view1];
    [self view2];
    [self view3];
    [self view4];
    [self view5];
    if ([self.title isEqualToString:@"删除订单"]) {
        NSLog(@"%@",self.title);
        [self deleteOrder];
    }else
    if ([self.title isEqualToString:@"等待支付"]) {
        NSLog(@"%@",self.title);
        [self getPay];
    }else
    if ([self.title isEqualToString:@"等待赠送"]) {
            NSLog(@"%@",self.title);
        [self presentView];
    }else
    if ([self.title isEqualToString:@"等待领取"]) {
            NSLog(@"%@",self.title);
        [self waitgetView];
    }else
    if ([self.title isEqualToString:@"已领完"]) {
            NSLog(@"%@",self.title);
        [self waitgetView];
    }else
    if ([self.title isEqualToString:@"已取消"]) {
             NSLog(@"%@",self.title);
        [self canceled];
    }else
    if ([self.title isEqualToString:@"已退款"]) {
            NSLog(@"%@",self.title);
        [self refundView];
    }else{
           NSLog(@">>>错误的请求--->>>%@",self.title);
    }
}
-(void)view1{
    backview1=[[UIView alloc]initWithFrame:CGRectMake(0, 6, ScreenWidth, 66*WidthScale)];
    backview1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backview1];
    
    UIImageView *warning=[[UIImageView alloc]init];
    warning.image=[UIImage imageNamed:@"duiTa_03"];
    [backview1 addSubview:warning];
    warning.sd_layout.leftSpaceToView(backview1,8).topSpaceToView(backview1,14*WidthScale).widthIs(36*WidthScale).heightIs(36*WidthScale);
    
    UILabel *label=[[UILabel alloc]init];
    label.text=dataDic[@"prompt"];
    label.adjustsFontSizeToFitWidth=YES;
    label.textColor=Color(255, 122, 61);
    label.textAlignment=NSTextAlignmentLeft;
    [backview1 addSubview:label];
    label.sd_layout.leftSpaceToView(warning,5).bottomEqualToView(warning).topEqualToView(warning).widthIs(100);
}
-(void)view2{
    backview2=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backview1.frame)+6, ScreenWidth, 80*WidthScale)];
    backview2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backview2];
    
    UILabel *label=[[UILabel alloc]init];
    label.text=[NSString stringWithFormat:@"订单号 : %@",self.orderNum];
//    label.backgroundColor=[UIColor cyanColor];
    label.textColor=[UIColor blackColor];
    label.textAlignment=NSTextAlignmentLeft;
    [backview2 addSubview:label];
    label.sd_layout.leftSpaceToView(backview2,8).topSpaceToView(backview2,24*WidthScale).bottomSpaceToView(backview2,16*WidthScale).widthIs(150);
    
    UILabel *status=[[UILabel alloc]init];
    status.text=self.title;
    status.textColor=Color(0, 239, 200);
    status.textAlignment=NSTextAlignmentRight;
    [backview2 addSubview:status];
    status.sd_layout.rightSpaceToView(backview2,8).topEqualToView(label).bottomEqualToView(label).widthIs(100);
}
-(void)view3{
    backview3=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backview2.frame)+1, ScreenWidth, 100*WidthScale)];
    backview3.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backview3];
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"祝福语:";
//    label.backgroundColor=[UIColor cyanColor];
    label.textColor=[UIColor blackColor];
    label.textAlignment=NSTextAlignmentLeft;
    [backview3 addSubview:label];
    label.sd_layout.leftSpaceToView(backview3,8).topSpaceToView(backview3,16*WidthScale).widthIs(60).heightIs(15);
    
    UILabel *greetings=[[UILabel alloc]init];
    greetings.text=dataDic[@"greetings"];
    greetings.font=[UIFont systemFontOfSize:13];
    greetings.textColor=Color(153, 153, 153);
    greetings.textAlignment=NSTextAlignmentLeft;
    [backview3 addSubview:greetings];
    greetings.sd_layout.leftSpaceToView(label,6).topEqualToView(label).rightSpaceToView(backview3,8).autoHeightRatio(0);
}
-(void)view4{
    backview4=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backview3.frame)+7, ScreenWidth, 229*WidthScale)];
    backview4.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backview4];
    UIImageView *orderImage=[[UIImageView alloc]init];
    orderImage.image=[UIImage imageNamed:dataDic[@"orderImage"]];
    [backview4 addSubview:orderImage];
    orderImage.sd_layout.leftSpaceToView(backview4,8).topSpaceToView(backview4,15*WidthScale).widthIs(200*WidthScale).heightIs(200*WidthScale);
    
    UILabel *title1=[[UILabel alloc]init];
    title1.textColor=Color(68, 68, 68);
    title1.text=dataDic[@"title1"];
    [backview4 addSubview:title1];
    title1.sd_layout.leftSpaceToView(orderImage,46*WidthScale).topEqualToView(orderImage).rightSpaceToView(backview4,8).autoHeightRatio(0);
    
    UILabel *title2=[[UILabel alloc]init];
    title2.text=@"规格参数";
    title2.textColor=Color(204, 204, 204);
    title2.textAlignment=NSTextAlignmentLeft;
    [backview4 addSubview:title2];
    title2.sd_layout.bottomSpaceToView(backview4,70*WidthScale).leftEqualToView(title1).widthIs(80).heightIs(20);
    
    UILabel *priceWithNum=[[UILabel alloc]init];
    priceWithNum.textAlignment=NSTextAlignmentRight;
    NSString *price=dataDic[@"price"];
    NSString *number=dataDic[@"number"];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@X%@",price,number]];
    //%d
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(51, 51, 51) range:NSMakeRange(0,price.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0,price.length)];
    //天后生日
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(204, 204, 204) range:NSMakeRange(price.length,1+number.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(price.length,1+number.length)];
    priceWithNum.attributedText=str1;
    [backview4 addSubview:priceWithNum];
    priceWithNum.sd_layout.rightEqualToView(title1).bottomEqualToView(title2).widthIs(120).heightIs(20);
    
    UILabel *priceEnd=[[UILabel alloc]init];
    priceEnd.textAlignment=NSTextAlignmentRight;
    NSString *priceAll=dataDic[@"priceAll"];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付款:¥%@",priceAll]];
    //%d
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(51, 51, 51) range:NSMakeRange(0,5)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0,5)];
    //天后生日
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(51, 51, 51) range:NSMakeRange(5,priceAll.length)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(5,priceAll.length)];
    priceEnd.attributedText=str2;
    [backview4 addSubview:priceEnd];
    priceEnd.sd_layout.rightEqualToView(priceWithNum).bottomSpaceToView(backview4,5).widthIs(200).heightIs(20);
}
-(void)view5{
    backview5=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backview4.frame)+1, ScreenWidth, 130*WidthScale)];
    backview5.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backview5];
    
    UILabel *Ediscount=[[UILabel alloc]init];
    Ediscount.textAlignment=NSTextAlignmentRight;
    Ediscount.font=[UIFont systemFontOfSize:18];
    NSString *EdiscountStr=dataDic[@"Ediscount"];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"E点折扣:-¥%@",EdiscountStr]];
    //%d
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(199, 199, 199) range:NSMakeRange(0,5)];
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(0, 239, 200) range:NSMakeRange(5,EdiscountStr.length+2)];
    Ediscount.attributedText=str2;
    [backview5 addSubview:Ediscount];
    Ediscount.sd_layout.topSpaceToView(backview5,5).rightSpaceToView(backview5,8).widthIs(160).heightIs(20);
    
    UILabel *priceEnd=[[UILabel alloc]init];
    priceEnd.textAlignment=NSTextAlignmentRight;
    NSString *priceEndStr=dataDic[@"priceEnd"];
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付款:¥%@",priceEndStr]];
    //%d
    [str3 addAttribute:NSForegroundColorAttributeName value:Color(51, 51, 51) range:NSMakeRange(0,5)];
    [str3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0,5)];
    //天后生日
    [str3 addAttribute:NSForegroundColorAttributeName value:Color(51, 51, 51) range:NSMakeRange(5,priceEndStr.length)];
    [str3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(5,priceEndStr.length)];
    priceEnd.attributedText=str3;
    [backview5 addSubview:priceEnd];
    priceEnd.sd_layout.rightEqualToView(Ediscount).topSpaceToView(Ediscount,5).widthIs(200).heightIs(20);
   
}
#pragma mark---删除订单---
-(void)deleteOrder{
    UIView *deleteBack=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backview5.frame), ScreenWidth, ScreenHeight-CGRectGetMaxY(backview5.frame)-64)];
    deleteBack.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:deleteBack];
    
    UIButton *delegateBtn=[[UIButton alloc]init];
    delegateBtn.layer.borderWidth=1;
    delegateBtn.layer.borderColor=Color(223, 223, 223).CGColor;
    [delegateBtn setTitle:@"删除订单" forState:UIControlStateNormal];
    [delegateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delegateBtn addTarget:self action:@selector(delegateOrder:) forControlEvents:UIControlEventTouchUpInside];
    [deleteBack addSubview:delegateBtn];
    delegateBtn.sd_layout.leftSpaceToView(deleteBack,39*WidthScale).rightSpaceToView(deleteBack,39*WidthScale).bottomSpaceToView(deleteBack,39*WidthScale).heightIs(50);
}
#pragma mark---等待支付---
-(void)getPay{
    UIView *payBack=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backview5.frame), ScreenWidth, ScreenHeight-CGRectGetMaxY(backview5.frame)-64)];
    payBack.backgroundColor=Color(238, 238, 238);
    [self.view addSubview:payBack];
    
    UIButton *delegateBtn=[[UIButton alloc]init];
    delegateBtn.layer.borderWidth=1;
    delegateBtn.layer.borderColor=Color(223, 223, 223).CGColor;
    [delegateBtn setBackgroundColor:[UIColor whiteColor]];
    [delegateBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [delegateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delegateBtn addTarget:self action:@selector(cancelOrder:) forControlEvents:UIControlEventTouchUpInside];
    [payBack addSubview:delegateBtn];
    delegateBtn.sd_layout.leftSpaceToView(payBack,39*WidthScale).widthIs(338*WidthScale).bottomSpaceToView(payBack,39*WidthScale).heightIs(50);
    UIButton *payBtn=[[UIButton alloc]init];
    payBtn.layer.borderWidth=1;
    payBtn.layer.borderColor=Color(223, 223, 223).CGColor;
    [payBtn setBackgroundColor:Color(0, 239, 200)];
    [payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payOrder:) forControlEvents:UIControlEventTouchUpInside];
    [payBack addSubview:payBtn];
    payBtn.sd_layout.rightSpaceToView(payBack,39*WidthScale).leftSpaceToView(delegateBtn,0).bottomSpaceToView(payBack,39*WidthScale).heightIs(50);
    
}
#pragma mark---等待赠送---
-(void)presentView{
    UIView *presentBack=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backview5.frame), ScreenWidth, ScreenHeight-CGRectGetMaxY(backview5.frame)-64)];
    presentBack.backgroundColor=Color(238, 238, 238);
    [self.view addSubview:presentBack];
    
    NSString *getNum=presentDic[@"alreadyPresent"][@"presentNumber"];
    NSString *allNum=presentDic[@"alreadyPresent"][@"allPresentNumber"];
    
    waitTabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, presentBack.size.height) style:UITableViewStylePlain];
    waitTabview.backgroundColor=Color(238, 238, 238);
    waitTabview.scrollEnabled=NO;
    waitTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    waitTabview.tableHeaderView=[self getheaderWithNum1:getNum Num2:allNum];
    [presentBack addSubview:waitTabview];
    waitTabview.delegate=self;
    waitTabview.dataSource=self;
    
    UIButton *selfBtn=[[UIButton alloc]init];
    selfBtn.layer.borderWidth=1;
    selfBtn.layer.borderColor=Color(223, 223, 223).CGColor;
    [selfBtn setBackgroundColor:[UIColor whiteColor]];
    [selfBtn setTitle:@"自己领" forState:UIControlStateNormal];
    [selfBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [selfBtn addTarget:self action:@selector(cancelOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selfBtn];
    selfBtn.sd_layout.leftSpaceToView(self.view,39*WidthScale).widthIs(338*WidthScale).bottomSpaceToView(self.view,39*WidthScale).heightIs(50);
    UIButton *presentBtn=[[UIButton alloc]init];
    presentBtn.layer.borderWidth=1;
    presentBtn.layer.borderColor=Color(223, 223, 223).CGColor;
    [presentBtn setBackgroundColor:Color(0, 239, 200)];
    [presentBtn setTitle:@"赠送" forState:UIControlStateNormal];
    [presentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [presentBtn addTarget:self action:@selector(payOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentBtn];
    presentBtn.sd_layout.rightSpaceToView(self.view,39*WidthScale).leftSpaceToView(selfBtn,0).bottomSpaceToView(self.view,39*WidthScale).heightIs(50);
}
#pragma mark---等待领取---
-(void)waitgetView{
    UIView *presentBack=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backview5.frame), ScreenWidth, ScreenHeight-CGRectGetMaxY(backview5.frame)-64)];
    presentBack.backgroundColor=Color(238, 238, 238);
    [self.view addSubview:presentBack];
    
    NSString *getNum=presentDic[@"alreadyGet"][@"getNumber"];
    NSString *allNum=presentDic[@"alreadyGet"][@"allGetNumber"];
    
    waitGetTabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, presentBack.size.height) style:UITableViewStylePlain];
    waitGetTabview.backgroundColor=[UIColor whiteColor];
    waitGetTabview.scrollEnabled=NO;
    waitGetTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    waitGetTabview.tableHeaderView=[self getheaderWithNum1:getNum Num2:allNum];
    [presentBack addSubview:waitGetTabview];
    waitGetTabview.delegate=self;
    waitGetTabview.dataSource=self;
}
#pragma mark---已退款---
-(void)refundView{
    UIView *presentBack=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backview5.frame), ScreenWidth, ScreenHeight-CGRectGetMaxY(backview5.frame)-64)];
    presentBack.backgroundColor=Color(238, 238, 238);
    [self.view addSubview:presentBack];
    
    NSString *getNum=presentDic[@"alreadyGet"][@"getNumber"];
    NSString *allNum=presentDic[@"alreadyGet"][@"allGetNumber"];
    
    refundTabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, presentBack.size.height) style:UITableViewStylePlain];
    refundTabview.backgroundColor=[UIColor whiteColor];
    refundTabview.scrollEnabled=NO;
    refundTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    refundTabview.tableHeaderView=[self getheaderWithNum1:getNum Num2:allNum];
    [presentBack addSubview:refundTabview];
    refundTabview.delegate=self;
    refundTabview.dataSource=self;
    
    UIButton *refundBtn=[[UIButton alloc]init];
    refundBtn.layer.borderWidth=1;
    refundBtn.layer.borderColor=Color(223, 223, 223).CGColor;
    [refundBtn setBackgroundColor:[UIColor whiteColor]];
    [refundBtn setTitle:@"查看退款详情" forState:UIControlStateNormal];
    [refundBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [refundBtn addTarget:self action:@selector(orderRefund:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refundBtn];
    refundBtn.sd_layout.leftSpaceToView(self.view,39*WidthScale).rightSpaceToView(self.view,39*WidthScale).bottomSpaceToView(self.view,39*WidthScale).heightIs(50);
}
-(UIView *)getheaderWithNum1:(NSString *)Num1 Num2:(NSString *)Num2{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 72*WidthScale)];
    headerView.backgroundColor=Color(238, 238, 238);
    UIView *leftLine=[[UIView alloc]init];
    leftLine.backgroundColor=Color(0, 239, 200);
    [headerView addSubview:leftLine];
    leftLine.sd_layout.leftSpaceToView(headerView,0).topSpaceToView(headerView,42*WidthScale).widthIs(217*WidthScale).heightIs(1);
    UIView *rightLine=[[UIView alloc]init];
    rightLine.backgroundColor=Color(0, 239, 200);
    [headerView addSubview:rightLine];
    rightLine.sd_layout.rightSpaceToView(headerView,0).topSpaceToView(headerView,42*WidthScale).widthIs(217*WidthScale).heightIs(1);
    
    UILabel *label=[[UILabel alloc]init];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已赠送%@份礼物，共%@份",Num1,Num2]];
    //%d
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(204, 204, 204) range:NSMakeRange(0,3)];
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(0, 239, 200) range:NSMakeRange(3,Num1.length)];
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(204, 204, 204) range:NSMakeRange(3+Num1.length,5)];
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(0, 239, 200) range:NSMakeRange(3+Num1.length+5,Num2.length)];
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(204, 204, 204) range:NSMakeRange(3+Num1.length+5+Num2.length,1)];
    label.attributedText=str2;
    label.textAlignment=NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth=YES;
    [headerView addSubview:label];
    label.sd_layout.leftSpaceToView(leftLine,10).rightSpaceToView(rightLine,10).topSpaceToView(headerView,24*WidthScale).heightIs(15);
    return headerView;
}
#pragma mark---已取消---
-(void)canceled{
    UIButton *delegateBtn=[[UIButton alloc]init];
    delegateBtn.layer.borderWidth=1;
    delegateBtn.layer.borderColor=Color(223, 223, 223).CGColor;
    [delegateBtn setBackgroundColor:[UIColor whiteColor]];
    [delegateBtn setTitle:@"删除订单" forState:UIControlStateNormal];
    [delegateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delegateBtn addTarget:self action:@selector(delegateOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delegateBtn];
    delegateBtn.sd_layout.leftSpaceToView(self.view,39*WidthScale).rightSpaceToView(self.view,39*WidthScale).bottomSpaceToView(self.view,39*WidthScale).heightIs(50);
}
#pragma mark---UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *personAry=[NSArray array];
    //逻辑应包含等待赠送、等待领取、已领完、已退款，四种情况，根据实际后台数据变动
    if ([self.title isEqualToString:@"等待赠送"]) {
        personAry=presentDic[@"presentPerson"];
    }else
    if ([self.title isEqualToString:@"等待领取"]) {
        personAry=presentDic[@"getPeople"];
    }else
    if ([self.title isEqualToString:@"已领完"]) {
        personAry=presentDic[@"getPeople"];
    }else
    {
        personAry=presentDic[@"getPeople"];
    }
    return personAry.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 99*WidthScale;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"orderID";
    orderStatusTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[orderStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *personDic=presentDic[@"presentPerson"][indexPath.row];
    //逻辑应包含等待赠送、等待领取、已领完、已退款，四种情况，根据实际后台数据变动
    if ([self.title isEqualToString:@"等待赠送"]) {
        personDic=presentDic[@"presentPerson"][indexPath.row];
    }else
    if ([self.title isEqualToString:@"等待领取"]) {
        personDic=presentDic[@"getPeople"][indexPath.row];
    }else
    if ([self.title isEqualToString:@"已领完"]) {
        personDic=presentDic[@"getPeople"][indexPath.row];
    }else
    {
        personDic=presentDic[@"getPeople"][indexPath.row];
    }
    cell.name.text=personDic[@"name"];
    [cell.name sizeToFit];
    cell.time.text=personDic[@"time"];
    cell.header.image=[UIImage imageNamed:personDic[@"heard"]];
    
    return cell;
}

#pragma mark---各个按钮的触发---
//删除订单
-(void)delegateOrder:(UIButton *)sender{
    YFAlert *yfAlert = [[YFAlert alloc] initWithTitle:@"提示" message:@"您正在删除订单，请确认操作"];
    [yfAlert addBtnAlertTitle:@"确认" action:^{
        NSLog(@"确认");
        
    }];
    [yfAlert addBtnAlertTitle:@"取消" action:^{
        NSLog(@"取消");
    }];
    
    [yfAlert showAlertWithSender:self];
}
//立即支付
-(void)payOrder:(UIButton *)sender{
    
}
//取消订单
-(void)cancelOrder:(UIButton *)sender{
    YFAlert *yfAlert = [[YFAlert alloc] initWithTitle:@"提示" message:@"您正在取消订单，请确认操作"];
    [yfAlert addBtnAlertTitle:@"确认" action:^{
        NSLog(@"确认");
    
    }];
    [yfAlert addBtnAlertTitle:@"取消" action:^{
        NSLog(@"取消");
    }];
    
    [yfAlert showAlertWithSender:self];
}
-(void)orderRefund:(UIButton *)sender{
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
