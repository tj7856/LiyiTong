//
//  NSObject+ALinHUD.m
//  MiaowShow
//
//  Created by ALin on 16/6/29.
//  Copyright © 2016年 ALin. All rights reserved.
//

#import "NSObject+LYTHUD.h"

@implementation NSObject (LYTHUD)
- (void)showInfo:(NSString *)info
{
    if ([self isKindOfClass:[UIViewController class]] || [self isKindOfClass:[UIView class]]) {
        [[[UIAlertView alloc] initWithTitle:@"礼意通" message:info delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}
@end
