//
//  TOPModel.h
//  LiyiTong
//
//  Created by 耿远风 on 16/8/3.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TOPModel : NSObject
/**
 *  view1的标题
 */
@property (nonatomic,copy)NSString *view1Title;
/**
 *  view2的指数
 */
@property (nonatomic,assign)float hotIndex;
/**
 *  view3的热门理由、图片、价格、已送人数
 */
@property (nonatomic,copy)NSString *reason;
@property (nonatomic,copy)NSString *image;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *personNum;
+(instancetype)modelWithDic:(NSDictionary *)dic;
-(instancetype)initWithDic:(NSDictionary *)dic;

@end
