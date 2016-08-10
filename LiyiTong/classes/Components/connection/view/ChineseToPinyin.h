//
//  ChineseToPinyin.h
//  LiyiTong
//
//  Created by 耿远风 on 16/8/9.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChineseToPinyin : NSObject
+ (NSString *) pinyinFromChiniseString:(NSString *)string;
+ (char) sortSectionTitle:(NSString *)string;

char pinyinFirstLetter(unsigned short hanzi);
@end
