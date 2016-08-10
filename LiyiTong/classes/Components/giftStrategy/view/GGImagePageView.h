//
//  GGImagePageView.h
//  轮播图test
//
//  Created by GG on 16/5/22.
//  Copyright © 2016年 GG. All rights reserved.
//

#import <UIKit/UIKit.h>

//自动翻页的时间间隔
#define kTimeInteral 3
//多长时间没拖拽后自动翻页
#define kNoResponse 2


@protocol GGImagePageViewDelegate <NSObject>

@optional
/**
 *  点击图片触发
 *
 *  @param index 会得到一个选中的图片下标
 */
- (void)didSelectViewWithIndex:(NSInteger)index;

@end
@interface GGImagePageView : UIView
@property (nonatomic, assign) id<GGImagePageViewDelegate>lazyDelegate;
//轮播图的数据源
@property (nonatomic,copy) NSArray *imageAarray;

//是否显示pageControl
@property (nonatomic,assign) BOOL showPageControl;

//是否定时滚动
@property (nonatomic,assign) BOOL isTimer;

//block监听点击事件
- (instancetype)initWithFrame:(CGRect)frame;

@end
