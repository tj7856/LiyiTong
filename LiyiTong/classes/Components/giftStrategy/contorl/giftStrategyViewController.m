//
//  giftStrategyViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/7/27.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "giftStrategyViewController.h"

#import "GGImagePageView.h"
//#import "giftTableViewCell.h"
#import "TalkTableViewCell.h"
#import <SDAutoLayout.h>
#import "LYTAfnetworkingManager.h"
#import "CheckPhone.h"
#import "UIViewController+SLHUD.h"
#import "strategyViewController.h"
//#import "login.h"
#import "loginViewController.h"
#import "LoginVC.h"
@interface giftStrategyViewController ()<UITableViewDelegate,UITableViewDataSource,GGImagePageViewDelegate>
{
    UIView *viwepager;
    UIScrollView *adScrollView;
    UITableView *tabview;
}
@property (nonatomic,strong)UIScrollView *backGround;//底层

@end

@implementation giftStrategyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _backGround=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _backGround.backgroundColor=[UIColor whiteColor];
    _backGround.showsVerticalScrollIndicator = NO;
//    _backGround.bounces = NO;
    _backGround.contentSize=CGSizeMake(0, ScreenWidth*270/750+235*WidthScale+450*WidthScale*10+74*WidthScale+self.tabBarController.tabBar.size.height+64);
    self.view = _backGround;
    
    [self view1];
    [self view2];
    [self view3];
}
-(void)view1{
    viwepager=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*270/750)];
    viwepager.backgroundColor=[UIColor lightGrayColor];
    [_backGround addSubview:viwepager];
    GGImagePageView *imagePageView = [[GGImagePageView alloc]initWithFrame:viwepager.frame];
    imagePageView.lazyDelegate=self;
    imagePageView.isTimer = YES;
    
    imagePageView.showPageControl = YES;
    
    imagePageView.imageAarray = @[@"banner_02",@"banner_02",@"banner_02",@"banner_02",@"banner_02"];
    
    [viwepager addSubview:imagePageView];
}
-(void)view2{
    CGFloat width=235*WidthScale;
    CGFloat btnWidth=185*WidthScale;
    NSArray *adImagesArray=@[@"t1",@"t2",@"t3",@"2.jpg"];
    NSMutableArray *adImages=[adImagesArray mutableCopy];
    adScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, ScreenWidth*270/750, ScreenWidth, width)];
    adScrollView.contentSize=CGSizeMake(width*(adImages.count+1), 0);
    adScrollView.showsHorizontalScrollIndicator = NO;
    [_backGround addSubview:adScrollView];
    for (int i=0; i<adImages.count+1; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((219*WidthScale*i)+17*WidthScale, 25*WidthScale, btnWidth, btnWidth)];
//        btn.imageView.contentMode=UIViewContentModeScaleAspectFit;
        btn.imageView.layer.cornerRadius=5;
        if (i==adImages.count) {
            [btn setImage:[UIImage imageNamed:@"seeAll.PNG"] forState:UIControlStateNormal];
        }else{
            [btn setImage:[UIImage imageNamed:adImages[i]] forState:UIControlStateNormal];
//            btn.backgroundColor=[UIColor blueColor];
        }
        btn.tag=200+i;
        [adScrollView addSubview:btn];
        [btn addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *btnText=[[UILabel alloc]initWithFrame:CGRectMake((219*WidthScale*i)+17*WidthScale, CGRectGetMaxY(btn.frame)-52*WidthScale, btnWidth, 30*WidthScale)];
        btnText.adjustsFontSizeToFitWidth=YES;
        btnText.textColor=[UIColor whiteColor];
        if (i==adImages.count) {
            btnText.text=@"查看全部";
            btnText.textColor=[UIColor colorWithRed:0.392 green:0.902 blue:0.725 alpha:1.000];
        }else{
            btnText.text=adImages[i];
        }
        btnText.textAlignment=NSTextAlignmentCenter;
        [adScrollView addSubview:btnText];
    }
    
}
-(void)view3{
    
//    NSLog(@"--%@",NSStringFromCGRect(_backGround.frame));
    tabview=[[UITableView alloc]initWithFrame:CGRectMake(0, ScreenWidth*270/750+235*WidthScale, ScreenWidth, 450*WidthScale*10+74*WidthScale) style:UITableViewStylePlain];
    tabview.backgroundColor=[UIColor lightGrayColor];
    tabview.scrollEnabled=NO;
    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tabview.tableHeaderView=[self addHeaderView];
    [_backGround addSubview:tabview];
    tabview.delegate=self;
    tabview.dataSource=self;
}
-(UIView *)addHeaderView{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 74*WidthScale)];
    headerView.backgroundColor=Color(221, 221, 221);
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 20*WidthScale, ScreenWidth, 52*WidthScale)];
    backView.backgroundColor=[UIColor whiteColor];
    [headerView addSubview:backView];
    
    UIView *left=[[UIView alloc]init];
    left.backgroundColor=Color(153, 153, 153);
    [backView addSubview:left];
    left.sd_layout.leftSpaceToView(backView,ScreenWidth/2-130*WidthScale).topSpaceToView(backView,27*WidthScale).widthIs(45*WidthScale).heightIs(1);
    
    UIView *right=[[UIView alloc]init];
    right.backgroundColor=Color(153, 153, 153);
    [backView addSubview:right];
    right.sd_layout.rightSpaceToView(backView,ScreenWidth/2-130*WidthScale).topEqualToView(left).widthIs(45*WidthScale).heightIs(1);
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"精选攻略";
    label.textColor=Color(153, 153, 153);
    label.textAlignment=NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth=YES;
    [backView addSubview:label];
    label.sd_layout.leftSpaceToView(left,0).rightSpaceToView(right,0).topSpaceToView(backView,6*WidthScale).heightIs(20);
    
    return headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 510*WidthScale;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    TalkTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[TalkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
//    cell.backImage.image=[UIImage imageNamed:@"tmp"];
//    cell.loveLabel.text=@"342";
//    cell.captionLabel.text=@"搞定身边挑剔的Geek死宅";
//    cell.describeLabel.text=@"今年是贯彻习近平主席改革强军战略，推动国防和军队改革向纵深发展的关键之年";
//    cell.label1.text=@"IT  领导  苹果  上班族";
    return cell;
}
//点击选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
//    strategyViewController *strategy=[[strategyViewController alloc]init];
//    [self.navigationController pushViewController:strategy animated:YES];
}

-(void)changePage:(UIButton *)sender{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        //        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        NSLog(@"第一次启动");
//        loginViewController *loginviewController=[[loginViewController alloc]init];
//        //
//        [self presentViewController:loginviewController animated:YES completion:nil];
       
        LoginVC *login = [[LoginVC alloc]init];
        UINavigationController *logNAV = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:logNAV animated:YES completion:nil];
        //            [login login:self];
    }else{
        NSLog(@"不是第一次启动");
    }
    
}
- (void)didSelectViewWithIndex:(NSInteger)index{
    NSLog(@"图片轮播%ld",index);
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
