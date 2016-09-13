//
//  ALinSelectedView.h
//  MiaowShow
//
//  Created by ALin on 16/6/14.
//  Copyright © 2016年 ALin. All rights reserved.
//  首页导航的顶部选择视图

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, HomeType) {
    HomeTypegift, // 礼物攻略
    HomeTypeguess, // 猜
//    HomeTypegive // 大家送
};

@interface SelectedView : UIView
/** 选中了 */
@property(nonatomic, copy)void (^selectedBlock)(HomeType type);
/** 下划线 */
@property (nonatomic, weak, readonly)UIView *underLine;
/** 设置滑动选中的按钮 */
@property(nonatomic, assign) HomeType selectedType;
@end
