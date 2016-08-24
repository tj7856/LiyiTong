//
//  ConnectionTableViewCell.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/10.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "ConnectionTableViewCell.h"
#import <SDAutoLayout.h>
@implementation ConnectionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userHeader=[[UIImageView alloc]init];
        [self.contentView addSubview:self.userHeader];
        self.userHeader.sd_layout.leftSpaceToView(self.contentView,20*WidthScale).topSpaceToView(self.contentView,14*WidthScale).widthIs(120*WidthScale).heightIs(120*WidthScale);
        self.userHeader.layer.cornerRadius=60*WidthScale;
        self.userHeader.clipsToBounds=YES;
        
        self.userName=[[UILabel alloc]init];
        self.userName.frame=CGRectMake(176*WidthScale, 10, 40, 20);
        self.userName.font=[UIFont boldSystemFontOfSize:14];
        self.userName.textColor=[UIColor blackColor];
//        self.userName.backgroundColor=[UIColor redColor];
        self.userName.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:self.userName];
        
        self.see=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.see setTitle:@"关注" forState:UIControlStateNormal];
        self.see.titleLabel.font=[UIFont systemFontOfSize:12];
        [self.see setTitleColor:Color(0, 240, 200) forState:UIControlStateNormal];
        [self.see setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.see setBackgroundColor:[UIColor whiteColor]];
        self.see.layer.borderWidth=1;
        self.see.layer.borderColor=Color(0, 240, 200).CGColor;
        self.see.layer.cornerRadius=5;
        [self.contentView addSubview:self.see];
        self.see.sd_layout.leftSpaceToView(self.userName,5).topEqualToView(self.userName).bottomEqualToView(self.userName).widthIs(90*WidthScale);
        [self.see addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
        
        self.jieri1=[[UILabel alloc]init];
        self.jieri1.frame=CGRectMake(CGRectGetMinX(self.userName.frame), CGRectGetMaxY(self.userName.frame), 40, 38*WidthScale);
//        self.jieri1.backgroundColor=[UIColor cyanColor];
        [self.contentView addSubview:self.jieri1];
        
        self.jieri2=[[UILabel alloc]init];
        self.jieri2.frame=CGRectMake(CGRectGetMinX(self.userName.frame), CGRectGetMaxY(self.jieri1.frame), 40, 38*WidthScale);
//        self.jieri2.backgroundColor=[UIColor cyanColor];
        [self.contentView addSubview:self.jieri2];
        
        
    }
    return self;
}
-(void)changeColor:(UIButton *)sender{
    sender.selected=!sender.selected;
    sender.backgroundColor=sender.backgroundColor==[UIColor whiteColor]?Color(0, 240, 200):[UIColor whiteColor];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
