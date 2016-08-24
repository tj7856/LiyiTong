//
//  orderStatusTableViewCell.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/17.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "orderStatusTableViewCell.h"

@implementation orderStatusTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.header=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70*WidthScale, 70*WidthScale)];
        self.header.layer.cornerRadius=35*WidthScale;
        self.header.clipsToBounds=YES;
        [self.contentView addSubview:self.header];
        
        self.name=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.header.frame)+10, 35*WidthScale, 80, 15)];
        self.name.textColor=[UIColor blackColor];
        self.name.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:self.name];
        
        self.time=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-160, 35*WidthScale, 150, 15)];
        self.time.font=[UIFont systemFontOfSize:14];
        self.time.textColor=Color(221, 221, 221);
        self.time.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:self.time];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 99*WidthScale-1, ScreenWidth, 1)];
        line.backgroundColor=Color(221, 221, 221);
        [self.contentView addSubview:line];
    }
    return self;
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
