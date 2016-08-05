//
//  CheckPhone.m
//  LiyiTong
//
//  Created by zhangtijie on 16/8/5.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "CheckPhone.h"

@implementation CheckPhone
- (NSString *)urlDomain {
    return @"home/checkPhone";
}

- (RequestType)reqType {
    return kRequestTypeGet;
}

- (void)ResponseSuccess:(id)response{
    if (!response) return;
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSLog(@"sign in success and response is %@",response);
    
    }
}
@end
