//
//  allAddressViewController.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/18.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "allAddressViewController.h"
#import <SDAutoLayout.h>
#import "addAddressViewController.h"
#import "addressTableViewCell.h"

@interface allAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *backScroll;
    UITableView *tabview;
    NSArray *dataList;
}
@end

@implementation allAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backItem;
    
    dataList=@[@{@"name":@"张春春",@"telePhone":@"13654895578",@"releaseAddress":@"上海市市辖区黄浦区",@"detailAddress":@"复兴中路125号",@"default":@"1"},
               @{@"name":@"张夏夏",@"telePhone":@"13654895578",@"releaseAddress":@"上海市市辖区黄浦区",@"detailAddress":@"复兴中路125号",@"default":@"0"},
               @{@"name":@"张秋秋",@"telePhone":@"13654895578",@"releaseAddress":@"上海市市辖区黄浦区",@"detailAddress":@"复兴中路125号",@"default":@"0"},
               @{@"name":@"张冬冬",@"telePhone":@"13654895578",@"releaseAddress":@"上海市市辖区黄浦区",@"detailAddress":@"复兴中路125号",@"default":@"0"}];
    
//    [self view1];
//    [self view2];
    if (dataList!=nil) {
        [self view2];
    }else{
        [self view1];
    }
}
-(void)view1{
    UIImageView *mapImage=[[UIImageView alloc]init];
    mapImage.image=[UIImage imageNamed:@"map_03"];
    [self.view addSubview:mapImage];
    mapImage.sd_layout.leftSpaceToView(self.view,65*WidthScale).rightSpaceToView(self.view,65*WidthScale).topSpaceToView(self.view,192*WidthScale).heightIs(300*WidthScale);
    UILabel *label=[[UILabel alloc]init];
    label.text=@"您还没有收货地址哦  !";
    label.textColor=[UIColor blackColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    label.sd_layout.leftEqualToView(mapImage).rightEqualToView(mapImage).topSpaceToView(mapImage,10).heightIs(25);
    UIButton *newAddress=[[UIButton alloc]init];
    newAddress.layer.borderWidth=1;
    newAddress.layer.borderColor=Color(0, 239, 200).CGColor;
    [newAddress setTitle:@"新建地址" forState:UIControlStateNormal];
    [newAddress setTitleColor:Color(0, 239, 200) forState:UIControlStateNormal];
    [newAddress addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newAddress];
    newAddress.sd_layout.leftSpaceToView(self.view,232*WidthScale).rightSpaceToView(self.view,232*WidthScale).topSpaceToView(label,10).heightIs(80*WidthScale);
}
-(void)view2{
    backScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    backScroll.contentSize=CGSizeMake(0, 436*WidthScale*dataList.count+64);
    backScroll.backgroundColor=Color(238, 238, 238);
    backScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:backScroll];
    
    tabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    tabview.backgroundColor=[UIColor whiteColor];
    tabview.scrollEnabled=NO;
    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [backScroll addSubview:tabview];
    tabview.delegate=self;
    tabview.dataSource=self;
    
    UIButton *addNew=[UIButton buttonWithType:UIButtonTypeCustom];
    [addNew setTitle:@"+  新建收货地址" forState:UIControlStateNormal];
    addNew.backgroundColor=Color(0, 239, 200);
    [addNew addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addNew];
    addNew.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0).heightIs(98*WidthScale);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 178*WidthScale;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"addressID";
    addressTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[addressTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSDictionary *addressDic=dataList[indexPath.row];
    cell.name.text=addressDic[@"name"];
    [cell.name sizeToFit];
    cell.telePhone.text=addressDic[@"telePhone"];
    cell.address.text=[NSString stringWithFormat:@"%@%@",addressDic[@"releaseAddress"],addressDic[@"detailAddress"]];
    if ([addressDic[@"default"] isEqualToString:@"1"]) {
        cell.chooseBtn.selected=YES;
    }
    cell.chooseBtn.tag=500+indexPath.row;
    [cell.chooseBtn addTarget:self action:@selector(chooseAddress:) forControlEvents:UIControlEventTouchUpInside];
    cell.changeBtn.tag=550+indexPath.row;
    [cell.changeBtn addTarget:self action:@selector(changeAddress:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
//点击选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)chooseAddress:(UIButton *)sender{
    for (int i=500; i<500+dataList.count; i++) {
        if (sender.tag==i) {
            continue;
        }else{
            UIButton *button=[self.view viewWithTag:i];
            button.selected=NO;
        }
        
    }
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addAddress:(UIButton *)sender{
    addAddressViewController *add=[[addAddressViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}
-(void)changeAddress:(UIButton *)sender{
    NSDictionary *addressDic=dataList[sender.tag-550];
    addAddressViewController *add=[[addAddressViewController alloc]init];
    add.changeDic=addressDic;
    [self.navigationController pushViewController:add animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
