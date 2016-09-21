//
//  WeixinLogin.h
//  LiyiTong
//
//  Created by zhangtijie on 16/9/19.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "LYTAFRequest.h"

@interface WeixinLogin : LYTAFRequest
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString* msg;
@property(nonatomic,strong)NSString* token;
@property(nonatomic,strong)NSString* userId;




@end
