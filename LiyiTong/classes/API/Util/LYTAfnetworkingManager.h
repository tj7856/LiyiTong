//
//  LYTAfnetworkingManager.h
//  LiyiTong
//
//  Created by zhangtijie on 16/8/5.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYTAFRequest;
typedef void(^ServerResponse)(NSError *err);
@interface LYTAfnetworkingManager : NSObject

#pragma mark Optional
@property (nonatomic, assign) NSTimeInterval timeoutInterval; //超时时间，默认30秒
@property (nonatomic, strong) NSDictionary *extralHTTPHeaderField; //http头部需要额外封装进去的字典(如：token等)

- (void)sendRequest:(LYTAFRequest *)req response:(ServerResponse)serverResponse;
-(void)cancelAllOperations;
@end
