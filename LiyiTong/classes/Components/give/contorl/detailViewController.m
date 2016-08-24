//
//  detailViewController.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/8.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "detailViewController.h"
#import "GGImagePageView.h"
#import <SDAutoLayout.h>
#import "MJRefresh.h"
#import "ChoseView.h"
@interface detailViewController ()<UIScrollViewDelegate,GGImagePageViewDelegate,UITableViewDelegate,UITableViewDataSource,TypeSeleteDelegete>
{
    ChoseView *choseView;
    NSArray *sizearr;//型号数组
    NSArray *colorarr;//分类数组
    NSDictionary *stockarr;//商品库存量
    int goodsStock;

}
@property (nonatomic,strong)UIScrollView *scrollview;
@property(strong,nonatomic)UITableView *tabView;
@property(strong,nonatomic)UIWebView *webView;

@property (nonatomic,strong)UIView *navview;
@property (nonatomic,strong)UIView *viwepager;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIView *chooseView;
/**
 *  标题、标语、价格、快递费、说明
 */
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *sloganLabel;
@property (nonatomic,strong)UILabel *price;
@property (nonatomic,strong)UILabel *expressPrice;
@property (nonatomic,strong)UILabel *bottomLabel;
/**
 *
 */
@property (nonatomic,strong)UIImageView *shareImage;
@property (nonatomic,strong)UILabel *shareLabel;
@property (nonatomic,strong)UIButton *shareBtn;
@property (nonatomic,strong)UIImageView *loveImage;
@property (nonatomic,strong)UILabel *loveLabel;
@property (nonatomic,strong)UIButton *loveBtn;
@property (nonatomic,strong)UIImageView *hotImage;
@property (nonatomic,strong)UILabel *hotLabel;
@property (nonatomic,strong)UIButton *hotBtn;

@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight)];
    _scrollview.backgroundColor=Color(237, 238, 239);
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.pagingEnabled = YES;
//    _scrollview.scrollEnabled = NO;
    _scrollview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"下拉后在这里进行操作");
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _scrollview.contentSize=CGSizeMake(0, ScreenHeight*2);
            self.scrollview.contentOffset = CGPointMake(0, ScreenHeight-20);
        } completion:^(BOOL finished) {
            //结束加载
            [_scrollview.mj_footer endRefreshing];
        }];
        
    }];

    _scrollview.delegate=self;
    [self.view addSubview: _scrollview];
    
    [self navView];
    [self view1];
    [self view2];
    [self view3];
    [self tabbar];
    [self webview];

    
    /**
     这些数据应该从服务器获得
     */
    sizearr = [[NSArray alloc] initWithObjects:@"蓝色水晶",@"红色水晶",@"绿色水晶",nil];
    colorarr = [[NSArray alloc] initWithObjects:@"Mhao(W17*E19*H67CM)1",@"Mhao(W17*E19*H67CM)2",@"Mhao(W17*E19*H67CM)3",@"Mhao(W17*E19*H67CM)4",nil];
    NSString *str = [[NSBundle mainBundle] pathForResource: @"stock" ofType:@"plist"];
    stockarr = [[NSDictionary alloc] initWithContentsOfURL:[NSURL fileURLWithPath:str]];
    
    NSLog(@"%@",stockarr);
    
    [self initChoseView];
}
//自定义导航栏
-(void)navView{
    _navview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navview.backgroundColor=[UIColor whiteColor];
    self.navview.alpha=0.3;
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
    [shareButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    shareButton.frame=CGRectMake(ScreenWidth-35, 25, 25, 25);
    [self.view addSubview:shareButton];
    //    shareButton.sd_layout.rightSpaceToView(self.view,25*WidthScale).topSpaceToView(self.view,20*WidthScale).widthIs(25).heightIs(25);
//    [shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
}
-(void)view1{
    _viwepager=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 680*WidthScale)];
    _viwepager.backgroundColor=[UIColor lightGrayColor];
    [_scrollview addSubview:_viwepager];
    GGImagePageView *imagePageView = [[GGImagePageView alloc]initWithFrame:_viwepager.frame];
    imagePageView.lazyDelegate=self;
    imagePageView.isTimer = YES;
    
    imagePageView.showPageControl = YES;
    
    imagePageView.imageAarray = @[@"手链",@"手链",@"手链",@"手链"];
    
    [_viwepager addSubview:imagePageView];
}
-(void)view2{
    _backView=[[UIView alloc]initWithFrame:CGRectMake(0, 680*WidthScale, ScreenWidth, 366*WidthScale)];
    _backView.backgroundColor=[UIColor whiteColor];
    [_scrollview addSubview:_backView];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 263*WidthScale, ScreenWidth, 1)];
    line.backgroundColor=Color(220, 221, 222);
    [_backView addSubview:line];
    
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.text=@"多彩女人运四叶草钻石切边手链";
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    self.titleLabel.textColor=[UIColor blackColor];
    self.titleLabel.textAlignment=NSTextAlignmentLeft;
    [_backView addSubview:self.titleLabel];
    self.titleLabel.sd_layout.leftSpaceToView(_backView,8).bottomSpaceToView(line,208*WidthScale).widthIs(ScreenWidth).heightIs(36*WidthScale);
    
    NSString *string=@"想念的话输液说不完，关怀的心，永远都不变。\n送你一份小礼物，希望你喜欢!";
    self.sloganLabel=[[UILabel alloc]init];
//    self.sloganLabel.backgroundColor=[UIColor redColor];
    self.sloganLabel.text=string;
    self.sloganLabel.textColor=Color(118, 119, 120);
    self.sloganLabel.textAlignment=NSTextAlignmentLeft;
    self.sloganLabel.numberOfLines=0;
//    self.sloganLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.sloganLabel.font=[UIFont systemFontOfSize:15];
    [_backView addSubview:self.sloganLabel];
    self.sloganLabel.sd_layout.leftEqualToView(self.titleLabel).topSpaceToView(self.titleLabel,5).widthIs(ScreenWidth).heightIs(40);
    
    NSString *jiage=@"1396.00";
    self.price=[[UILabel alloc]init];
    self.price.textAlignment=NSTextAlignmentLeft;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",jiage]];
    self.price.textColor=Color(0, 240, 200);
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 1)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(1, jiage.length)];
    self.price.attributedText=str;
    [_backView addSubview:self.price];
    self.price.sd_layout.leftEqualToView(self.sloganLabel).topSpaceToView(self.sloganLabel,20*WidthScale).widthIs(215*WidthScale).heightIs(25);
    NSString *kuaidi=@"10";
    self.expressPrice=[[UILabel alloc]init];
    self.expressPrice.font=[UIFont systemFontOfSize:12];
    self.expressPrice.textColor=Color(192, 193, 194);
    self.expressPrice.textAlignment=NSTextAlignmentLeft;
    self.expressPrice.text=[NSString stringWithFormat:@"快递费%@元",kuaidi];
    [_backView addSubview:self.expressPrice];
    self.expressPrice.sd_layout.leftSpaceToView(self.price,1).bottomEqualToView(self.price).widthIs(150*WidthScale).heightIs(25);
    
    NSString *shangjia=@"商家";
    self.bottomLabel=[[UILabel alloc]init];
//    self.bottomLabel.backgroundColor=[UIColor redColor];
    self.bottomLabel.numberOfLines=0;
    self.bottomLabel.font=[UIFont systemFontOfSize:12];
    self.bottomLabel.textAlignment=NSTextAlignmentCenter;
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"该商品由%@发并提供售后服务,\n礼意通提供客服服务并支持提前赔付的退换货保障",shangjia]];
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(118, 119, 120) range:NSMakeRange(0,4)];
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(0, 240, 200) range:NSMakeRange(4,shangjia.length)];
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(118, 119, 120) range:NSMakeRange(4+shangjia.length,32)];
    self.bottomLabel.attributedText=str2;
    [_backView addSubview:self.bottomLabel];
    self.bottomLabel.sd_layout.leftSpaceToView(_backView,0).widthIs(ScreenWidth).topSpaceToView(line,0).heightIs(45);
}
-(void)view3{
    _chooseView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_backView.frame)+28*WidthScale, ScreenWidth, 76*WidthScale)];
    _chooseView.backgroundColor=[UIColor whiteColor];
    [_scrollview addSubview:_chooseView];
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"选择颜色分类";
    label.font=[UIFont systemFontOfSize:16];
    [_chooseView addSubview:label];
    label.sd_layout.leftSpaceToView(_chooseView,8).topSpaceToView(_chooseView,0).bottomSpaceToView(_chooseView,0).widthIs(150);
    
    UIImageView *chooseImage=[[UIImageView alloc]init];
    chooseImage.image=[UIImage imageNamed:@"choose"];
    [_chooseView addSubview:chooseImage];
    chooseImage.sd_layout.rightSpaceToView(_chooseView,8).topSpaceToView(_chooseView,0).widthIs(76*WidthScale).heightIs(76*WidthScale);
    UIButton *button=[[UIButton alloc]initWithFrame:_chooseView.bounds];
    [button addTarget:self action:@selector(btnselete) forControlEvents:UIControlEventTouchUpInside];
    [_chooseView addSubview:button];
}
-(void)tabbar{
    UIView *tabbarView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-50, ScreenWidth, 50)];
    tabbarView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:tabbarView];
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(137*WidthScale, 0, 1, 50)];
    line1.backgroundColor=Color(237, 238, 239);
    [tabbarView addSubview:line1];
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(137*2*WidthScale, 0, 1, 50)];
    line2.backgroundColor=Color(237, 238, 239);
    [tabbarView addSubview:line2];
    self.shareImage=[[UIImageView alloc]initWithFrame:CGRectMake(45*WidthScale, 5, 20, 20)];
    self.shareImage.image=[UIImage imageNamed:@"bgg_07"];
    [tabbarView addSubview:self.shareImage];
    self.shareLabel=[[UILabel alloc]init];
    self.shareLabel.textAlignment=NSTextAlignmentCenter;
    self.shareLabel.text=@"99";
    self.shareLabel.textColor=[UIColor grayColor];
    [tabbarView addSubview:self.shareLabel];
    self.shareLabel.sd_layout.leftSpaceToView(tabbarView,0).topSpaceToView(self.shareImage,0).widthIs(137*WidthScale).heightIs(20);
    self.shareBtn=[[UIButton alloc]init];
    [self.shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [tabbarView addSubview:self.shareBtn];
    self.shareBtn.sd_layout.leftSpaceToView(tabbarView,0).topSpaceToView(tabbarView,0).widthIs(137*WidthScale).heightIs(50);
    
    self.loveImage=[[UIImageView alloc]initWithFrame:CGRectMake(137*WidthScale+45*WidthScale, 5, 20, 20)];
    self.loveImage.image=[UIImage imageNamed:@"bg_05"];
    [tabbarView addSubview:self.loveImage];
    self.loveLabel=[[UILabel alloc]init];
    self.loveLabel.textAlignment=NSTextAlignmentCenter;
    self.loveLabel.text=@"259";
    self.loveLabel.textColor=[UIColor grayColor];
    [tabbarView addSubview:self.loveLabel];
    self.loveLabel.sd_layout.leftSpaceToView(tabbarView,137*WidthScale).topSpaceToView(self.shareImage,0).widthIs(137*WidthScale).heightIs(20);
    self.loveBtn=[[UIButton alloc]init];
    [self.loveBtn addTarget:self action:@selector(love:) forControlEvents:UIControlEventTouchUpInside];
    [tabbarView addSubview:self.loveBtn];
    self.loveBtn.sd_layout.leftSpaceToView(tabbarView,137*WidthScale).topSpaceToView(tabbarView,0).widthIs(137*WidthScale).heightIs(50);
    
    self.hotImage=[[UIImageView alloc]initWithFrame:CGRectMake(137*2*WidthScale+45*WidthScale, 5, 20, 20)];
    self.hotImage.image=[UIImage imageNamed:@"bgg_11"];
    [tabbarView addSubview:self.hotImage];
    self.hotLabel=[[UILabel alloc]init];
    self.hotLabel.textAlignment=NSTextAlignmentCenter;
    self.hotLabel.text=@"125";
    self.hotLabel.textColor=[UIColor grayColor];
    [tabbarView addSubview:self.hotLabel];
    self.hotLabel.sd_layout.leftSpaceToView(tabbarView,137*WidthScale*2).topSpaceToView(self.shareImage,0).widthIs(137*WidthScale).heightIs(20);
    self.hotBtn=[[UIButton alloc]init];
    [self.hotBtn addTarget:self action:@selector(hot:) forControlEvents:UIControlEventTouchUpInside];
    [tabbarView addSubview:self.hotBtn];
    self.hotBtn.sd_layout.leftSpaceToView(tabbarView,137*WidthScale*2).topSpaceToView(tabbarView,0).widthIs(137*WidthScale).heightIs(50);
    
    UIButton *send=[[UIButton alloc]init];
    send.backgroundColor=Color(0, 240, 200);
    [send setTitle:@"送Ta" forState:UIControlStateNormal];
    [send setTintColor:[UIColor whiteColor]];
    [tabbarView addSubview:send];
    send.sd_layout.leftSpaceToView(self.hotBtn,0).rightSpaceToView(tabbarView,0).topSpaceToView(tabbarView,0).bottomSpaceToView(tabbarView,0);
}
-(void)webview{
    self.tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_chooseView.frame)+28*WidthScale, ScreenWidth, 53*WidthScale) style:UITableViewStylePlain];
    self.tabView.delegate=self;
    self.tabView.dataSource=self;
//    self.tabView.scrollEnabled=NO;
//    self.tabView.showsVerticalScrollIndicator = NO;
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scrollview addSubview:self.tabView];
    
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
    [_scrollview addSubview:self.webView];
    //设置UIWebView 有下拉操作
    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉执行对应的操作
        _scrollview.contentSize=CGSizeMake(0, ScreenHeight);
        self.scrollview.contentOffset = CGPointMake(0, -20);
        //结束加载
        [self.webView.scrollView.mj_header endRefreshing];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53*WidthScale;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIView *left=[[UIView alloc]init];
    left.backgroundColor=Color(225, 225, 225);
    [cell.contentView addSubview:left];
    left.sd_layout.leftSpaceToView(cell.contentView,0).topSpaceToView(cell.contentView,26*WidthScale).widthIs(270*WidthScale).heightIs(1);
    UIView *right=[[UIView alloc]init];
    right.backgroundColor=Color(225, 225, 225);
    [cell.contentView addSubview:right];
    right.sd_layout.rightSpaceToView(cell.contentView,0).topSpaceToView(cell.contentView,26*WidthScale).widthIs(270*WidthScale).heightIs(1);
    UILabel *label=[[UILabel alloc]init];
    label.textColor=Color(225, 225, 225);
    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment=NSTextAlignmentCenter;
    label.text=@"继续拖动查看详情";
    [cell.contentView addSubview:label];
    label.sd_layout.leftSpaceToView(left,0).rightSpaceToView(right,0).topSpaceToView(cell.contentView,0).heightIs(53*WidthScale);
    return cell;
}

#pragma mark---底部按钮点击触发---
-(void)share:(UIButton *)sender{
    NSLog(@"share");
    sender.selected=!sender.selected;
    self.shareLabel.textColor=self.shareLabel.textColor==[UIColor grayColor]?Color(0, 240, 200):[UIColor grayColor];
    NSLog(@"color%@",self.shareLabel.textColor);
}
-(void)love:(UIButton *)sender{
    NSLog(@"love");
    sender.selected=!sender.selected;
    self.loveLabel.textColor=self.loveLabel.textColor==[UIColor grayColor]?Color(0, 240, 200):[UIColor grayColor];
}
-(void)hot:(UIButton *)sender{
    NSLog(@"hot");
    sender.selected=!sender.selected;
    self.hotLabel.textColor=self.hotLabel.textColor==[UIColor grayColor]?Color(0, 240, 200):[UIColor grayColor];
}
#pragma mark---选择尺码颜色---
/**
 *  初始化弹出视图
 */
-(void)initChoseView
{
    
    
    //选择尺码颜色的视图
    choseView = [[ChoseView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:choseView];
    
    //尺码
    choseView.sizeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 0, choseView.frame.size.width, 50) andDatasource:sizearr :@"尺码"];
    choseView.sizeView.delegate = self;
    [choseView.mainscrollview addSubview:choseView.sizeView];
    choseView.sizeView.frame = CGRectMake(0, 0, choseView.frame.size.width, choseView.sizeView.height);
    //颜色分类
    choseView.colorView = [[TypeView alloc] initWithFrame:CGRectMake(0, choseView.sizeView.frame.size.height, choseView.frame.size.width, 50) andDatasource:colorarr :@"颜色分类"];
    choseView.colorView.delegate = self;
    [choseView.mainscrollview addSubview:choseView.colorView];
    choseView.colorView.frame = CGRectMake(0, choseView.sizeView.frame.size.height, choseView.frame.size.width, choseView.colorView.height);
    //购买数量
    /*
     choseView.countView.frame = CGRectMake(0, choseView.colorView.frame.size.height+choseView.colorView.frame.origin.y, choseView.frame.size.width, 50);
     choseView.mainscrollview.contentSize = CGSizeMake(self.view.frame.size.width, choseView.countView.frame.size.height+choseView.countView.frame.origin.y);
     */
    choseView.lb_price.text = @"¥100";
    choseView.lb_stock.text = @"库存100000件";
    choseView.lb_detail.text = @"请选择 尺码 颜色分类";
    [choseView.bt_cancle addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [choseView.bt_sure addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [choseView.alphaiView addGestureRecognizer:tap];
    //点击图片放大图片
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
    choseView.img.userInteractionEnabled = YES;
    [choseView.img addGestureRecognizer:tap1];
}
/**
 *  此处嵌入浏览图片代码
 */
-(void)showBigImage:(UITapGestureRecognizer *)tap
{
    NSLog(@"放大图片");
}
/**
 *  点击按钮弹出
 */
-(void)btnselete
{
    
    [UIView animateWithDuration: 0.35 animations: ^{
        choseView.center = self.view.center;
        choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion: nil];
    
    
}
/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss
{
    [UIView animateWithDuration: 0.35 animations: ^{
        choseView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    } completion: nil];
    
}
#pragma mark-typedelegete
-(void)btnindex:(int)tag
{
    //通过seletIndex是否>=0来判断尺码和颜色是否被选择，－1则是未选择状态
    if (choseView.sizeView.seletIndex >=0&&choseView.colorView.seletIndex >=0) {
        //尺码和颜色都选择的时候
        NSString *size =[sizearr objectAtIndex:choseView.sizeView.seletIndex];
        NSString *color =[colorarr objectAtIndex:choseView.colorView.seletIndex];
        choseView.lb_stock.text = [NSString stringWithFormat:@"库存%@件",[[stockarr objectForKey: size] objectForKey:color]];
        choseView.lb_detail.text = [NSString stringWithFormat:@"已选 \"%@\" \"%@\"",size,color];
        choseView.stock =[[[stockarr objectForKey: size] objectForKey:color] intValue];
        
        [self reloadTypeBtn:[stockarr objectForKey:size] :colorarr :choseView.colorView];
        [self reloadTypeBtn:[stockarr objectForKey:color] :sizearr :choseView.sizeView];
        NSLog(@"尺码%d  颜色%d",choseView.sizeView.seletIndex,choseView.colorView.seletIndex);
        choseView.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",choseView.colorView.seletIndex+1]];
    }else if (choseView.sizeView.seletIndex ==-1&&choseView.colorView.seletIndex == -1)
    {
        //尺码和颜色都没选的时候
        choseView.lb_price.text = @"¥100-185";
        choseView.lb_stock.text = @"库存100000件";
        choseView.lb_detail.text = @"请选择 尺码 颜色分类";
        choseView.stock = 100000;
        //全部恢复可点击状态
        [self resumeBtn:colorarr :choseView.colorView];
        [self resumeBtn:sizearr :choseView.sizeView];
        
    }else if (choseView.sizeView.seletIndex ==-1&&choseView.colorView.seletIndex >= 0)
    {
        //只选了颜色
        NSString *color =[colorarr objectAtIndex:choseView.colorView.seletIndex];
        //根据所选颜色 取出该颜色对应所有尺码的库存字典
        NSDictionary *dic = [stockarr objectForKey:color];
        [self reloadTypeBtn:dic :sizearr :choseView.sizeView];
        [self resumeBtn:colorarr :choseView.colorView];
        choseView.lb_stock.text = @"库存100000件";
        choseView.lb_detail.text = @"请选择 尺码";
        choseView.stock = 100000;
        
        choseView.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",choseView.colorView.seletIndex+1]];
    }else if (choseView.sizeView.seletIndex >= 0&&choseView.colorView.seletIndex == -1)
    {
        //只选了尺码
        NSString *size =[sizearr objectAtIndex:choseView.sizeView.seletIndex];
        //根据所选尺码 取出该尺码对应所有颜色的库存字典
        NSDictionary *dic = [stockarr objectForKey:size];
        [self resumeBtn:sizearr :choseView.sizeView];
        [self reloadTypeBtn:dic :colorarr :choseView.colorView];
        choseView.lb_stock.text = @"库存100000件";
        choseView.lb_detail.text = @"请选择 颜色分类";
        choseView.stock = 100000;
        
        //        for (int i = 0; i<colorarr.count; i++) {
        //            int count = [[dic objectForKey:[colorarr objectAtIndex:i]] intValue];
        //            //遍历颜色字典 库存为零则改尺码按钮不能点击
        //            if (count == 0) {
        //                UIButton *btn =(UIButton *) [choseView.colorView viewWithTag:100+i];
        //                btn.enabled = NO;
        //            }
        //        }
        
    }
}
//恢复按钮的原始状态
-(void)resumeBtn:(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i< arr.count; i++) {
        UIButton *btn =(UIButton *) [view viewWithTag:100+i];
        btn.enabled = YES;
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:Color(0, 240, 200) forState:UIControlStateSelected];
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor whiteColor]];
            btn.layer.borderColor = Color(0, 240, 200).CGColor;
        }
    }
}
//根据所选的尺码或者颜色对应库存量 确定哪些按钮不可选
-(void)reloadTypeBtn:(NSDictionary *)dic :(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i<arr.count; i++) {
        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[view viewWithTag:100+i];
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        //库存为零 不可点击
        if (count == 0) {
            btn.enabled = NO;
            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
//            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        }else
        {
            btn.enabled = YES;
            [btn setTitleColor:[UIColor blackColor] forState:0];
            
        }
        //根据seletIndex 确定用户当前点了那个按钮
        if (view.seletIndex == i) {
            btn.selected = YES;
//            [btn setBackgroundColor:[UIColor redColor]];
        }else{
            btn.selected = NO;
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        }
    }
}



#pragma mark---返回---
//返回
-(void)backItemClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}





#pragma mark---导航栏隐藏和恢复---
//tabBar隐藏和恢复
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBar.hidden=YES;
    //    self.navigationController.navigationBar.translucent = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
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
@end
