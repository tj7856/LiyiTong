//
//  Order.h
//  LiyiTong
//
//  Created by zhangtijie on 16/8/5.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject
@property(nonatomic,assign)NSInteger renshu;
@property(nonatomic,assign)NSUInteger fenshu;
@property(nonatomic,strong)NSString* zhufu;
@property(nonatomic,assign,getter=IsXianjia)BOOL xianJia;
@property(nonatomic,assign)float yunfei;
@property(nonatomic,assign)float zongjia;
@property(nonatomic,assign)float jianjia,lipingJinE;
@property(nonatomic,assign,getter=IsEdian)BOOL Edian;
@property(nonatomic,assign)NSInteger KouEdian;










@end
