//
//  TOPModel.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/3.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "TOPModel.h"

@implementation TOPModel
+(instancetype)modelWithDic:(NSDictionary *)dic{
    
    return [[[self class] alloc]initWithDic:dic];
}

-(instancetype)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        //分解字典内容
        self.view1Title=dic[@"title"];
        self.hotIndex=[dic[@"hotIndex"] floatValue];
        self.reason=dic[@"reason"];
        self.image=dic[@"image"];
        self.price=dic[@"price"];
        self.personNum=dic[@"personNum"];
//        NSLog(@">>>%@",self.view1Title);
//        self.detailArray=dic[@"detail"];
//        NSLog(@"!!!%@",self.detailArray[0][@"因为"]);
        //        self.title=dic[@"title"];
        //        self.imageList=dic[@"imageList"];
    }
    return self;
}

@end
