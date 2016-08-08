//
//  strategyTableViewCell.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/4.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "strategyTableViewCell.h"
#import <SDAutoLayout.h>
@implementation strategyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        topView.backgroundColor=Color(0, 243, 199);
        [self.contentView addSubview:topView];
        
        self.detailLabel=[[UILabel alloc]init];
        self.detailLabel.textColor=Color(153, 153, 153);
//        self.detailLabel.text=string;
        self.detailLabel.numberOfLines=3;
        self.detailLabel.adjustsFontSizeToFitWidth=YES;
//        // 调整行间距
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.detailLabel.text];
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle setLineSpacing:6];
//        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.detailLabel.text length])];
//        self.detailLabel.attributedText = attributedString;
//        [self.detailLabel sizeToFit];
        [self.contentView addSubview:self.detailLabel];
        self.detailLabel.sd_layout.topSpaceToView(topView,25*WidthScale).leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).heightIs(140*WidthScale);
        self.imageview=[[UIImageView alloc]init];
        [self.contentView addSubview:self.imageview];
        self.imageview.sd_layout.topSpaceToView(self.detailLabel,30*WidthScale).leftSpaceToView(self.contentView,15*WidthScale).rightSpaceToView(self.contentView,15*WidthScale).heightIs(380*WidthScale);
        
        UIView *leftSpace=[[UIView alloc]init];
        leftSpace.backgroundColor=Color(169, 170, 171);
        [self.contentView addSubview:leftSpace];
        leftSpace.sd_layout.topSpaceToView(self.imageview,30*WidthScale).leftEqualToView(self.imageview).widthIs(2).heightIs(80*WidthScale);
        
        self.price=[[UILabel alloc]init];
        self.price.adjustsFontSizeToFitWidth=YES;
        [self.contentView addSubview:self.price];
        self.price.sd_layout.topEqualToView(leftSpace).leftSpaceToView(leftSpace,15*WidthScale).heightIs(30*WidthScale).widthIs(150*WidthScale);
        
        self.explainLabel=[[UILabel alloc]init];
        self.explainLabel.adjustsFontSizeToFitWidth=YES;
        [self.contentView addSubview:self.explainLabel];
        self.explainLabel.sd_layout.leftEqualToView(self.price).bottomEqualToView(leftSpace).widthIs(360*WidthScale).heightIs(30*WidthScale);
        
        self.lovePersonNum=[[UILabel alloc]init];
        self.lovePersonNum.textColor=Color(153, 153, 153);
        self.lovePersonNum.adjustsFontSizeToFitWidth=YES;
        [self.contentView addSubview:self.lovePersonNum];
        self.lovePersonNum.sd_layout.leftSpaceToView(self.price,40*WidthScale).topEqualToView(leftSpace).heightIs(30*WidthScale).widthIs(180*WidthScale);
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame=CGRectMake(432*WidthScale, CGRectGetMaxY(self.imageview.frame)+22*WidthScale, 285*WidthScale, 80*WidthScale);
        [button setTitle:@"查看详情" forState:UIControlStateNormal];
        [button setTitleColor:Color(0, 243, 199) forState:UIControlStateNormal];
        [button.layer setBorderWidth:1.0];
        [button.layer setBorderColor:Color(0, 243, 199).CGColor];
        [self.contentView addSubview:button];
        [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
        button.sd_layout.leftSpaceToView(self.lovePersonNum,40*WidthScale).topEqualToView(leftSpace).rightEqualToView(self.imageview).bottomEqualToView(leftSpace);

    }
    return self;
}
-(void)go:(UIButton *)sender{
    NSLog(@"%@",self.explainLabel.text);
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
