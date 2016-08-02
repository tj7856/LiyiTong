//
//  adButton.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/1.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "adButton.h"

@implementation adButton

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.button=[[UIButton alloc]initWithFrame:frame];
        [self addSubview:self.button];
        self.label=[[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-10, frame.size.width, 10)];
        [self addSubview:self.label];
    }
    return self;
}

@end
