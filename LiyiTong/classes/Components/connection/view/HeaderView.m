//
//  HeaderView.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/9.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _titleView.backgroundColor = Color(238, 238, 238);
        [self addSubview:_titleView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 2, self.frame.size.width-16*2, 14)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_titleView addSubview:_titleLabel];
    }
    return self;
}

- (void)setTitleString:(NSString *)titleString
{
    _titleLabel.text = titleString;
}


@end
