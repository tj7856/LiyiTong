//
//  GuessViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/7/27.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "GuessViewController.h"
#import <SDAutoLayout.h>
#import "guessModel.h"
@interface GuessViewController ()
{
    NSArray *dataList;
    NSMutableArray *modelList;
}
@end

@implementation GuessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.110 green:0.184 blue:0.098 alpha:1.000];
    
    //    1、请求下来的网络数据
    dataList=@[@{@"关系":
  @[
  @{@"title":@"女票",@"detail":@[@{
              @"因为":@[@"A",@"A",@"A",@"A",@"A",@"A",@"A"],
              @"Ta是":@[@"B",@"B",@"B",@"B",@"B",@"B",@"B"],
              @"爱好":@[@"C",@"C",@"C",@"C",@"C",@"C",@"C"]
              }]},
  @{@"title":@"男票",@"detail":@[@{
              @"因为":@[@"A",@"A",@"A",@"A",@"A",@"A",@"A"],
              @"Ta是":@[@"B",@"B",@"B",@"B",@"B",@"B",@"B"],
              @"爱好":@[@"C",@"C",@"C",@"C",@"C",@"C",@"C"]}]}
                         
                         ]
                 
                 }];
    modelList=[NSMutableArray array];
    for (NSDictionary *dic in dataList[0][@"关系"]) {
        [modelList addObject:[guessModel modelWithDic:dic]];
    }
    NSLog(@"%lu %lu",dataList.count,modelList.count);
    
    
    UILabel *titleLbel=[[UILabel alloc]init];
//    titleLbel.adjustsFontSizeToFitWidth=YES;
    titleLbel.font=[UIFont systemFontOfSize:20];
    titleLbel.textColor=[UIColor whiteColor];
    titleLbel.textAlignment=NSTextAlignmentCenter;
    titleLbel.text=@"总能猜到Ta喜欢的";
    [self.view addSubview:titleLbel];
    titleLbel.sd_layout.leftSpaceToView(self.view,106*WidthScale).rightSpaceToView(self.view,106*WidthScale).topSpaceToView(self.view,50*HeightScale).heightIs(40);
    UILabel *titleLbel2=[[UILabel alloc]init];
        titleLbel2.adjustsFontSizeToFitWidth=YES;
    
//    titleLbel2.font=[UIFont systemFontOfSize:20];
    titleLbel2.textColor=Color(103, 105, 102);
    titleLbel2.textAlignment=NSTextAlignmentCenter;
    titleLbel2.text=@"选择与Ta相关的...,我们为您更精确挑选适合Ta的礼物";
    [self.view addSubview:titleLbel2];
    titleLbel2.sd_layout.topSpaceToView(titleLbel,10*HeightScale).leftSpaceToView(self.view,70*WidthScale).rightSpaceToView(self.view,70*WidthScale).heightIs(25*HeightScale);
    
}
//-(void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden=NO;
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden=YES;
//}
-(void)reloadDataWithInformation:(NSArray *)array{
    
    
    
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
