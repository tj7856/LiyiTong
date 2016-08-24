//
//  GetSuccessViewController.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/22.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "GetSuccessViewController.h"
#import <SDAutoLayout.h>
@interface GetSuccessViewController ()

@end

@implementation GetSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backItem;
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(35*WidthScale, 43*WidthScale, 678*WidthScale, 553*WidthScale)];
    imageview.image=[UIImage imageNamed:@"liwu_03"];
    [self.view addSubview:imageview];
    
    UILabel *label1=[[UILabel alloc]init];
    label1.text=@"成功领取礼物";
    label1.font=[UIFont systemFontOfSize:25];
    label1.textColor=Color(0, 239, 200);
    label1.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label1];
    label1.sd_layout.topSpaceToView(imageview,0).leftSpaceToView(self.view,216*WidthScale).rightSpaceToView(self.view,216*WidthScale).heightIs(25);
    
    UILabel *label2=[[UILabel alloc]init];
    label2.text=@"礼意通已通知商家为您发货 ！";
    label2.font=[UIFont systemFontOfSize:20];
    label2.textColor=[UIColor blackColor];
    label2.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label2];
    label2.sd_layout.topSpaceToView(label1,10).leftSpaceToView(self.view,90*WidthScale).rightSpaceToView(self.view,90*WidthScale).heightIs(25);
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor=Color(0, 239, 200);
    [button setTitle:@"查看详情" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.sd_layout.topSpaceToView(label2,15).leftSpaceToView(self.view,233*WidthScale).rightSpaceToView(self.view,233*WidthScale).heightIs(78*WidthScale);
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
