//
//  User.h
//  LiyiTong
//
//  Created by zhangtijie on 16/8/8.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(nonatomic,strong)NSString* id;
@property(nonatomic,strong)NSString* userName;
@property(nonatomic,strong)NSString* phone;
@property(nonatomic,strong)NSString* qq;
@property(nonatomic,strong)NSString* weixin;


+ (User*) fromDictionary: (NSDictionary*) dic;
+ (NSDictionary*) fromData: (User*) user;


@end
