//
//  Response.m
//  LiyiTong
//
//  Created by zhangtijie on 16/9/23.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "Response.h"


@implementation Response

-(NSMutableArray<SubResponse *> *)SubRep
{
    if (!_SubRep) {
        _SubRep = [NSMutableArray array];
    }
    return _SubRep;
}
@end
