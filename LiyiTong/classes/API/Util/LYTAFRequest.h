//
//  LYTAFRequest.h
//  LiyiTong
//
//  Created by zhangtijie on 16/8/5.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 服务器地址

#ifndef USING_OUTER_NET
//默认外网
//新增一个内网的configuration(InnerRelease)，会加入USING_OUTER_NET宏(其他的configuration还是需要自己手动根据情况更改该处的值)
// 《注意：该处的值修改后，一定不能提交到git上，否则自动打包的ip可能会错误》
#define USING_OUTER_NET 0
#endif
////192.168.1.8:8080/lyitong/home/sendSMS
#if USING_OUTER_NET
//外网地址
#define SRV_IP_ADDRESS  @"123.56.29.24:8080"//@"118.144.79.138"//
#define RELEASE_HOST @"123.56.29.24:8080"//@"xdd.xindoudou.cn"//
#define HOST @"123.56.29.24:8080"//@"xdd.xindoudou.cn"//
#define URL_BASE_WITH_HOST @"http://" HOST @"/lyitong/"
#define FILE_SERVER_URL    @"http://" @"%@" @"/lyitong/"

#else
//内网地址
#define SRV_IP_ADDRESS  @"123.56.29.24:8080"//@"118.144.79.138"//
#define RELEASE_HOST @"123.56.29.24:8080"//@"xdd.xindoudou.cn"//
#define HOST @"123.56.29.24:8080"//@"xdd.xindoudou.cn"//
#define URL_BASE_WITH_HOST @"http://" HOST @"/lyitong/"
#define FILE_SERVER_URL    @"http://" @"%@" @"/lyitong/"

#endif //USING_OUTER_NET

#define SERVER_URL    URL_BASE_WITH_HOST

typedef NS_ENUM(int, RequestType) {
    kRequestTypeGet = 0, //get
    kRequestTypePost = 1, //post
    kRequestTypeHead = 2, //head
    kRequestTypePut = 3, //put
    kRequestTypePatch = 4, //patch
    kRequestTypeDelete = 5 //delete
};

typedef NS_ENUM(int, MultiDataType) {
    kMultiDataTypeImage = 1, //图片
    kMultiDataTypeVideo = 2, //视频
    kMultiDataTypeAudio = 3,  //语音
};

static NSString *const requestSuccess = @"HZTRequestSuccessWithResponse";

@interface LYTAFRequest : NSObject

@property (nonatomic, strong) NSDictionary *parameters; //参数

#pragma mark readOnly
@property (nonatomic, strong, readonly) NSString *urlDomain;
@property (nonatomic, strong, readonly) NSString *url; //request url
@property (nonatomic, assign, readonly) RequestType reqType; //get、post、head、put、delete
#pragma mark multipart
@property (nonatomic, assign) MultiDataType multiDataType; //资源文件类型
@property (nonatomic, strong) NSData *fileData; //资源文件二进制流

@property (nonatomic, assign, readonly) BOOL multipartData;

//服务器成功返回，可以重写
- (void)serverResponseSuccess:(NSNotification *)noti;

- (void)ResponseSuccess:(id)response;
@end
