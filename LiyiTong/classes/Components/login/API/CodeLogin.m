//
//  CodeLogin.m
//  LiyiTong
//
//  Created by zhangtijie on 16/9/7.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "CodeLogin.h"

@implementation CodeLogin
- (NSString *)urlDomain {
    return @"home/smslogin";
}

- (RequestType)reqType {
    return kRequestTypeGet;
}

- (void)ResponseSuccess:(id)response{
    if (!response) return;
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSLog(@"登录返回的数据 %@",response);
        
    }
}

@end
