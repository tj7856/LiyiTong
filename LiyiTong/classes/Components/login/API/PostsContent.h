//
//  PostsContent.h
//  LiyiTong
//
//  Created by zhangtijie on 16/9/20.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(int, ContentType) {
    kContentTypeString = 0, //内容
    kContentTypeImage = 1, //图片
    kContentTypeTitle = 2, //小标题
    kContentTypeGift = 3, //小礼物
    
    
};
@interface PostsContent : NSObject
@property(nonatomic,assign)NSInteger Sort;
@property(nonatomic,strong)NSString* content;
@property(nonatomic,assign)ContentType type;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat high;





@end
