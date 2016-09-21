//
//  login.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/6.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "login.h"

@implementation login
- (NSString *)urlDomain {
    return @"home/login";
}

- (RequestType)reqType {
    return kRequestTypeGet;
}

- (void)ResponseSuccess:(id)response{
    if (!response) return;
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSLog(@"登录返回的数据 %@",response);
//        self.success=[response copy];
        self.result = ((NSNumber *)response[@"status"]).integerValue;
//        NSLog(@">>>>>success>>>>>%@",self.success[@"status"]);
    }
}
@end
