//
//  ConnectionTableViewCell.h
//  LiyiTong
//
//  Created by 耿远风 on 16/8/10.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectionTableViewCell : UITableViewCell
/**
 *  头像、名字、关注、节日1、节日2
 */
@property (nonatomic,strong)UIImageView *userHeader;
@property (nonatomic,strong)UILabel *userName;
@property (nonatomic,strong)UIButton *see;
@property (nonatomic,strong)UILabel *jieri1;
@property (nonatomic,strong)UILabel *jieri2;
@end
