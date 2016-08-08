//
//  User.m
//  LiyiTong
//
//  Created by zhangtijie on 16/8/8.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "User.h"
#import "MJExtension.h"

@implementation User
+ (User*) fromDictionary: (NSDictionary*) dic
{
    User *user = [User objectWithKeyValues:dic];
//    [user objectWithKeyValues:dic];
    return user;
}

+ (NSDictionary*) fromData: (User*) user
{
    NSDictionary *dic = user.mj_keyValues;
    NSLog(@"%@",dic);
    return dic;
}
@end
