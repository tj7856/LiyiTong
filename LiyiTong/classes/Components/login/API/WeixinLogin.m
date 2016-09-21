//
//  WeixinLogin.m
//  LiyiTong
//
//  Created by zhangtijie on 16/9/19.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "WeixinLogin.h"

@implementation WeixinLogin
- (NSString *)urlDomain {
    return @"home/weixin";
}

- (RequestType)reqType {
    return kRequestTypePost;
}

- (void)ResponseSuccess:(id)response{
    if (!response) return;
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSLog(@"登录返回的数据 %@",response);
        self.status = ((NSNumber *)response[@"status"]).integerValue;
        self.msg =response[@"msg"];
        self.token = response[@"token"];
        self.userId = response[@"userId"];
        
    }
}
@end
