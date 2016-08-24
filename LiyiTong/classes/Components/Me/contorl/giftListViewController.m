//
//  giftListViewController.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/16.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "giftListViewController.h"
#import "giftListTableViewCell.h"
#import <SDAutoLayout.h>
#import "orderStatusViewController.h"
#import "YFAlert.h"
#import "detailViewController.h"
#import "getGiftViewController.h"
@interface giftListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *backScroll;
    UITableView *tabview;
    NSArray *dataList;
}
@end

@implementation giftListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"送出的礼物";
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
    
    dataList=@[
  @{@"orderNum":@"11254895",@"orderStatus":@"等待支付",@"orderImage":@"shoulian_order",@"title1":@"多彩女人  幸运四叶草钻石切边手链",@"price":@"139.00",@"number":@"5",@"priceEnd":@"1396.00"},
  @{@"orderNum":@"11254895",@"orderStatus":@"等待赠送",@"orderImage":@"shoulian_order",@"title1":@"多彩女人  幸运四叶草钻石切边手链",@"price":@"139.00",@"number":@"5",@"priceEnd":@"1396.00"},
  @{@"orderNum":@"11254895",@"orderStatus":@"等待领取",@"orderImage":@"shoulian_order",@"title1":@"多彩女人  幸运四叶草钻石切边手链",@"price":@"139.00",@"number":@"5",@"priceEnd":@"1396.00"},
  @{@"orderNum":@"11254895",@"orderStatus":@"已领完",@"orderImage":@"shoulian_order",@"title1":@"多彩女人  幸运四叶草钻石切边手链",@"price":@"139.00",@"number":@"5",@"priceEnd":@"1396.00"},
  @{@"orderNum":@"11254895",@"orderStatus":@"已取消",@"orderImage":@"shoulian_order",@"title1":@"多彩女人  幸运四叶草钻石切边手链",@"price":@"139.00",@"number":@"5",@"priceEnd":@"1396.00"},
  @{@"orderNum":@"11254895",@"orderStatus":@"已退款",@"orderImage":@"shoulian_order",@"title1":@"多彩女人  幸运四叶草钻石切边手链",@"price":@"139.00",@"number":@"5",@"priceEnd":@"1396.00"}];
    
    backScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backScroll.contentSize=CGSizeMake(0, 436*WidthScale*dataList.count+64);
    backScroll.backgroundColor=Color(238, 238, 238);
    backScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:backScroll];
    
    tabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 450*WidthScale*10+74*WidthScale) style:UITableViewStylePlain];
    tabview.backgroundColor=[UIColor lightGrayColor];
    tabview.scrollEnabled=NO;
    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [backScroll addSubview:tabview];
    tabview.delegate=self;
    tabview.dataSource=self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 436*WidthScale;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"giftListID";
    giftListTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[giftListTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *orderDic=dataList[indexPath.row];
    cell.xiangqing.tag=450+indexPath.row;
    [cell.xiangqing addTarget:self action:@selector(xiangqing:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag=400+indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
    cell.orderNum.text=[NSString stringWithFormat:@"订单号:%@",orderDic[@"orderNum"]];
    cell.orderStatus.text=orderDic[@"orderStatus"];
    cell.orderImage.image=[UIImage imageNamed:orderDic[@"orderImage"]];
    cell.title1.text=orderDic[@"title1"];
    NSString *price=orderDic[@"price"];
    NSString *number=orderDic[@"number"];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@X%@",price,number]];
    //%d
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(204, 204, 204) range:NSMakeRange(0,price.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0,price.length)];
    //天后生日
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(204, 204, 204) range:NSMakeRange(price.length,1+number.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(price.length,1+number.length)];
    cell.priceWithNum.attributedText=str1;
    
    NSString *priceEnd=orderDic[@"priceEnd"];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付款:¥%@",priceEnd]];
    //%d
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(51, 51, 51) range:NSMakeRange(0,5)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0,5)];
    //天后生日
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(51, 51, 51) range:NSMakeRange(5,priceEnd.length)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(5,priceEnd.length)];
    cell.priceEnd.attributedText=str2;
    
    UIView *line2=[cell.contentView viewWithTag:291];
    
    if ([orderDic[@"orderStatus"] isEqualToString:@"等待支付"]) {
        [cell.button2 setTitle:@"立即支付" forState:UIControlStateNormal];
        cell.button2.sd_layout.topSpaceToView(line2,18*WidthScale).rightEqualToView(line2).widthIs(180*WidthScale).heightIs(62*WidthScale);
        cell.button2.tag=350+indexPath.row;
        [cell.button2 addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button1 setTitle:@"取消订单" forState:UIControlStateNormal];
        cell.button1.sd_layout.rightSpaceToView(cell.button2,13*WidthScale).topEqualToView(cell.button2).widthIs(180*WidthScale).heightIs(62*WidthScale);
        cell.button1.tag=300+indexPath.row;
        [cell.button1 addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    }else
    if ([orderDic[@"orderStatus"] isEqualToString:@"等待赠送"]) {
        [cell.button2 setTitle:@"赠送" forState:UIControlStateNormal];
        cell.button2.sd_layout.topSpaceToView(line2,18*WidthScale).rightEqualToView(line2).widthIs(180*WidthScale).heightIs(62*WidthScale);
        cell.button2.tag=350+indexPath.row;
        [cell.button2 addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button1 setTitle:@"自己领" forState:UIControlStateNormal];
        cell.button1.sd_layout.rightSpaceToView(cell.button2,13*WidthScale).topEqualToView(cell.button2).widthIs(180*WidthScale).heightIs(62*WidthScale);
        cell.button1.tag=300+indexPath.row;
        [cell.button1 addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    }else
    if ([orderDic[@"orderStatus"] isEqualToString:@"等待领取"]) {
        
    }else
    if ([orderDic[@"orderStatus"] isEqualToString:@"已领完"]) {
        [cell.button1 setTitle:@"再次购买" forState:UIControlStateNormal];
        cell.button1.sd_layout.topSpaceToView(line2,18*WidthScale).rightEqualToView(line2).widthIs(180*WidthScale).heightIs(62*WidthScale);
        cell.button1.tag=300+indexPath.row;
        [cell.button1 addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    }else
    if ([orderDic[@"orderStatus"] isEqualToString:@"已取消"]) {
        [cell.button1 setTitle:@"再次购买" forState:UIControlStateNormal];
        cell.button1.sd_layout.topSpaceToView(line2,18*WidthScale).rightEqualToView(line2).widthIs(180*WidthScale).heightIs(62*WidthScale);
        cell.button1.tag=300+indexPath.row;
        [cell.button1 addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    }else
    if ([orderDic[@"orderStatus"] isEqualToString:@"已退款"]) {
        [cell.button1 setTitle:@"退款详情" forState:UIControlStateNormal];
        cell.button1.sd_layout.topSpaceToView(line2,18*WidthScale).rightEqualToView(line2).widthIs(180*WidthScale).heightIs(62*WidthScale);
        cell.button1.tag=300+indexPath.row;
        [cell.button1 addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        NSLog(@"订单%ld>>>>>>未知订单类型>>>>>",(long)indexPath.row);
    }
    return cell;
}
//点击选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)deleteOrder:(UIButton *)sender{
    orderStatusViewController *orderStatus=[[orderStatusViewController alloc]init];
    NSString *orderNum=dataList[sender.tag-400][@"orderNum"];
    orderStatus.orderNum=orderNum;
    orderStatus.title=@"删除订单";
    [self.navigationController pushViewController:orderStatus animated:YES];
    
}
-(void)xiangqing:(UIButton *)sender{
    NSString *orderNum=dataList[sender.tag-450][@"orderNum"];
    NSString *orderStatusStr=dataList[sender.tag-450][@"orderStatus"];
    orderStatusViewController *orderStatus=[[orderStatusViewController alloc]init];
    orderStatus.orderNum=orderNum;
    orderStatus.title=[orderStatusStr copy];
    [self.navigationController pushViewController:orderStatus animated:YES];
}
-(void)changePage:(UIButton *)sender{
    NSLog(@"%@",sender.currentTitle);
    NSString *buttonTxt=sender.currentTitle;
    if ([buttonTxt isEqualToString:@"取消订单"]) {
        YFAlert *yfAlert = [[YFAlert alloc] initWithTitle:@"提示" message:@"您正在取消订单，请确认操作"];
        [yfAlert addBtnAlertTitle:@"确认" action:^{
            NSLog(@"确认");
            
        }];
        [yfAlert addBtnAlertTitle:@"取消" action:^{
            NSLog(@"取消");
        }];
        
        [yfAlert showAlertWithSender:self];
    }else
    if ([buttonTxt isEqualToString:@"立即支付"]) {
        
    }else
    if ([buttonTxt isEqualToString:@"自己领"]) {
        getGiftViewController *getgift=[[getGiftViewController alloc]init];
        [self.navigationController pushViewController:getgift animated:YES];
    }else
    if ([buttonTxt isEqualToString:@"赠送"]) {
        
    }else
    if ([buttonTxt isEqualToString:@"再次购买"]) {
        detailViewController *detail=[[detailViewController alloc]init];
        [self.navigationController pushViewController:detail animated:YES];
    }else
    if ([buttonTxt isEqualToString:@"退款详情"]) {
        orderStatusViewController *orderStatus=[[orderStatusViewController alloc]init];
        NSString *orderNum=dataList[sender.tag-300][@"orderNum"];
        orderStatus.orderNum=orderNum;
        orderStatus.title=buttonTxt;
        [self.navigationController pushViewController:orderStatus animated:YES];
    }else{
        NSLog(@">>>>>错误的操作！！！>>>>>");
    }
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
