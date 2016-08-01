//
//  giftStrategyViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/7/27.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "giftStrategyViewController.h"
#import "GGImagePageView.h"
@interface giftStrategyViewController ()
@property (nonatomic,strong)UIScrollView *backGround;//底层

@end

@implementation giftStrategyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _backGround=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _backGround.backgroundColor=[UIColor whiteColor];
    self.view = _backGround;
    [self view1];
}
-(void)view1{
    UIView *viwepager=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*270/750)];
    viwepager.backgroundColor=[UIColor lightGrayColor];
    [_backGround addSubview:viwepager];
    GGImagePageView *imagePageView = [[GGImagePageView alloc]initWithFrame:viwepager.frame withSelectImageBlock:^(int selectIndex) {
        /**
         *  点击图片
         */
        NSLog(@"%d",selectIndex);
        
    }];
    
    imagePageView.isTimer = YES;
    
    imagePageView.showPageControl = YES;
    
    imagePageView.imageAarray = @[@"2.jpg",@"2.jpg",@"2.jpg",@"2.jpg",@"2.jpg"];
    
    [viwepager addSubview:imagePageView];
}
-(void)view2{
    NSMutableArray *adImages=[NSMutableArray arrayWithObject:@[@"2.jpg",@"2.jpg",@"2.jpg",@"2.jpg",@"2.jpg"]];
    UIScrollView *adScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, ScreenWidth*270/750, ScreenWidth, 80)];
    adScrollView.contentSize=CGSizeMake(80*adImages.count, 0);
    
    
}
-(void)view3{
    
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
