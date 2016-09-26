//
//  FormTopicTableViewCell.m
//  LiyiTong
//
//  Created by zhangtijie on 16/9/21.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "FormTopicTableViewCell.h"
#import "UIImageView+WebCache.h"
#import <SDAutoLayout.h>

@implementation FormTopicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
       self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setup
{
    UIImageView *image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"b2_14"];
    [self.contentView addSubview:image];
    image.sd_layout.widthIs(45).heightIs(32).topSpaceToView(self.contentView,10).leftSpaceToView(self.contentView,10);
    UILabel *title = [[UILabel alloc]init];
    title.text = @"来自话题： 中秋吃什么好";
    title.font = [UIFont systemFontOfSize:14];
    title.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.contentView addSubview:title];
    title.sd_layout.topSpaceToView(self.contentView,10).leftSpaceToView(image,10).widthIs(210).autoHeightRatio(0);
    
    UILabel *time = [[UILabel alloc]init];
    time.text = @"2016-9-7";
    time.font = [UIFont systemFontOfSize:10];
    time.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.contentView addSubview:time];
    time.sd_layout.topSpaceToView(title,10).leftSpaceToView(image,10).widthIs(70).autoHeightRatio(0);
    
    UIButton *detail =[UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.contentView addSubview:detail];
    detail.backgroundColor = [UIColor whiteColor];
    [detail setTitle:@"查看详情" forState:(UIControlStateNormal)];
    [detail setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    detail.titleLabel.adjustsFontSizeToFitWidth =YES;
    detail.layer.cornerRadius =2;
    detail.layer.masksToBounds =YES;
    detail.layer.borderWidth =1;
    detail.layer.borderColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1].CGColor;
    detail.sd_layout.widthIs(62).heightIs(25).rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,13);
    UIView *bottom = [[UIView alloc]init];
    bottom.backgroundColor =[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [self.contentView addSubview:bottom];
    bottom.sd_layout.widthRatioToView(self.contentView,1.0f).bottomSpaceToView(self.contentView,0).leftSpaceToView(self.contentView,0).heightIs(6);
    
    
    
}
@end
