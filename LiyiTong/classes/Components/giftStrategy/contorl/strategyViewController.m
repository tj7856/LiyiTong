//
//  strategyViewController.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/4.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "strategyViewController.h"
#import "strategyTableViewCell.h"
#import <SDAutoLayout.h>
#import "YFActionSheet.h"

@interface strategyViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollview;
@property (nonatomic,strong)UIScrollView *scaleScroll;
@property (nonatomic,strong)UIImageView *topImageView;
@property (nonatomic,assign)CGFloat offsetx;
@property (nonatomic,strong)UIView *navview;
@end

@implementation strategyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    _scaleScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight/2)];
    [self.view addSubview: _scaleScroll];
    
    _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _scrollview.backgroundColor=[UIColor clearColor];
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.contentSize=CGSizeMake(0, (710*10+325+250)*WidthScale);
    _scrollview.delegate=self;
    [self.view addSubview: _scrollview];
    UIView *clearView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 325*WidthScale)];
    clearView.backgroundColor=[UIColor clearColor];
    [_scrollview addSubview:clearView];
    
    [self view1];
    [self view2];
    [self navView];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
}
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    
//    return UIStatusBarStyleLightContent;
//}
- (BOOL)prefersStatusBarHidden
{

    return NO;
}
//自定义导航栏
-(void)navView{
    _navview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navview.backgroundColor=Color(11, 231, 196);
    self.navview.alpha=0;
    [self.view addSubview:_navview];
    //自定义返回按钮
    UIButton *backButton = [[UIButton alloc]init];
    backButton.frame=CGRectMake(10, 25, 25, 25);
    //设置UIButton的图像
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //    backButton.backgroundColor=[UIColor orangeColor];
    
    [backButton addTarget:self action:@selector(backItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
//    backButton.sd_layout.leftSpaceToView(self.view,25*WidthScale).topSpaceToView(self.view,20*WidthScale).widthIs(25).heightIs(25);
    
    UIButton *shareButton=[[UIButton alloc]init];
    [shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    shareButton.frame=CGRectMake(ScreenWidth-35, 25, 25, 25);
    [self.view addSubview:shareButton];
//    shareButton.sd_layout.rightSpaceToView(self.view,25*WidthScale).topSpaceToView(self.view,20*WidthScale).widthIs(25).heightIs(25);
    [shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
}
-(void)view1{
    _topImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 325*WidthScale)];
    _topImageView.image=[UIImage imageNamed:@"bammer_01"];
    [_scaleScroll addSubview:_topImageView];
    
    
   
}

-(void)view2{
    UITableView *tabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 325*WidthScale, ScreenWidth, 730*10*WidthScale+20) style:UITableViewStylePlain];
    tabview.backgroundColor=Color(238, 238, 238);
    tabview.scrollEnabled=NO;
    
    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabview.tableHeaderView=[self addHeaderView];
    [_scrollview addSubview:tabview];
    tabview.delegate=self;
    tabview.dataSource=self;
}
-(UIView *)addHeaderView{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 250*WidthScale)];
    headerView.backgroundColor=[UIColor whiteColor];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 20*WidthScale, ScreenWidth, 20)];
    titleLabel.adjustsFontSizeToFitWidth=YES;
    titleLabel.text=@"第一期|中秋礼物不会挑  跟着偶像学一招";
    titleLabel.textColor=Color(51, 51, 51);
    [headerView addSubview:titleLabel];
    
    NSString *string=@"每次为了挑选礼物绞尽脑汁,如果你不是那么懂对方心思,不太了解朋友的兴趣爱好的送礼困难户,那就跟着偶像学学吧！";
    UILabel *detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+15*WidthScale, ScreenWidth-20, 150*WidthScale)];
    detailLabel.textColor=Color(153, 153, 153);
    detailLabel.text=string;
    detailLabel.numberOfLines=3;
    detailLabel.adjustsFontSizeToFitWidth=YES;
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    detailLabel.attributedText = attributedString;
    [headerView addSubview:detailLabel];
    [detailLabel sizeToFit];
    return headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 710*WidthScale;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"strategy";
    strategyTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[strategyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    cell.detailLabel.text=@"每次为了挑选礼物绞尽脑汁,如果你不是那么懂对方心思,不太了解朋友的兴趣爱好的送礼困难户,那就跟着偶像学学吧！";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cell.detailLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [cell.detailLabel.text length])];
    cell.detailLabel.attributedText = attributedString;
    cell.imageview.image=[UIImage imageNamed:@"gonglue_04"];
    cell.price.text=@"¥2228.00";
    cell.explainLabel.text=@"高档包装月饼";
    cell.lovePersonNum.text=@"2254人喜欢";
    
    
    return cell;
}
//点击选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NewsModel *model=modelList[indexPath.row];
//    NSLog(@"%@",model.title);
    NSLog(@"%ld",(long)indexPath.row);
}

-(void)backItemClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)share{
    NSArray *titles = @[@"分享到QQ空间",@"分享到QQ",@"分享到朋友圈",@"分享到微信"];
    NSArray *imageNames = @[@"kongjian",@"QQ",@"quan",@"weixin"];
    YFActionSheet *sheet = [[YFActionSheet alloc] initWithTitles:titles iconNames:imageNames];
    [sheet showActionSheetWithClickBlock:^(int btnIndex) {
        NSLog(@"btnIndex:%d",btnIndex);
    } cancelBlock:^{
        NSLog(@"取消");
    }];
}
//拖拽改变图片大小
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%f",scrollView.contentOffset.y);
    CGFloat offsetHeight=325*WidthScale-64;
    self.offsetx =  scrollView.contentOffset.y;
    //获取偏移量
    CGFloat offsetY = scrollView.contentOffset.y;

       //等比例的伸缩
    CGFloat scale= 1-(offsetY/60);
    scale = (scale>=1)?scale :1;
    self.topImageView.transform = CGAffineTransformMakeScale(scale, scale);
    CGFloat alpha =  self.offsetx/offsetHeight;
//    NSLog(@"%f",alpha);
    if (alpha>=1) {
        alpha =1;
    }
    if (alpha<0) {
        alpha=0;
    }
    self.navview.alpha=alpha;
//    UIColor *white = [UIColor colorWithWhite:1 alpha:alpha];
//    
//    UIImage *ima = [UIImage imageWithColor:white ];
//    [self.navigationController.navigationBar setBackgroundImage:ima forBarMetrics:UIBarMetricsDefault];
//    self.navigationItem.titleView.alpha = alpha;

}


//tabBar隐藏和恢复
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBar.hidden=YES;
//    self.navigationController.navigationBar.translucent = NO;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]; //状态栏设置为透明
    self.navigationController.navigationBar.hidden=NO;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.tabBarController.tabBar.hidden=YES;
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
