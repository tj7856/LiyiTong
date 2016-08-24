//
//  giftListTableViewCell.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/16.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "giftListTableViewCell.h"
#import <SDAutoLayout.h>
@implementation giftListTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=Color(238, 238, 238);
        UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0, 16*WidthScale, ScreenWidth, 420*WidthScale)];
        backview.tag=290;
        backview.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:backview];
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, 80*WidthScale, ScreenWidth, 1)];
        line1.backgroundColor=Color(221, 221, 221);
        [backview addSubview:line1];
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(20*WidthScale, 319*WidthScale, ScreenWidth-40*WidthScale, 1)];
        line2.tag=291;
        line2.backgroundColor=Color(221, 221, 221);
        [backview addSubview:line2];
        
        UIView *bottomingView=[[UIView alloc]init];
        bottomingView.backgroundColor=[UIColor colorWithWhite:0.986 alpha:1.000];
        [backview addSubview:bottomingView];
        bottomingView.sd_layout.leftSpaceToView(backview,0).topSpaceToView(line1,0).rightSpaceToView(backview,0).bottomSpaceToView(line2,0);
        
        self.orderNum=[[UILabel alloc]init];
        self.orderNum.textColor=[UIColor blackColor];
        self.orderNum.textAlignment=NSTextAlignmentLeft;
        [backview addSubview:self.orderNum];
        self.orderNum.sd_layout.leftSpaceToView(backview,8).bottomSpaceToView(line1,0).widthIs(ScreenWidth/2).heightIs(80*WidthScale);
        
        self.orderStatus=[[UILabel alloc]init];
        self.orderStatus.textColor=[UIColor blackColor];
        self.orderStatus.textAlignment=NSTextAlignmentRight;
        [backview addSubview:self.orderStatus];
        self.orderStatus.sd_layout.rightSpaceToView(backview,64*WidthScale).bottomSpaceToView(line1,0).widthIs(100).heightIs(80*WidthScale);
        
        self.deleteBtn=[[UIButton alloc]init];
        [self.deleteBtn setImage:[UIImage imageNamed:@"lajitong_03"] forState:UIControlStateNormal];
        [backview addSubview:self.deleteBtn];
        self.deleteBtn.sd_layout.rightSpaceToView(backview,15*WidthScale).topSpaceToView(backview,15*WidthScale).widthIs(50*WidthScale).heightIs(50*WidthScale);
        
        self.orderImage=[[UIImageView alloc]init];
        [backview addSubview:self.orderImage];
        self.orderImage.sd_layout.leftSpaceToView(backview,8).topSpaceToView(line1,15*WidthScale).widthIs(200*WidthScale).heightIs(200*WidthScale);
        
        self.title1=[[UILabel alloc]init];
        self.title1.textColor=Color(68, 68, 68);
        [backview addSubview:self.title1];
        self.title1.sd_layout.leftSpaceToView(self.orderImage,46*WidthScale).topEqualToView(self.orderImage).rightEqualToView(line2).autoHeightRatio(0);
        
        self.title2=[[UILabel alloc]init];
        self.title2.text=@"规格参数";
        self.title2.font=[UIFont systemFontOfSize:16];
        self.title2.textColor=Color(204, 204, 204);
        self.title2.textAlignment=NSTextAlignmentLeft;
        [backview addSubview:self.title2];
        self.title2.sd_layout.bottomSpaceToView(line2,70*WidthScale).leftEqualToView(self.title1).widthIs(80).heightIs(20);
        
        self.priceWithNum=[[UILabel alloc]init];
        self.priceWithNum.textAlignment=NSTextAlignmentRight;
        [backview addSubview:self.priceWithNum];
        self.priceWithNum.sd_layout.rightEqualToView(self.title1).bottomEqualToView(self.title2).widthIs(120).heightIs(20);
        
        self.priceEnd=[[UILabel alloc]init];
        self.priceEnd.textAlignment=NSTextAlignmentRight;
        [backview addSubview:self.priceEnd];
        self.priceEnd.sd_layout.rightEqualToView(self.priceWithNum).bottomSpaceToView(line2,5).widthIs(200).heightIs(20);
        
        self.xiangqing=[[UIButton alloc]init];
        [self.xiangqing setBackgroundColor:[UIColor clearColor]];
        [backview addSubview:self.xiangqing];
        self.xiangqing.sd_layout.leftSpaceToView(self.orderImage,0).topSpaceToView(line1,0).rightSpaceToView(backview,0).bottomSpaceToView(line2,0);
        
        self.button1=[[UIButton alloc]init];
        self.button1.layer.borderWidth=1;
        self.button1.layer.borderColor=Color(221, 221, 221).CGColor;
        [self.button1 setTitleColor:Color(68, 68, 68) forState:UIControlStateNormal];
        [backview addSubview:self.button1];
        
        self.button2=[[UIButton alloc]init];
        [self.button2 setBackgroundColor:Color(0, 239, 200)];
        [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backview addSubview:self.button2];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
