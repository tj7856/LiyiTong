//
//  LYTAFRequest.m
//  LiyiTong
//
//  Created by zhangtijie on 16/8/5.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "LYTAFRequest.h"
@interface LYTAFRequest ()

@property (nonatomic, strong) NSString *urlDomain; //domain
@property (nonatomic, strong) NSString *url; //request url
@property (nonatomic, assign) RequestType reqType; //get、post、head、put、delete
@property (nonatomic, assign) BOOL multipartData; //need multipart data
@end
@implementation LYTAFRequest
- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(serverResponseSuccess:) name:requestSuccess object:nil];
    }
    return self;
}

//可以重载
- (NSString *)url {
    if (!_url) {
        _url = [NSString stringWithFormat:@"%@%@",URL_BASE_WITH_HOST,self.urlDomain];
    }
    return _url;
}

- (NSString *)urlDomain {
    return @"";
}

//默认为NO。当需要上传图片、语音、视频等资源文件时，需设置为YES
- (BOOL)multipartData {
    return NO;
}

//请求参数。也可以重载parameters获取方法
- (void)setParameters:(NSDictionary *)parameters {
    if (!parameters) return;
    _parameters = parameters;
}

//服务器正确相应后，返回的数据
- (void)serverResponseSuccess:(NSNotification *)noti {
    //子类需要处理服务器回包时,重载该函数即可,eg:
    //id response = noti.userInfo[@"response"];
}

- (void)dealloc {
    NSLog(@"request %@ dealloc",self.url);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
