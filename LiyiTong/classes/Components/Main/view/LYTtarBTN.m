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
//        self.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
        
        self.backgroundColor    = [UIColor colorWithRed:12/255.0 green:230/255.0 blue:196/255.0 alpha:1];
        self.layer.cornerRadius = frame.size.height/2;
        self.layer.masksToBounds =YES;
        self.layer.borderWidth = 9;
//        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderColor = [UIColor colorWithRed:175/255.0 green:254/255.0 blue:243/255.0 alpha:1].CGColor;
        self.hidden =YES;
        self.clipsToBounds =YES;
        
    }
    return self;
}

- (void)doAnimation {
    
//    // 移除动画
//    [self.layer pop_removeAllAnimations];
//    
//    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    
//    // 设置代理
//    spring.delegate            = self;
//    
//    // 动画起始值 + 动画结束值
//    spring.fromValue           = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
//    spring.toValue             = [NSValue valueWithCGSize:CGSizeMake(12.f, 12.f)];
//    
//    // 参数的设置
//    spring.springSpeed         = 12;
//    spring.springBounciness    = 4;
//    spring.dynamicsMass        = 1;
//    spring.dynamicsFriction    = 30;
//    spring.dynamicsTension     = 300;
//    
//    // 执行动画
//    [self.layer pop_addAnimation:spring forKey:nil];
    
//    CGRect rect1 =  self.frame;
//    rect1.size.width = 0;
//    rect1.size.height = 0;
//    self.frame  = rect1;
//    
//    [UIView animateWithDuration:0.25 animations:^{
//        CGRect rect =  self.frame;
//        rect.size.width = 40;
//        rect.size.height = 40;
//        self.frame  = rect;
//    }];
    
//    CABasicAnimation *theAnimation;
//    theAnimation=[CABasicAnimation animationWithKeyPath:@"scale"];
//    theAnimation.delegate = self;
//    theAnimation.duration = 1;
//    theAnimation.repeatCount = 0;
//    theAnimation.removedOnCompletion = FALSE;
//    theAnimation.fillMode = kCAFillModeForwards;
//    theAnimation.autoreverses = NO;
//    theAnimation.fromValue = [NSNumber numberWithFloat:1];
//    theAnimation.toValue = [NSNumber numberWithFloat:40];
//    [self.layer addAnimation:theAnimation forKey:@"scale"];
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration=0.3;
    theAnimation.removedOnCompletion = NO;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.autoreverses = NO;
    theAnimation.fromValue = [NSNumber numberWithFloat:0.1];
    theAnimation.toValue = [NSNumber numberWithFloat:1];
    [self.layer addAnimation:theAnimation forKey:@"animateTransform"];
    
   // 以上缩放是以view的中心点为中心缩放的，如果需要自定义缩放点，可以设置卯点：
    //中心点
    [self.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
    
    //左上角
//    [yourView.layer setAnchorPoint:CGPointMake(0, 0)];
    
    //右下角
//    [yourView.layer setAnchorPoint:CGPointMake(1, 1)];
}

//-(void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    CGRect frame = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.width/2);
//    /*画填充圆
//     */
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [[UIColor  clearColor] set];
//    CGContextFillRect(context, rect);
//    
//    CGContextAddEllipseInRect(context, frame);
//    [[UIColor orangeColor] set];
//    CGContextFillPath(context);
//}

@end
