//
//  guessModel.h
//  LiyiTong
//
//  Created by 耿远风 on 16/8/3.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface guessModel : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSArray *detailArray;
+(instancetype)modelWithDic:(NSDictionary *)dic;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
