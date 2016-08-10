//
//  sendSMS.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/6.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "sendSMS.h"

@implementation sendSMS
- (NSString *)urlDomain {
    return @"home/sendSMS";
}

- (RequestType)reqType {
    return kRequestTypeGet;
}

- (void)ResponseSuccess:(id)response{
    if (!response) return;
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSLog(@"发送验证码返回的数据 %@",response);
        NSLog(@"发送验证码返回的数据 %@",response[@"msg"]);
        self.success=[response copy];
        NSLog(@">>>>>success>>>>>%@",self.success[@"status"]);
    }
}
@end
