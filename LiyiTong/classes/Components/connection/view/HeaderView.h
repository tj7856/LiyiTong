//
//  HeaderView.h
//  LiyiTong
//
//  Created by 耿远风 on 16/8/9.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView
@property (nonatomic, strong)UIView          * titleView;
@property (nonatomic, strong)UILabel         * titleLabel;
@property (nonatomic, copy)NSString          * titleString;

- (void)setTitleString:(NSString *)titleString;
@end
