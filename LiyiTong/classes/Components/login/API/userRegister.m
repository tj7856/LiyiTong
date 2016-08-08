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
        NSLog(@"sign in success and response is %@",response);
        self.success=[response copy];
        NSLog(@">>>>>success>>>>>%@",self.success[@"status"]);
    }
}
@end
