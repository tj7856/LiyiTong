//
//  userRegister.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/6.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "userRegister.h"

@implementation userRegister
- (NSString *)urlDomain {
    return @"home/register";
}

- (RequestType)reqType {
    return kRequestTypeGet;
}

- (void)ResponseSuccess:(id)response{
    if (!response) return;
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSLog(@"注册返回的数据 %@",response);
        NSLog(@"注册返回的数据 %@",response[@"msg"]);
//        self.success=[response copy];
         self.result = ((NSNumber *)response[@"status"]).integerValue;
//        NSLog(@">>>>>success>>>>>%@",self.success[@"status"]);
    }
}
@end
