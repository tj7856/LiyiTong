//
//  TOPTableViewCell.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/3.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "TOPTableViewCell.h"

@implementation TOPTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=Color(238, 238, 238);
        [self view1];
        
        [self view3];
    }
    return self;
}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//}

-(void)setHotIndex:(float)hotIndex
{
    _hotIndex = hotIndex;
    [self view2];
}

//-(void)setReason:(UILabel *)reason{
//    _reason=reason;
//}
-(void)view1{
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 98*WidthScale)];
    backView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:backView];
    UIImageView *theTopImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20*WidthScale, 180*WidthScale, 70*WidthScale)];
    theTopImage.image=[UIImage imageNamed:@"3332_02"];
    [backView addSubview:theTopImage];
    self.TopNum=[[UILabel alloc]initWithFrame:CGRectMake(30*WidthScale, 6*WidthScale, 100*WidthScale, 70*WidthScale)];
    self.TopNum.textColor=[UIColor whiteColor];
    self.TopNum.adjustsFontSizeToFitWidth=YES;
    [theTopImage addSubview:self.TopNum];
    self.view1Title=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(theTopImage.frame)+20*WidthScale, 40*WidthScale, 435*WidthScale, 50*WidthScale)];
    self.view1Title.adjustsFontSizeToFitWidth=YES;
    [backView addSubview:self.view1Title];
}
-(void)view2{
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 100*WidthScale, ScreenWidth, 78*WidthScale)];
    backView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:backView];
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(15*WidthScale, 26*WidthScale, 4*WidthScale, 38*WidthScale)];
    leftView.backgroundColor=Color(11, 230, 196);
    [backView addSubview:leftView];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame)+15*WidthScale, CGRectGetMinY(leftView.frame), 165*WidthScale, CGRectGetHeight(leftView.frame))];
    label.text=@"热门指数 :";
    label.adjustsFontSizeToFitWidth=YES;
    [backView addSubview:label];
    NSLog(@"___%0.2f",_hotIndex);
    float aaa=_hotIndex*10;
    int integer=(int)aaa%10;
    NSLog(@"inter%d",integer);
    if (integer==0) {
        for (int i=0; i<_hotIndex; i++) {
            UIImageView *xing=[[UIImageView alloc]initWithFrame:CGRectMake(210*WidthScale+40*i*WidthScale+2*i, 10, 40*WidthScale, 40*WidthScale)];
            xing.image=[UIImage imageNamed:@"12_07"];
            [backView addSubview:xing];
        }
    } else {
        int full=(int)_hotIndex/1;
        NSLog(@"full%d",full);
        for (int i=0; i<full+1; i++) {
            UIImageView *xing=[[UIImageView alloc]initWithFrame:CGRectMake(210*WidthScale+40*i*WidthScale+2*i, 10, 40*WidthScale, 40*WidthScale)];
            xing.image=[UIImage imageNamed:@"12_07"];
            if (i==full) {
                xing.image=[UIImage imageNamed:@"12_07副本"];
//                xing.image
                xing.contentMode=UIViewContentModeBottomLeft&UIViewContentModeScaleAspectFit;
            }
            [backView addSubview:xing];
        }
    }
}
-(void)view3{
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 180*WidthScale, ScreenWidth, 519*WidthScale)];
    backView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:backView];
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(15*WidthScale, 26*WidthScale, 4*WidthScale, 38*WidthScale)];
    leftView.backgroundColor=Color(11, 230, 196);
    [backView addSubview:leftView];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame)+15*WidthScale, CGRectGetMinY(leftView.frame), 165*WidthScale, CGRectGetHeight(leftView.frame))];
    label.text=@"热门理由 :";
    label.adjustsFontSizeToFitWidth=YES;
    [backView addSubview:label];
    self.reason=[[UILabel alloc]initWithFrame:CGRectMake(210*WidthScale, 20*WidthScale, ScreenWidth-210*WidthScale, 40)];
    self.reason.textColor=Color(119, 119, 119);
    self.reason.adjustsFontSizeToFitWidth=YES;
    self.reason.numberOfLines=2;
    [backView addSubview:self.reason];
    self.imageview=[[UIImageView alloc]initWithFrame:CGRectMake(16*WidthScale, 110*WidthScale, 715*WidthScale, 294*WidthScale)];
    [backView addSubview:self.imageview];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(16*WidthScale, CGRectGetMaxY(self.imageview.frame)+5, 100*WidthScale, 25)];
    label1.text=@"价格:￥";
    label1.adjustsFontSizeToFitWidth=YES;
    [backView addSubview:label1];
    self.price=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), CGRectGetMaxY(self.imageview.frame)+5, 100*WidthScale, 30)];
    self.price.textColor=Color(0, 243, 199);
    [backView addSubview:self.price];
    UILabel *sellNum=[[UILabel alloc]initWithFrame:CGRectMake(16*WidthScale, CGRectGetMaxY(self.imageview.frame)+55*WidthScale, 50, 30)];
    sellNum.text=@"销售量:";
    sellNum.adjustsFontSizeToFitWidth=YES;
    [backView addSubview:sellNum];
    self.personNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sellNum.frame), CGRectGetMaxY(self.imageview.frame)+55*WidthScale, 60, 30)];
    self.personNum.adjustsFontSizeToFitWidth=YES;
    [backView addSubview:self.personNum];
    self.topbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.topbutton.frame=CGRectMake(432*WidthScale, CGRectGetMaxY(self.imageview.frame)+22*WidthScale, 285*WidthScale, 80*WidthScale);
    
    [self.topbutton setTitle:@"查看详情" forState:UIControlStateNormal];
    [self.topbutton setTitleColor:Color(0, 243, 199) forState:UIControlStateNormal];
    [self.topbutton.layer setBorderWidth:1.0];
    [self.topbutton.layer setBorderColor:Color(0, 243, 199).CGColor];
    [backView addSubview:self.topbutton];
    [self.topbutton addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];

}
-(void)go:(UIButton *)sender{
    NSLog(@"%@",self.TopNum.text);
    
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
