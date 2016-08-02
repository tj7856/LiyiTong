//
//  giftTableViewCell.h
//  LiyiTong
//
//  Created by 耿远风 on 16/8/1.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface giftTableViewCell : UITableViewCell
/**
 *  底层
 */
@property (nonatomic,strong)UIImageView *backImage;
/**
 *  喜欢背景
 */
@property (nonatomic,strong)UIView *rightView;
/**
 *  喜欢按钮
 */
@property (nonatomic,strong)UIButton *loveButton;
/**
 *  数量
 */
@property (nonatomic,strong)UILabel *loveLabel;
/**
 *  标题
 */
@property (nonatomic,strong)UILabel *captionLabel;
/**
 *  描述
 */
@property (nonatomic,strong)UILabel *describeLabel;
/**
 *  标签1
 */
@property (nonatomic,strong)UILabel *label1;
/**
 *  标签2
 */
@property (nonatomic,strong)UILabel *label2;
/**
 *  标签3
 */
@property (nonatomic,strong)UILabel *label3;
/**
 *  标签4
 */
@property (nonatomic,strong)UILabel *label4;
/**
 *  时间
 */
@property (nonatomic,strong)UILabel *time;

@end
