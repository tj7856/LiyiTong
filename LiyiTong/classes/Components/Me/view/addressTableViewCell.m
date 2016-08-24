//
//  addressTableViewCell.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/20.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "addressTableViewCell.h"
#import <SDAutoLayout.h>
@implementation addressTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 178*WidthScale)];
        backView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:backView];
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=Color(221, 221, 221);
        [backView addSubview:line];
        line.sd_layout.leftSpaceToView(backView,0).rightSpaceToView(backView,0).bottomSpaceToView(backView,0).heightIs(1);
        self.chooseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"choose_off_03"] forState:UIControlStateNormal];
        [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"choose_on_03"] forState:UIControlStateSelected];
        [self.chooseBtn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:self.chooseBtn];
        self.chooseBtn.sd_layout.leftSpaceToView(backView,22*WidthScale).topSpaceToView(backView,70*WidthScale).widthIs(26*WidthScale).heightIs(26*WidthScale);
        
        self.name=[[UILabel alloc]initWithFrame:CGRectMake(78*WidthScale, 30*WidthScale, 60, 20)];
        self.name.textColor=[UIColor blackColor];
        self.name.textAlignment=NSTextAlignmentLeft;
        [backView addSubview:self.name];
        
        self.telePhone=[[UILabel alloc]init];
        
        self.telePhone.textColor=[UIColor blackColor];
        self.telePhone.textAlignment=NSTextAlignmentLeft;
        [backView addSubview:self.telePhone];
        self.telePhone.sd_layout.leftSpaceToView(self.name,5).topSpaceToView(backView,30*WidthScale).widthIs(120).heightIs(20);
        
        self.address=[[UILabel alloc]init];
        
        self.address.textColor=[UIColor blackColor];
        self.address.textAlignment=NSTextAlignmentLeft;
        [backView addSubview:self.address];
        self.address.sd_layout.leftEqualToView(self.name).topSpaceToView(self.name,10).widthIs(300).heightIs(20);
        
        self.changeBtn=[[UIButton alloc]init];
        [self.changeBtn setTitle:@"修改" forState:UIControlStateNormal];
        [self.changeBtn setTitleColor:Color(0, 239, 200) forState:UIControlStateNormal];
        [backView addSubview:self.changeBtn];
        self.changeBtn.sd_layout.rightSpaceToView(backView,8).topSpaceToView(backView,70*WidthScale).widthIs(50).heightIs(20);
    }
    return self;
}
-(void)change:(UIButton *)sender{
    sender.selected=!sender.selected;
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
