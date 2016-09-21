//
//  InvitationDetailViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/9/14.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "InvitationDetailViewController.h"
#import <SDAutoLayout.h>

#import "YZInputView.h"
#import "PostsContent.h"
#import "UIImageView+WebCache.h"
#import "InvitationContentTableViewCell.h"

@interface InvitationDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UIView *bottomV;
@property(nonatomic,weak)UIView *InvitationView;
@property(nonatomic,weak)UIScrollView *scrollV;
@property(nonatomic,weak)UITableView *tabview;
@property(nonatomic,weak)YZInputView *input;
@property(nonatomic,weak)UIView *contentView;

@property(nonatomic,strong)NSArray *items;



@end

@implementation InvitationDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"中秋吃月饼";
    [self layout];
}
-(NSArray *)items
{
    if (!_items) {
        NSMutableArray *arry = [NSMutableArray array];
        PostsContent *t1 = [[PostsContent alloc]init];
        t1.content = @"时间拨打开吧不舒服";
        t1.type = kContentTypeString;
        t1.Sort = 0;
        [arry addObject:t1];
        PostsContent *t2 = [[PostsContent alloc]init];
        t2.content = @"时间jso吧不舒服";
        t2.type = kContentTypeTitle;
        t2.Sort = 1;
        [arry addObject:t2];
        PostsContent *t3 = [[PostsContent alloc]init];
        t3.content = @"http://obdkaldla.bkt.clouddn.com/1470836918144.png";
        t3.type = kContentTypeImage;
        t3.Sort = 2;
        [arry addObject:t3];
        PostsContent *t4 = [[PostsContent alloc]init];
        t4.content = @"http://obdkaldla.bkt.clouddn.com/1470837254643.jpg";
        t4.type = kContentTypeImage;
        t4.Sort = 3;
        [arry addObject:t4];
        PostsContent *t5 = [[PostsContent alloc]init];
        t5.content = @"http://obdkaldla.bkt.clouddn.com/bbsTopic/00ef6b91ea694702955bd0336d8aa984.jpg";
        t5.type = kContentTypeImage;
        t5.Sort = 4;
        [arry addObject:t5];
        PostsContent *t6 = [[PostsContent alloc]init];
        t6.content = @"时间拨打开吧不舒服kjfakjskfaskfaksfhkaskkahfkashfkjafkakfkajsfhkashfkahsfkahsfkhaskfhaksfhkajsfhkashfkashfkashfkaf";
        t6.type = kContentTypeString;
        t6.Sort = 5;
        [arry addObject:t6];
        PostsContent *t7 = [[PostsContent alloc]init];
        t7.content = @"时间拨打开吧不舒服kjfakjskfaskfaksfhkaskkahfkashfkjafkakfkajsfhkashfkahsfkahsfkhaskfhaksfhkajsfhkashfkashfkashfkaf";
        t7.type = kContentTypeGift;
        t7.Sort = 6;
        [arry addObject:t7];

        _items = [NSArray arrayWithArray:arry];
        
    }
    return _items;
}

-(void)layout
{
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:238/255.0 alpha:1];
    UIView *InvitationView = [[UIView alloc]init];
    InvitationView.backgroundColor = [UIColor whiteColor];
  
    self.InvitationView = InvitationView;
    [self.view addSubview:InvitationView];
    
    InvitationView.sd_layout.widthRatioToView(self.view,1.0f).topSpaceToView(self.view,70).bottomEqualToView(self.view).leftSpaceToView(self.view,0);
    
    UIView *userView = [[UIView alloc]init];

    [InvitationView addSubview:userView];
    userView.sd_layout.widthRatioToView(InvitationView,1.0f).heightIs(60).leftSpaceToView(InvitationView,0).topSpaceToView(InvitationView,0);
    UIImageView *userIcon = [[UIImageView alloc]init];
    userIcon.image = [UIImage imageNamed:@"tou_03"];
    userIcon.layer.cornerRadius =22;
    userIcon.layer.masksToBounds =YES;
    [userView addSubview:userIcon];
    userIcon.sd_layout.widthIs(44).heightIs(44).centerYEqualToView(userView).leftSpaceToView(userView,9);
    UILabel *userName = [[UILabel alloc]init];
    userName.text =@"竖的是的";
    userName.font = [UIFont systemFontOfSize:16];
    userName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [userView addSubview:userName];
    userName.sd_layout.leftSpaceToView(userIcon,11).topSpaceToView(userView,16).widthIs(200).autoHeightRatio(0);
    
    UIButton *guanzhu = [UIButton buttonWithType:(UIButtonTypeCustom)];
    guanzhu.enabled =YES;
    [guanzhu setImage:[UIImage imageNamed:@"addguanzhu_btn_03"] forState:(UIControlStateNormal)];
    [guanzhu setImage:[UIImage imageNamed:@"yigunazhu_btn_03"] forState:(UIControlStateSelected)];
    [guanzhu addTarget:self action:@selector(guanzhu:) forControlEvents:UIControlEventTouchUpInside];
    [userView addSubview:guanzhu];
    guanzhu.sd_layout.widthIs(62).heightIs(25).topEqualToView(userName).rightSpaceToView(userView,9);
    
    UIView *bottomView = [[UIView alloc]init];
    self.bottomV = bottomView;
    [InvitationView addSubview:bottomView];
    bottomView.sd_layout.widthRatioToView(InvitationView,1.0f).leftSpaceToView(InvitationView,0).bottomSpaceToView(InvitationView,0).heightIs(49);
//    bottomView.sd_layout.bottomSpaceToView(InvitationView,258);
    
    UIView *BtopLine = [[UIView alloc]init];
    BtopLine.backgroundColor = [UIColor colorWithRed:235/255.0 green:237/255.0 blue:238/255.0 alpha:1];
    [bottomView addSubview:BtopLine];
    BtopLine.sd_layout.widthRatioToView(bottomView,1.0f).leftSpaceToView(bottomView,0).heightIs(1).topSpaceToView(bottomView,0);
    
    UIImageView *bi = [[UIImageView alloc]init];
    bi.image=[UIImage imageNamed:@"pencil_30"];
    [bottomView addSubview:bi];
    bi.sd_layout.widthIs(17).heightIs(17).leftSpaceToView(bottomView,38).centerYEqualToView(bottomView);
    
    UIButton *zhuanfa = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [zhuanfa setImage:[UIImage imageNamed:@"share_22"] forState:(UIControlStateNormal)];
    
    [bottomView addSubview:zhuanfa];
    zhuanfa.sd_layout.rightSpaceToView(bottomView,0).centerYEqualToView(bottomView).widthIs(64).heightRatioToView(bottomView,1.0f);
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = [UIColor colorWithRed:235/255.0 green:237/255.0 blue:238/255.0 alpha:1];
    [bottomView addSubview:line3];
    line3.sd_layout.widthIs(1).centerYEqualToView(bottomView).rightSpaceToView(zhuanfa,0).heightIs(43);
    
    UIButton *zan = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [zan setImage:[UIImage imageNamed:@"heart_active_24"] forState:(UIControlStateSelected)];
    [zan setImage:[UIImage imageNamed:@"heart"] forState:(UIControlStateNormal)];
    
    [bottomView addSubview:zan];
    zan.sd_layout.rightSpaceToView(line3,0).centerYEqualToView(bottomView).widthIs(64).heightRatioToView(bottomView,1.0f);
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor colorWithRed:235/255.0 green:237/255.0 blue:238/255.0 alpha:1];
    [bottomView addSubview:line2];
    line2.sd_layout.widthIs(1).centerYEqualToView(bottomView).rightSpaceToView(zan,0).heightIs(43);
    
    UIButton *fayan = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [fayan setImage:[UIImage imageNamed:@"message_22"] forState:(UIControlStateNormal)];
    
    [bottomView addSubview:fayan];
    fayan.sd_layout.rightSpaceToView(line2,0).centerYEqualToView(bottomView).widthIs(64).heightRatioToView(bottomView,1.0f);
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor colorWithRed:235/255.0 green:237/255.0 blue:238/255.0 alpha:1];
    [bottomView addSubview:line1];
    line1.sd_layout.widthIs(1).centerYEqualToView(bottomView).rightSpaceToView(fayan,0).heightIs(43);
    
    YZInputView *input = [[YZInputView alloc]init];
    self.input = input;
//    UITextField *input = [[UITextField alloc]init];
    input.layer.borderColor=[[UIColor whiteColor] CGColor];
  
    
//    input.placeholderColor = [UIColor colorWithRed:235/255.0 green:237/255.0 blue:238/255.0 alpha:1];
    [bottomView addSubview:input];
    input.sd_layout.leftSpaceToView(bi,0).rightSpaceToView(line1,0).topSpaceToView(bottomView,2).bottomSpaceToView(bottomView,2);
//    input.sd_layout.topSpaceToView(bottomView,0).bottomSpaceToView(bottomView,0);
    // 监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    input.placeholder = @"我来说两句";
    input.placeholderColor = [UIColor colorWithRed:235/255.0 green:237/255.0 blue:238/255.0 alpha:1];
    
    input.yz_textHeightChangeBlock = ^(NSString *text,CGFloat textHeight){
        // 文本框文字高度改变会自动执行这个【block】，可以在这【修改底部View的高度】
        // 设置底部条的高度 = 文字高度 + textView距离上下间距约束
        // 为什么添加10 ？（10 = 底部View距离上（5）底部View距离下（5）间距总和）
//        _bottomHCons.constant = textHeight + 10;
        bottomView.sd_layout.heightIs(textHeight + 10);
//        [self.bottomV updateLayout];  

    };
  
    // 设置文本框最大行数
    input.maxNumberOfLines = 4;
    
//    
//    UIScrollView *content = [[UIScrollView alloc]init];
//    self.scrollV =content;
    UITableView *content = [[UITableView alloc]init];
    content.delegate =self;
    content.dataSource =self;
    self.tabview = content;
    [InvitationView addSubview:content];
    content.sd_layout.topSpaceToView(userView,0).leftSpaceToView(InvitationView,6).rightSpaceToView(InvitationView,6).bottomSpaceToView(bottomView,0);
//    content.contentSize = CGSizeMake(ScreenWidth, 1000);
//    [self fillContent];
}





#pragma mark -uitabviewdelegate,uitabviewdataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InvitationContentTableViewCell* cell = [[InvitationContentTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    cell.items =self.items;
    [cell setGoButtonClickedOperation:^(PostsContent *item) {
        NSLog(@"go");
    }];
    [cell setZanButtonClickedOperation:^(PostsContent *item) {
        NSLog(@"zan");
    }];
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
//    id model = self.dataArray[indexPath.row];
    return [tableView cellHeightForIndexPath:indexPath model:self.items keyPath:@"items" cellClass:[InvitationContentTableViewCell class] contentViewWidth:[self cellContentViewWith]];
//  return [self.tabview cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width];
//    return 1000;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.input resignFirstResponder];
    self.input.placeholder = @"我来说两句";
    self.input.text = @"";
}



- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


-(void)guanzhu:(UIButton *)send
{
    send.selected = !send.selected;
}

// 键盘弹出会调用
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 获取键盘frame
    CGRect endFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 获取键盘弹出时长
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    // 修改底部视图距离底部的间距
    CGFloat f = endFrame.origin.y != screenH?endFrame.size.height:0;
//    self.bottomV.sd_layout.bottomSpaceToView(self.InvitationView,f).leftSpaceToView(self.InvitationView,0).widthRatioToView(self.InvitationView,1.0f).heightIs(49);
    self.bottomV.sd_layout.bottomSpaceToView(self.InvitationView,f);
    
//    NSLog(@"f=%f",f);
    // 约束动画
    [UIView animateWithDuration:duration animations:^{
//        [self.view layoutIfNeeded];
        [self.bottomV updateLayout];
    }];
}

-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
