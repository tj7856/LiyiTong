//
//  guessModel.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/3.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "guessModel.h"

@implementation guessModel
+(instancetype)modelWithDic:(NSDictionary *)dic{

    return [[[self class] alloc]initWithDic:dic];
}

-(instancetype)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        //分解字典内容
        self.title=dic[@"title"];
        NSLog(@">>>%@",self.title);
        self.detailArray=dic[@"detail"];
        NSLog(@"!!!%@",self.detailArray[0][@"因为"]);
//        self.title=dic[@"title"];
//        self.imageList=dic[@"imageList"];
    }
    return self;
}

@end
