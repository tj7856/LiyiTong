//
//  giftTableViewCell.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/1.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "giftTableViewCell.h"

@implementation giftTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
//        self.backgroundColor=[UIColor redColor];
        self.backImage=[[UIImageView alloc]init];
        self.backImage.backgroundColor=[UIColor orangeColor];
        self.backImage.frame=CGRectMake(16*WidthScale, 14*WidthScale, ScreenWidth-32*WidthScale, 290*WidthScale);
        self.backImage.contentMode=UIViewContentModeScaleToFill;
        self.backImage.clipsToBounds=YES;
        [self.contentView addSubview:self.backImage];
        
        self.rightView=[[UIView alloc]initWithFrame:CGRectMake(self.backImage.size.width-145*WidthScale, 15*WidthScale, 134*WidthScale, 54*WidthScale)];
        self.rightView.backgroundColor=[UIColor blackColor];
        self.rightView.layer.cornerRadius=self.rightView.height/2;
        self.rightView.alpha=0.5;
        [self.backImage addSubview:self.rightView];
        
        self.loveLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.backImage.size.width-110*WidthScale, CGRectGetMinY(self.rightView.frame)+10*WidthScale, 40, 16)];
        self.loveLabel.textColor=[UIColor whiteColor];
        self.loveLabel.font=[UIFont systemFontOfSize:13];
        self.loveLabel.textAlignment=NSTextAlignmentCenter;
        //        self.loveLabel.backgroundColor=[UIColor blueColor];
        [self.backImage addSubview:self.loveLabel];
        
        self.loveButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.loveButton.frame=CGRectMake(self.backImage.size.width-145*WidthScale, 15*WidthScale, 134*WidthScale, 54*WidthScale);
        [self.loveButton setImage:[UIImage imageNamed:@"z_active"] forState:UIControlStateNormal];
        [self.loveButton setImage:[UIImage imageNamed:@"active"] forState:UIControlStateSelected];
        self.loveButton.imageEdgeInsets=UIEdgeInsetsMake(10*WidthScale, 10*WidthScale, 10*WidthScale, 90*WidthScale);
        [self.loveButton addTarget:self action:@selector(changeActive:) forControlEvents:UIControlEventTouchUpInside];
        [self.backImage addSubview:self.loveButton];
        
        
        self.captionLabel=[[UILabel alloc]initWithFrame:CGRectMake(22*WidthScale, CGRectGetMaxY(self.backImage.frame)-80*WidthScale, ScreenWidth, 20)];
        self.captionLabel.adjustsFontSizeToFitWidth=YES;
        self.captionLabel.textColor=[UIColor whiteColor];
//        self.captionLabel.backgroundColor=[UIColor orangeColor];
        [self.backImage addSubview:self.captionLabel];
        
        self.describeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.backImage.frame), ScreenWidth-10, 40)];
        self.describeLabel.font=[UIFont systemFontOfSize:13];
        self.describeLabel.textColor=Color(51, 51, 51);
        self.describeLabel.numberOfLines=2;
//        self.describeLabel.backgroundColor=[UIColor grayColor];
        [self.contentView addSubview:self.describeLabel];
        
        
        self.label1=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.describeLabel.frame), ScreenWidth/2, 20)];
        self.label1.font=[UIFont systemFontOfSize:13];
//        self.label1.textAlignment=NSTextAlignmentCenter;
        self.label1.textColor=Color(207, 207, 207);
//        self.label1.backgroundColor=[UIColor grayColor];
        [self.contentView addSubview:self.label1];
        
        UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 450*WidthScale-1, ScreenWidth, 1)];
        footView.backgroundColor=[UIColor colorWithWhite:0.839 alpha:1.000];
        [self.contentView addSubview:footView];
        
        //    日期格式器
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"MM-dd HH:mm";
        NSDate *now=[NSDate date];
        NSString *dateString=[formatter stringFromDate:now];
//        NSLog(@"formatter%@",dateString);
        
        self.time=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-80, CGRectGetMaxY(self.describeLabel.frame), 80, 20)];
        self.time.textColor=Color(207, 207, 207);
        self.time.font=[UIFont systemFontOfSize:13];
        self.time.text=dateString;
        [self.contentView addSubview:self.time];
    }
    return self;
}
-(void)changeActive:(UIButton *)sender{
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
