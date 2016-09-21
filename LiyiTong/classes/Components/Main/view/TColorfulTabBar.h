//
//  TColorfulTabBar.h
//  2015-07-01-ColorfulTabBarAnimation
//
//  Created by TangJR on 7/1/15.
//  Copyright (c) 2015 tangjr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TColorfulTabBar : UITabBar
@property (weak, nonatomic) UIView *colorfulView; ///< 彩色的view
@property (assign, nonatomic) NSInteger fromeIndex; ///< tabbar之前选中的index
@property (assign, nonatomic) NSInteger toIndex; ///< tabbar即将选中的index

@end