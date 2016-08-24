//
//  popAlertView.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/15.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "popAlertView.h"
#define kWindow [[UIApplication sharedApplication].delegate window]
#define kButtonHeight 30
#define kFont [UIFont systemFontOfSize:12]
@implementation popAlertView
{
    NSArray *buttonItems;
    CGFloat popViewX;
    CGFloat popViewY;
    BOOL isShow;
}

- (instancetype)initWithSuperView:(UIView *)superView
{
    if (self = [super init]) {
        [self loadUI:superView];
    }
    return self;
}

- (instancetype)initWithSuperView:(UIView *)superView items:(NSArray *)items
{
    if (self = [super init]) {
        buttonItems = [NSArray arrayWithArray:items];
        [self loadUI:superView];
    }
    return self;
}
/**
 *  设置按钮数组
 *
 *  @param items 数组按钮
 */
- (void)setItems:(NSArray *)items
{
    _items = items;
    buttonItems = [NSArray arrayWithArray:items];
}
/**
 *  设置弹出视图的背景色
 *
 *  @param backColor 背景色,默认白色
 */
- (void)setBackColor:(UIColor *)backColor
{
    _backColor = backColor;
    self.backColor = backColor;
}
/**
 *  弹出视图边框颜色
 *
 *  @param PopBorderColor 默认黑色
 */
- (void)setPopBorderColor:(UIColor *)PopBorderColor
{
    _PopBorderColor = PopBorderColor;
    self.layer.borderColor = Color(198, 198, 198).CGColor;
}
/**
 *  显示弹出视图,再次点击消失
 */
- (void)showPopView
{
    if (!isShow) {
        [kWindow addSubview:self];
        [UIView animateWithDuration:0.333 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, buttonItems.count * kButtonHeight);
        }];
    }else{
        [UIView animateWithDuration:0.333 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    isShow = !isShow;
}
//按钮点击事件
- (void)buttonClick:(UIButton *)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(chooseButton:)]) {
        [self.delegate chooseButton:sender.titleLabel.text];
        [self showPopView];
    }
}
/**
 *  布局
 *
 *  @param superView superView description
 */
- (void)loadUI:(UIView *)superView
{
    isShow = NO;
    popViewX = superView.frame.origin.x;
    popViewY = superView.frame.origin.y;
    
    UIView *sup = superView;
    while ([sup.superview isKindOfClass:[UIView class]]) {
        popViewX += sup.superview.frame.origin.x;
        popViewY += sup.superview.frame.origin.y;
        NSLog(@"%f", popViewX);
        sup = sup.superview;
    }
    self.frame = CGRectMake(popViewX+168/2, superView.frame.size.height-30*buttonItems.count + popViewY-11, 168, 0);
    [self setButton];
    self.layer.borderWidth = 1;
    self.layer.borderColor=Color(198, 198, 198).CGColor;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
}
/**
 *  设置按钮
 */
- (void)setButton
{
    for (int i = 0; i < buttonItems.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonItems[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = kFont;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor=Color(198, 198, 198).CGColor;
        button.frame = CGRectMake(0, kButtonHeight * i, self.frame.size.width, kButtonHeight);
        [self addSubview:button];
    }
}
@end
