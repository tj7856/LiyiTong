//
//  LYTtarBTN.m
//  LiyiTong
//
//  Created by zhangtijie on 16/9/9.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "LYTtarBTN.h"
#import "POP.h"

@implementation LYTtarBTN

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor    = [UIColor colorWithRed:73/255.0 green:228/255.0 blue:185/255.0 alpha:1];
        self.layer.cornerRadius = 2;
        //        self.layer
    }
    return self;
}

- (void)doAnimation {
    
    // 移除动画
    [self.layer pop_removeAllAnimations];
    
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    // 设置代理
    spring.delegate            = self;
    
    // 动画起始值 + 动画结束值
    spring.fromValue           = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    spring.toValue             = [NSValue valueWithCGSize:CGSizeMake(12.f, 12.f)];
    
    // 参数的设置
    spring.springSpeed         = 12;
    spring.springBounciness    = 4;
    spring.dynamicsMass        = 1;
    spring.dynamicsFriction    = 30;
    spring.dynamicsTension     = 300;
    
    // 执行动画
    [self.layer pop_addAnimation:spring forKey:nil];
}


@end
