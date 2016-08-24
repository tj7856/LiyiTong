//
//  MeViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/7/27.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "MeViewController.h"
#import "giftListViewController.h"

@interface MeViewController ()
{
    UIScrollView *backScroll;
}
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我";
    backScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    backScroll.contentSize=CGSizeMake(0, 338*WidthScale+10+80*WidthScale+[_newCityDic allKeys].count*20+_oldCityList.count*53+64);
    backScroll.backgroundColor=Color(238, 238, 238);
    backScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:backScroll];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 50);
    [button setTitle:@"礼物详情" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor brownColor];
    [button addTarget:self action:@selector(doit:) forControlEvents:UIControlEventTouchUpInside];
    button.showsTouchWhenHighlighted=YES;
    [backScroll addSubview:button];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    label.backgroundColor=[UIColor purpleColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor blueColor];
    //    label.numberOfLines=0;
    label.adjustsFontSizeToFitWidth=YES;
    label.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
    label.center=self.view.center;
    [self.view addSubview:label];
    
}

-(void)doit:(UIButton *)sender{
    giftListViewController *giftList=[[giftListViewController alloc]init];
    [self.navigationController pushViewController:giftList animated:YES];
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
