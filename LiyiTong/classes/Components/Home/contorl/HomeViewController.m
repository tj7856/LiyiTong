//
//  HomeViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/7/27.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "HomeViewController.h"
#import "SelectedView.h"
#import "GiveViewController.h"
#import "giftStrategyViewController.h"
#import "GuessViewController.h"
#import "confrimOrderViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate>
/** 顶部选择视图 */
@property(nonatomic, weak) SelectedView *selectedView;
/** UIScrollView */
@property(nonatomic, weak) UIScrollView *scrollView;
/** 礼物攻略**/
@property(nonatomic,weak)giftStrategyViewController *giftSVc;
/**猜ta喜欢**/
@property(nonatomic,weak)GuessViewController *guessVc;
///**大家都在送**/
//@property(nonatomic,weak)GiveViewController *giveVc;

@end

@implementation HomeViewController

- (void)loadView
{
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.contentSize = CGSizeMake(ScreenWidth * 2, 0);
    view.backgroundColor = [UIColor whiteColor];
    // 去掉滚动条
    view.showsVerticalScrollIndicator = NO;
    view.showsHorizontalScrollIndicator = NO;
    // 设置分页
    view.pagingEnabled = YES;
    // 设置代理
    view.delegate = self;
    // 去掉弹簧效果
    view.bounces = NO;
    
    CGFloat height = ScreenHeight - 49;
    
    // 添加子视图
    giftStrategyViewController *gift = [[giftStrategyViewController alloc] init];
    gift.view.frame = [UIScreen mainScreen].bounds;
    gift.view.height = height;
    [self addChildViewController:gift];
    [view addSubview:gift.view];
    _giftSVc = gift;
    
    
    GuessViewController *guess = [[GuessViewController alloc] init];
    guess.view.frame = [UIScreen mainScreen].bounds;
    guess.view.x = ScreenWidth;
    guess.view.height = height;
    [self addChildViewController:guess];
    [view addSubview:guess.view];
    _guessVc = guess;
    
//    GiveViewController *care = [UIStoryboard storyboardWithName:NSStringFromClass([ALinCareViewController class]) bundle:nil].instantiateInitialViewController;
//    GiveViewController *give = [[GiveViewController alloc]init];
//    give.view.frame = [UIScreen mainScreen].bounds;
//    give.view.x = ScreenWidth * 2;
//    give.view.height = height;
//    [self addChildViewController:give];
//    [view addSubview:give.view];
//    _giveVc = give;
//    
    self.view = view;
  
    self.automaticallyAdjustsScrollViewInsets =YES;
    self.scrollView = view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)setup
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"q_06"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"q_03"] style:UIBarButtonItemStyleDone target:self action:@selector(rankCrown)];
    [self setupTopMenu];
}

- (void)rankCrown
{
//    UIViewController *search = [[UIViewController alloc] init];
//    search.navigationItem.title = @"搜索";
//    search.view.backgroundColor = [UIColor greenColor];
//   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([confrimOrderViewController class]) bundle:nil];
//    confrimOrderViewController * confirm = [storyboard instantiateInitialViewController];
//    [_selectedView removeFromSuperview];
//    _selectedView = nil;
//    [self.navigationController pushViewController:confirm animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_selectedView) {
        [self setupTopMenu];
    }
}
- (void)setupTopMenu
{
    // 设置顶部选择视图
    SelectedView *selectedView = [[SelectedView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    
    selectedView.x = 45;
    selectedView.width = ScreenWidth - 45 * 2;
    [selectedView setSelectedBlock:^(HomeType type) {
        [self.scrollView setContentOffset:CGPointMake(type * ScreenWidth, -64) animated:YES];
     
    }];
    [self.navigationController.navigationBar addSubview:selectedView];
    _selectedView = selectedView;
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"--%f--%f",scrollView.contentOffset.x,ScreenWidth);
//    NSLog(@"000%@",scrollView.subviews);
    CGFloat page = scrollView.contentOffset.x / ScreenWidth;
//    CGFloat offsetX = scrollView.contentOffset.x / ScreenWidth * (self.selectedView.width * 0.5 - Home_Seleted_Item_W * 0.5 - 15);
    CGFloat offsetX = scrollView.contentOffset.x / ScreenWidth * ((self.selectedView.width - DefaultMargin * 14 - Home_Seleted_Item_W*2)+Home_Seleted_Item_W);
//    self.selectedView.underLine.x = 15 + offsetX;
    
    self.selectedView.underLine.x = DefaultMargin*7+offsetX;
    if (page == 1 ) {
        self.selectedView.underLine.x = offsetX + DefaultMargin*7;
    }else if (page > 1){
        self.selectedView.underLine.x = offsetX + DefaultMargin*7;
    }
    self.selectedView.selectedType = (int)(page+0.5 );
    NSLog(@"%@---%@",NSStringFromCGRect(self.scrollView.frame),NSStringFromCGRect(self.guessVc.view.frame));
  
   
    
}

@end
