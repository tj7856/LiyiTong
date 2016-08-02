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

typedef void(^SelectedImageViewBlcok)(int selectIndex);

@interface GGImagePageView : UIView

//轮播图的数据源
@property (nonatomic,copy) NSArray *imageAarray;

//是否显示pageControl
@property (nonatomic,assign) BOOL showPageControl;

//是否定时滚动
@property (nonatomic,assign) BOOL isTimer;

//block监听点击事件
- (instancetype)initWithFrame:(CGRect)frame withSelectImageBlock:(SelectedImageViewBlcok)block;

@end
