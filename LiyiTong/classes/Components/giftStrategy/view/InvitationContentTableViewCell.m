//
//  InvitationContentTableViewCell.m
//  LiyiTong
//
//  Created by zhangtijie on 16/9/20.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "InvitationContentTableViewCell.h"
#import <SDAutoLayout.h>

#import "PostsContent.h"
#import "UIImageView+WebCache.h"

@interface InvitationContentTableViewCell()
@property(nonatomic,weak)UIView *layoutView;
@end

@implementation InvitationContentTableViewCell

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
    
}

-(void)setItems:(NSArray *)items
{
    _items =items;
    [self fillContent];
}

-(void)fillContent
{
//    UIView *self.contentView = [[UIView alloc]init];
//    self.contentView.backgroundColor = [UIColor blueColor];
//    self.layoutView =self.contentView;
//   
//    [self.self.contentView addSubview:self.contentView];
//    self.contentView.sd_layout.rightSpaceToView(self.self.contentView,12).leftSpaceToView(self.self.contentView,12).topSpaceToView(self.self.contentView,0).heightIs(500);
    
    for (PostsContent *content in self.items) {
        NSLog(@"==%@===%f==%@",NSStringFromClass([self.layoutView class]),CGRectGetMaxY(self.layoutView.frame),NSStringFromCGRect(self.layoutView.frame) );
        if (content.Sort == 0 ) {
            if (content.type ==kContentTypeString) {
                NSString *originStr = [NSString stringWithFormat:@"[ 这是大标题 ] %@",content.content];
                UILabel *lable = [[UILabel alloc]init];
                self.layoutView =lable;
                lable.numberOfLines = 0;
                [self.self.contentView addSubview:lable];
                lable.sd_layout.widthRatioToView(self.self.contentView,1.0f).leftSpaceToView(self.self.contentView,0).topSpaceToView(self.self.contentView,6).autoHeightRatio(0);
                //第一段
                NSDictionary *attrDict1 = @{ NSFontAttributeName: [UIFont systemFontOfSize:15],
                                             NSForegroundColorAttributeName: [UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:1] };
                NSAttributedString *attrStr1 = [[NSAttributedString alloc] initWithString: [originStr substringWithRange: NSMakeRange(0, 9)] attributes: attrDict1];//9为title的长度加4
                
                //第二段
                NSDictionary *attrDict2 = @{ NSFontAttributeName: [UIFont systemFontOfSize:14],
                                             NSForegroundColorAttributeName: [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1] };
                NSAttributedString *attrStr2 = [[NSAttributedString alloc] initWithString: [originStr substringWithRange: NSMakeRange(10, originStr.length-11)] attributes: attrDict2];
                
                
                //合并
                NSMutableAttributedString *attributedStr03 = [[NSMutableAttributedString alloc] initWithAttributedString: attrStr1];
                [attributedStr03 appendAttributedString: attrStr2];
                
                
                lable.attributedText = attributedStr03;
                
            }
            else
            {
                NSString *originStr = [NSString stringWithFormat:@"[ 这是大标题 ] %@",content.content];
                UILabel *lable = [[UILabel alloc]init];
                self.layoutView =lable;
                lable.numberOfLines = 0;
                lable.font = [UIFont systemFontOfSize:15];
                lable.textColor = [UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:1];
                lable.text = originStr;
                [self.contentView addSubview:lable];
                lable.sd_layout.widthRatioToView(self.self.contentView,1.0f).leftSpaceToView(self.self.contentView,0).topSpaceToView(self.self.contentView,6).autoHeightRatio(0);
                
                
            }
            continue;
        }
    
        switch (content.type) {
            case kContentTypeString:
            {
                UILabel *lable = [[UILabel alloc]init];
                lable.numberOfLines = 0;
                lable.font = [UIFont systemFontOfSize:14];
                lable.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
                lable.text = content.content;
                [self.contentView addSubview:lable];
                lable.sd_layout.widthRatioToView(self.contentView,1.0f).leftSpaceToView(self.contentView,0).topSpaceToView(self.layoutView,18).autoHeightRatio(0);
                self.layoutView =lable;
            }
                break;
            case kContentTypeImage:
            {
                //                __weak __typeof(self) weakSelf = self;
                UIImageView *imageV = [[UIImageView alloc]init];
                [self.contentView addSubview:imageV];
                imageV.sd_layout.widthIs(250).heightIs(200).centerXEqualToView(self.contentView).topSpaceToView(self.layoutView,13);
                self.layoutView = imageV;
                [imageV sd_setImageWithURL:[NSURL URLWithString:content.content] placeholderImage:[UIImage imageNamed:@"1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                    
//                    CGFloat w = (image.size.width/2)>self.contentView.bounds.size.width?self.contentView.bounds.size.width:image.size.width/2;
//                    CGFloat h = w/ScreenWidth*image.size.height/2;
//                    imageV.sd_layout.widthIs(w).heightIs(h);
////                    [imageV updateLayout];
//                     [imageV updateLayoutWithCellContentView:self.superview];
                    //                    weakSelf.layoutView = imageV;
                }];
            }
                
                break;
            case kContentTypeTitle:
            {
                UIView *title = [[UIView alloc]init];
                [self.contentView addSubview:title];
                title.sd_layout.leftSpaceToView(self.self.contentView,0).widthRatioToView(self.self.contentView,1.0f).topSpaceToView(self.layoutView,28).heightIs(21);
                self.layoutView =title;
                UIView *zhuzi =[[UIView alloc]init];
                zhuzi.backgroundColor = [UIColor colorWithRed:12/255.0 green:230/255.0 blue:196/255.0 alpha:1];
                [title addSubview:zhuzi];
                zhuzi.sd_layout.widthIs(4).heightRatioToView(title,1.0f).leftSpaceToView(title,0).topSpaceToView(title,0);
                UILabel *smallBiaoti = [[UILabel alloc]init];
                smallBiaoti.font = [UIFont systemFontOfSize:15];
                smallBiaoti.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                smallBiaoti.text = content.content;
                [title addSubview:smallBiaoti];
                smallBiaoti.sd_layout.leftSpaceToView(zhuzi,4).rightSpaceToView(title,0).autoHeightRatio(0).centerYEqualToView(title);
            }
                
                break;
            case kContentTypeGift:
            {
                UIView *giftView = [[UIView alloc]init];
                [self.contentView addSubview:giftView];
                giftView.sd_layout.leftSpaceToView(self.contentView,0).widthRatioToView(self.contentView,1.0f).topSpaceToView(self.layoutView,28).heightIs(159);
                self.layoutView =giftView;
                UIView *line = [[UIView alloc]init];
                line.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:238/255.0 alpha:1];
                [giftView addSubview:line];
               line.sd_layout.widthRatioToView(giftView,1.0f).leftSpaceToView(giftView,0).topSpaceToView(giftView,0).heightIs(1);
                
                UILabel *share =[[UILabel alloc]init];
                share.text = @"分享礼物";
                share.font = [UIFont systemFontOfSize:18];
                [giftView addSubview:share];
                share.sd_layout.leftSpaceToView(giftView,0).topSpaceToView(giftView,16).rightSpaceToView(giftView,0).autoHeightRatio(0);
                UIView *giftContent = [[UIView alloc]init];
                giftContent.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:238/255.0 alpha:1];
                [giftView addSubview:giftContent];
                giftContent.sd_layout.topSpaceToView(share,8).leftSpaceToView(giftView,0).widthRatioToView(giftView,1.0f).heightIs(112);
                UIImageView *giftImag = [[UIImageView alloc]init];
                giftImag.image = [UIImage imageNamed:@"b4_21"];
                [giftContent addSubview:giftImag];
                giftImag.sd_layout.widthIs(60).heightIs(60).topSpaceToView(giftContent,10).leftSpaceToView(giftContent,10);
                UILabel *giftTitle = [[UILabel alloc]init];
                giftTitle.text = @"但把健康服不服八法几把罚款及安保费看见俺不是看见伐开森";
                giftTitle.numberOfLines =2;
                giftTitle.font = [UIFont systemFontOfSize:12];
                giftTitle.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
                [giftContent addSubview:giftTitle];
                giftTitle.sd_layout.widthIs(150).leftSpaceToView(giftImag,9).topSpaceToView(giftContent,10).heightIs(29);
                UILabel *jiage = [[UILabel alloc]init];
                jiage.font = [UIFont systemFontOfSize:15];
                jiage.textColor = [UIColor colorWithRed:12/255.0 green:230/255.0 blue:196/255.0 alpha:1];
                jiage.text = @"￥56";
                [giftContent addSubview:jiage];
                jiage.sd_layout.leftSpaceToView(giftImag,4).topSpaceToView(giftTitle,10).widthIs(100).autoHeightRatio(0);
                UIButton *go = [UIButton buttonWithType:(UIButtonTypeCustom)];
                go.tag =content.Sort*10;
                [go setImage:[UIImage imageNamed:@"back_right"] forState:(UIControlStateNormal)];
                [go addTarget:self action:@selector(go:) forControlEvents:(UIControlEventTouchUpInside)];
                [giftContent addSubview:go];
                go.sd_layout.widthIs(50).heightIs(50).topSpaceToView(giftContent,18).rightSpaceToView(giftContent,6);
                UIView *fenge = [[UIView alloc]init];
                fenge.backgroundColor = [UIColor whiteColor];
                [giftContent addSubview:fenge];
                fenge.sd_layout.heightIs(1).leftSpaceToView(giftContent,0).widthRatioToView(giftContent,1.0f).topSpaceToView(giftImag,10);
                UIView *shu = [[UIView alloc]init];
                shu.backgroundColor = [UIColor whiteColor];
                [giftContent addSubview:shu];
                shu.sd_layout.heightIs(18).widthIs(1).centerXEqualToView(giftContent).topSpaceToView(fenge,5);
                UIView *left = [[UIView alloc]init];
                [giftContent addSubview:left];
                left.sd_layout.leftSpaceToView(giftContent,0).rightSpaceToView(shu,0).topSpaceToView(fenge,0).bottomSpaceToView(giftContent,0);
                UIView *right = [[UIView alloc]init];
                [giftContent addSubview:right];
                right.sd_layout.leftSpaceToView(shu,0).rightSpaceToView(giftContent,0).topSpaceToView(fenge,0).bottomSpaceToView(giftContent,0);
                
                UIButton *zan = [UIButton buttonWithType:(UIButtonTypeCustom)];
                zan.tag = content.Sort*10+1;
                [zan addTarget:self action:@selector(zan:) forControlEvents:(UIControlEventTouchUpInside)];
                [zan setImage:[UIImage imageNamed:@"heart"] forState:(UIControlStateNormal)];
                [zan setImage:[UIImage imageNamed:@"heart_active_24"] forState:(UIControlStateSelected)];
                [zan setTitle:@"218" forState:(UIControlStateNormal)];
                [left addSubview:zan];
                zan.sd_layout.centerYEqualToView(left).centerXEqualToView(left).widthIs(55).heightIs(20);
                UIButton *shop = [UIButton buttonWithType:(UIButtonTypeCustom)];
                shop.tag =content.Sort+2;
                [shop addTarget:self action:@selector(go:) forControlEvents:(UIControlEventTouchUpInside)];
                [shop setImage:[UIImage imageNamed:@"cart_active_03"] forState:(UIControlStateNormal)];
//                [shop setImage:[UIImage imageNamed:@"heart_active_24"] forState:(UIControlStateSelected)];
                [shop setTitle:@"218" forState:(UIControlStateNormal)];
                [right addSubview:shop];
                shop.sd_layout.centerYEqualToView(right).centerXEqualToView(right).widthIs(55).heightIs(20);
                
       
            }
                break;

            default:
                break;
        }
    }

    [self setupAutoHeightWithBottomView:self.layoutView bottomMargin:10 ];
}

-(void)zan:(UIButton *)sender
{
    NSInteger index = sender.tag/10;
    PostsContent *item = self.items[index];
    if (self.zanButtonClickedOperation) {
        self.zanButtonClickedOperation(item);
    }
    
    
}

-(void)go:(UIButton *)sender
{
    NSInteger index = sender.tag/10;
    PostsContent *item = self.items[index];
    if (self.goButtonClickedOperation) {
        self.goButtonClickedOperation(item);
    }
}

@end
