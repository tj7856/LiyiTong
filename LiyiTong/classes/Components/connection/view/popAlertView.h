//
//  popAlertView.h
//  LiyiTong
//
//  Created by 耿远风 on 16/8/15.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YFPopViewDelegate <NSObject>

- (void)chooseButton:(NSString *)title;

@end
@interface popAlertView : UIView
/**
 *  初始化方法
 *
 *  @param superView 父视图
 *
 *  @return return value description
 */
- (instancetype)initWithSuperView:(UIView *)superView;
/**
 *  初始化方法
 *
 *  @param superView 父视图
 *  @param items     按钮数组
 *
 *  @return return value description
 */
- (instancetype)initWithSuperView:(UIView *)superView items:(NSArray *)items;
/**
 *  弹出视图,再次点击消失
 */
- (void)showPopView;
/**
 *  按钮数组
 */
@property (nonatomic, strong) NSArray *items;
/**
 *  弹出视图的颜色(默认白色)
 */
@property (nonatomic, strong) UIColor *backColor;
/**
 *  边框颜色(默认黑色)
 */
@property (nonatomic, strong) UIColor *PopBorderColor;
/**
 *  代理
 */
@property (nonatomic, assign) id<YFPopViewDelegate>delegate;

@end
