//
//  CommentTableViewCell.m
//  LiyiTong
//
//  Created by zhangtijie on 16/9/22.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "Response.h"
#import "SubResponse.h"

#import "UIImageView+WebCache.h"
#import <SDAutoLayout.h>

@interface CommentTableViewCell()
@property(nonatomic,weak)UIView *layoutView;
@property(nonatomic,strong)NSMutableArray *LabelArry;

@end
@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(NSMutableArray *)LabelArry
{
    if (!_LabelArry) {
        _LabelArry = [NSMutableArray array];
        
    }
    return _LabelArry;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

+(instancetype)initinitWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexpath:(NSInteger )index
{
    CommentTableViewCell* cell = [[CommentTableViewCell alloc]initWithStyle:(style) reuseIdentifier:reuseIdentifier];
//    if (index == 0) {
//        UILabel *title = [[UILabel alloc]init];
//        title.text = @"最赞回应";
//        title.font = [UIFont systemFontOfSize:15];
//        title.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
//        [cell.contentView addSubview:title];
//        title.sd_layout.topSpaceToView(cell.contentView,12).leftSpaceToView(cell.contentView,10).widthIs(64).autoHeightRatio(0);
//        
//        UIView *zhanwei = [[UIView alloc]init];
//        [cell.contentView addSubview:zhanwei];
//        zhanwei.sd_layout.topSpaceToView(title,0).leftSpaceToView(cell.contentView,0).widthIs(100).heightIs(7);
//        cell.layoutView = zhanwei;
//        
//        
//    }
//    [cell setup];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

-(void)setup
{
//    self.layoutView = self.contentView;
    UIView *fenge = [[UIView alloc]init];
    fenge.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [self.contentView addSubview:fenge];
    fenge.sd_layout.widthRatioToView(self.contentView,1.0f).heightIs(1).leftSpaceToView(self.contentView,0).topSpaceToView(self.layoutView,0);
    
    UIImageView *userIcon = [[UIImageView alloc]init];
    userIcon.image = [UIImage imageNamed:@"tou_03"];
    userIcon.layer.cornerRadius =22;
    userIcon.layer.masksToBounds =YES;
    [self.contentView addSubview:userIcon];
    userIcon.sd_layout.widthIs(44).heightIs(44).topSpaceToView(fenge,12).leftSpaceToView(self.contentView,9);
    UILabel *userName = [[UILabel alloc]init];
    userName.text =self.Rep.name;
    userName.font = [UIFont systemFontOfSize:16];
    userName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.contentView addSubview:userName];
    userName.sd_layout.leftSpaceToView(userIcon,10).topSpaceToView(fenge,12).widthIs(200).autoHeightRatio(0);
    UILabel *time = [[UILabel alloc]init];
    time.text = @"2016-9-7";
    time.font = [UIFont systemFontOfSize:10];
    time.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.contentView addSubview:time];
    time.sd_layout.topSpaceToView(userName,10).leftSpaceToView(userIcon,10).widthIs(70).autoHeightRatio(0);
    
    UIButton *other = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [other setImage:[UIImage imageNamed:@"more"] forState:(UIControlStateNormal)];
    [other setImage:[UIImage imageNamed:@"more_active_13"] forState:(UIControlStateSelected)];
    [self.contentView addSubview:other];
    [other addTarget:self action:@selector(other:) forControlEvents:(UIControlEventTouchUpInside)];
    other.sd_layout.widthIs(16).heightIs(16).topSpaceToView(fenge,17).rightSpaceToView(self.contentView,10);
    
    UIButton *zan = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [zan setImage:[UIImage imageNamed:@"favout_11"] forState:(UIControlStateNormal)];
    [zan setImage:[UIImage imageNamed:@"favour_active_11"] forState:(UIControlStateSelected)];
    [zan setTitle:@"112" forState:(UIControlStateNormal)];
    [zan setTitleColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1] forState:(UIControlStateNormal)];
    [zan setTitleColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1] forState:(UIControlStateSelected)];
    zan.titleLabel.adjustsFontSizeToFitWidth = YES;
    [zan addTarget:self action:@selector(zan:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:zan];
 
    zan.sd_layout.widthIs(45).heightIs(16).topSpaceToView(fenge,17).rightSpaceToView(other,8);
    
    
    UILabel *comment = [[UILabel alloc]init];
    comment.font = [UIFont systemFontOfSize:14];
    comment.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    comment.text = self.Rep.comment;
    
    [self.LabelArry addObject:comment];
    [self.contentView addSubview:comment];
    
    comment.sd_layout.widthIs(289).leftEqualToView(time).topSpaceToView(time,12).autoHeightRatio(0);
    [self addTapGestureRecognizerForView:comment action:@selector(LabelCellTouchUpInside:)];
    comment.userInteractionEnabled = YES;
    self.layoutView = comment;
    
    

    
    
}

-(void)setRep:(Response *)Rep WithIndex:(NSInteger)index
{
    if (index == 0) {
        UILabel *title = [[UILabel alloc]init];
        title.text = @"最赞回应";
        title.font = [UIFont systemFontOfSize:15];
        title.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [self.contentView addSubview:title];
        title.sd_layout.topSpaceToView(self.contentView,12).leftSpaceToView(self.contentView,10).widthIs(64).autoHeightRatio(0);
        
        UIView *zhanwei = [[UIView alloc]init];
        [self.contentView addSubview:zhanwei];
        zhanwei.sd_layout.topSpaceToView(title,0).leftSpaceToView(self.contentView,0).widthIs(100).heightIs(7);
        self.layoutView = zhanwei;
        
        
    }
    else
    {
        self.layoutView = self.contentView;
    }
    self.Rep =Rep;

}

-(void)setRep:(Response *)Rep
{
    self.layoutView =self.contentView;
    _Rep = Rep;
    CGFloat juli;
        [self setup];

    for (SubResponse *resp in self.Rep.SubRep) {
        NSInteger index = [self.Rep.SubRep indexOfObject:resp];
        if (index ==0) {
             juli = 10.0;
        }
        else juli = 0;
        
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        label.text =[NSString stringWithFormat:@"%@回复%@：%@",resp.name,resp.Comment_Username,resp.comment];
        [self.contentView addSubview:label];
        [self.LabelArry addObject:label];
        label.sd_layout.widthIs(289).leftEqualToView(self.layoutView).topSpaceToView(self.layoutView,juli).autoHeightRatio(0);
        [self addTapGestureRecognizerForView:label action:@selector(LabelCellTouchUpInside:)];
        label.userInteractionEnabled = YES;
        self.layoutView = label;
    }
    
    [self setupAutoHeightWithBottomView:self.layoutView bottomMargin:10 ];
    
}

- (void)addTapGestureRecognizerForView:(UIView *)view action:(SEL)action
{
    if (view)
    {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
        tapGesture.cancelsTouchesInView = YES;
        [view addGestureRecognizer:tapGesture];
    }
}

/**
 *  列表点击时触发
 *
 *  @param gesture Tap Gesture Recognizer
 */
- (void)LabelCellTouchUpInside:(UITapGestureRecognizer *)gesture
{
    //判断点击区域
    
    UILabel *cell = (UILabel *)gesture.view;
    NSUInteger indexPath = [self.LabelArry indexOfObject:cell];
    
    if (_LabelClickedOperation) {
//        if (indexPath == 0) {
             _LabelClickedOperation(self.Rep,indexPath,self);
//        }
//        else
//        {
//            _LabelClickedOperation(self.Rep.SubRep[indexPath-1]);
//        }
       
    }
   
}

-(void)zan:(UIButton *)sender
{
  
    sender.selected =!sender.selected;
    if (sender.selected ==YES) {
        [sender setTitle:@"113" forState:(UIControlStateSelected)];
    }
    else
    {
        [sender setTitle:@"112" forState:(UIControlStateNormal)];

    }
    
}

-(void)other:(UIButton *)sender
{
    sender.selected =!sender.selected;
   
}


@end
