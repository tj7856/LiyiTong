//
//  giftdetail.h
//  LiyiTong
//
//  Created by zhangtijie on 16/8/11.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface giftdetail : NSObject
@property(nonatomic,strong)NSString* id;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* price;
@property(nonatomic,strong)NSString* descr;
@property(nonatomic,assign)NSInteger zan;
@property(nonatomic,assign)NSInteger paiMin;
@property(nonatomic,assign)NSInteger Totalkuncun;
@property(nonatomic,strong)NSArray* color;
@property(nonatomic,strong)NSArray* chicun;
@property(nonatomic,strong)NSArray* subkuncun;
@property(nonatomic,strong)NSArray* connent;




-(NSInteger)GetsubkuncunWithcolor:(NSString *)color Withchicun:(NSString *)chicun;


@end

@interface giftColor : NSObject
@property(nonatomic,strong)NSString* color;
@property(nonatomic,strong)NSString* pic;



@end
