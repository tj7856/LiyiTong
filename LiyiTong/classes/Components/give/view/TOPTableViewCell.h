//
//  TOPTableViewCell.h
//  LiyiTong
//
//  Created by 耿远风 on 16/8/3.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOPTableViewCell : UITableViewCell
/**
 *  view1的NO.n和标题
 */
@property (nonatomic,strong)UILabel *TopNum;
@property (nonatomic,strong)UILabel *view1Title;
/**
 *  view2的指数
 */
@property (nonatomic,assign)float hotIndex;
/**
 *  view3的热门理由、图片、价格、已送人数
 */
@property (nonatomic,strong)UILabel *reason;
@property (nonatomic,strong)UIImageView *imageview;
@property (nonatomic,strong)UILabel *price;
@property (nonatomic,strong)UILabel *personNum;

@property (nonatomic,strong)UIButton *topbutton;
@end
