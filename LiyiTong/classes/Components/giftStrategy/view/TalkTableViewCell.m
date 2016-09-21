//
//  TalkTableViewCell.m
//  LiyiTong
//
//  Created by zhangtijie on 16/9/10.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "TalkTableViewCell.h"
#import <SDAutoLayout.h>
@implementation TalkTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    UIView *content = [[UIView alloc]init];
//    content.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:content];
    content.sd_layout.heightIs(250).widthIs(360).centerXEqualToView(self.contentView).topSpaceToView(self.contentView,0);
    
    
    UIView *top = [[UIView alloc]init];
    top.backgroundColor =[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];;
    [content addSubview:top];
    top.sd_layout.heightIs(1).widthRatioToView(content,1.0f).topSpaceToView(content,4).leftSpaceToView(content,0);
    
    
    UIView *leftLine = [[UIView alloc]init];
    leftLine.backgroundColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];;
    [content addSubview:leftLine];
    leftLine.sd_layout.widthIs(1).topSpaceToView(content,4).leftSpaceToView(content,0).bottomSpaceToView(content,6);
    
    
    UIView *rightLine = [[UIView alloc]init];
    rightLine.backgroundColor =[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];;
    [content addSubview:rightLine];
    rightLine.sd_layout.widthIs(1).topSpaceToView(content,4).rightSpaceToView(content,0).bottomSpaceToView(content,6);
    
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];;
    [content addSubview:bottomLine];
    bottomLine.sd_layout.heightIs(1).bottomSpaceToView(content,6).leftSpaceToView(content,0).rightSpaceToView(content,0);
    
    
    UIButton *zan = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    zan.enabled = NO;
    [content addSubview:zan];
    [zan setBackgroundImage:[UIImage imageNamed:@"describe_btn_03"] forState:(UIControlStateNormal)];
    [zan setImage:[UIImage imageNamed:@"heart_07"] forState:(UIControlStateNormal)];
    [zan setImage:[UIImage imageNamed:@"heart_active"] forState:(UIControlStateSelected)];
    [zan setTitle:@"1234" forState:(UIControlStateDisabled)];
    [zan addTarget:self action:@selector(zanClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    zan.sd_layout.leftSpaceToView(content,0).topSpaceToView(content,0).widthIs(68).heightIs(23);
    
    UILabel *title = [[UILabel alloc]init];
    
    
    title.font =[UIFont systemFontOfSize:10];
    title.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
    title.text =@"大家都在聊";
    [content addSubview:title];
    title.sd_layout.widthIs(50).autoHeightRatio(0).topSpaceToView(top,18).centerXEqualToView(content);
    
    
    UIView *l=[[UIView alloc]init];
    [content addSubview:l];
    l.backgroundColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];

    l.sd_layout.widthIs(16).heightIs(1).rightSpaceToView(title,4).centerYEqualToView(title);
    
    UIView *r=[[UIView alloc]init];
    [content addSubview:r];
    r.backgroundColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
    r.sd_layout.widthIs(16).heightIs(1).leftSpaceToView(title,4).centerYEqualToView(title);
    
    
    UILabel *biaoti = [[UILabel alloc]init];
    [content addSubview:biaoti];
    biaoti.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1];
    biaoti.font = [UIFont systemFontOfSize:18];
    biaoti.numberOfLines = 0;
    biaoti.text =@"养动物注意事项";
    
    biaoti.sd_layout.leftSpaceToView(content,18).topSpaceToView(title,18).autoHeightRatio(0).widthIs(150);
    
    
    UILabel *time = [[UILabel alloc]init];
    [content addSubview:time];
    time.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1];
    time.font = [UIFont systemFontOfSize:11];
    
    time.text =@"2016.08.22";
    
    time.sd_layout.leftEqualToView(biaoti).topSpaceToView(biaoti,9).widthIs(70).autoHeightRatio(0);
;
    
    
    UIImageView * img = [[UIImageView alloc]init];
    [content addSubview:img];
    img.image = [UIImage imageNamed:@"mao"];
    img.sd_layout.widthIs(105).heightIs(105).rightSpaceToView(content,15).topEqualToView(biaoti);
    
    UILabel *zhengwen = [[UILabel alloc]init];
    [content addSubview:zhengwen];
    zhengwen.textColor = [UIColor colorWithRed:161/255.0 green:161/255.0 blue:161/255.0 alpha:1];
    zhengwen.font = [UIFont systemFontOfSize:12];
    zhengwen.numberOfLines = 0;
    zhengwen.text =@"是你好不好办健身卡班开始补课班上课上班开始就开始不上课不上课不上课开始上课可实际上包括设备开始";
    
    zhengwen.sd_layout.leftEqualToView(biaoti).rightSpaceToView(img,22).heightIs(55).topSpaceToView(time,18);
    
    UIView *fengeLine = [[UIView alloc]init];
    fengeLine.backgroundColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];;
    [content addSubview:fengeLine];
    fengeLine.sd_layout.heightIs(1).widthIs(65).leftEqualToView(biaoti).topSpaceToView(zhengwen,15);
    
    UIImageView *icon = [[UIImageView alloc]init];
    icon.image = [UIImage imageNamed:@"tou_03"];
    [content addSubview:icon];
    
    icon.sd_layout.widthIs(22).heightIs(22).leftEqualToView(biaoti).topSpaceToView(fengeLine,7);
    UILabel *name = [[UILabel alloc]init];
    name.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    name.font = [UIFont systemFontOfSize:11];
    name.numberOfLines = 0;
    name.text =@"小发跋扈";
    [content addSubview:name];
    name.sd_layout.centerYEqualToView(icon).autoHeightRatio(0).leftSpaceToView(icon,4);
    
    
    
    
    
    
    
}

-(void)zanClick
{
    if(self.zanBlock)
    {
        _zanBlock();
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
