//
//  Response.h
//  LiyiTong
//
//  Created by zhangtijie on 16/9/23.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SubResponse;
@interface Response : NSObject
@property(nonatomic,strong)NSString* Id;
@property(nonatomic,strong)NSString* tz_id;

@property(nonatomic,strong)NSString* userId;
@property(nonatomic,strong)NSString* name;

@property(nonatomic,strong)NSString* comment;
@property(nonatomic,assign)NSTimeInterval time;
@property(nonatomic,strong)NSMutableArray<SubResponse *> *SubRep;

@end
