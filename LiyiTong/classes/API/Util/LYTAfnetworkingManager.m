//
//  LYTAfnetworkingManager.m
//  LiyiTong
//
//  Created by zhangtijie on 16/8/5.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "LYTAfnetworkingManager.h"
#import "LYTAFRequest.h"
#import "AFNetworking.h"
//#import "UIViewController+SLHUD.h"
#import "LYTAlertView.h"
@interface LYTAfnetworkingManager ()

@property(nonatomic,copy)ServerResponse serverResponse;
@property(nonatomic,strong)LYTAFRequest *theReq;


@end


@implementation LYTAfnetworkingManager
- (id)init {
    self = [super init];
    if (self) {
        _timeoutInterval = 10;
    }
    return self;
}

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval {
    if (timeoutInterval != _timeoutInterval) {
        _timeoutInterval = timeoutInterval;
    }
}

- (void)setExtralHTTPHeaderField:(NSDictionary *)extralHTTPHeaderField {
    if (!extralHTTPHeaderField) return;
    _extralHTTPHeaderField = extralHTTPHeaderField;
}

- (void)sendRequest:(LYTAFRequest *)req response:(ServerResponse)serverResponse{
    if (!req || !req.url) return;
    _theReq = req;
    _serverResponse = serverResponse;
    
    NSURL *baseUrl = [NSURL URLWithString:req.url];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
    manager.requestSerializer.timeoutInterval = self.timeoutInterval;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
//    [self configureExtralHttpHeadField:manager];
    
    switch (req.reqType) {
        case kRequestTypeGet: {
            [manager GET:req.url parameters:req.parameters progress:^(NSProgress *downloadProgress) {
                [self handleProgress:downloadProgress];
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                [self handleRequestSuccess:responseObject task:task req:req];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"----%@",error);
                [self handleRequestError:error task:task];
            }];
        }
            break;
        case kRequestTypePost: {
            if (req.multipartData) {
                [manager POST:req.url parameters:req.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    if (req.multiDataType == kMultiDataTypeImage) {
                        [formData appendPartWithFileData:req.fileData name:@"file" fileName:@"pic.jpg" mimeType:@"image/*"];
                    } else if (req.multiDataType == kMultiDataTypeVideo) {
                        [formData appendPartWithFileData:req.fileData name:@"file" fileName:@"video.mp4" mimeType:@"video/*"];
                    } else if (req.multiDataType == kMultiDataTypeAudio) {
                        [formData appendPartWithFileData:req.fileData name:@"file" fileName:@"voice.amr" mimeType:@"voice/*"];
                    }else {
                        //其他类型的资源文件，可参考上面的图片等自己实现
                    }
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    [self handleProgress:uploadProgress];
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self handleRequestSuccess:responseObject task:task req:req];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self handleRequestError:error task:task];
                }];
            }else {
                [manager POST:req.url parameters:req.parameters progress:^(NSProgress *uploadProgress) {
                    [self handleProgress:uploadProgress];
                } success:^(NSURLSessionDataTask *task, id responseObject) {
                    [self handleRequestSuccess:responseObject task:task req:req];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [self handleRequestError:error task:task];
                }];
            }
        }
            break;
        case kRequestTypeHead: {
            [manager HEAD:req.url parameters:req.parameters success:^(NSURLSessionDataTask * _Nonnull task) {
                [self handleRequestSuccess:nil task:task req:req];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestError:error task:task];
            }];
        }
            break;
        case kRequestTypePut: {
            [manager PUT:req.url parameters:req.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestSuccess:responseObject task:task req:req];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestError:error task:task];
            }];
        }
            break;
        case kRequestTypePatch: {
            [manager PATCH:req.url parameters:req.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestSuccess:responseObject task:task req:req];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestError:error task:task];
            }];
        }
            break;
        case kRequestTypeDelete: {
            [manager DELETE:req.url parameters:req.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestSuccess:responseObject task:task req:req];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestError:error task:task];
            }];
        }
            break;
        default: {
            //unsurpport type
            return;
        }
            break;
    }
}

- (void)handleRequestSuccess:(id)response task:(NSURLSessionDataTask *)task req:(LYTAFRequest *)req{
    
    if ([req respondsToSelector:@selector(ResponseSuccess:)]) {
        [req ResponseSuccess:response];
    }
    //    if (!response) {
    //        [[NSNotificationCenter defaultCenter] postNotificationName:requestSuccess object:nil];
    //    }
    //    else{
    //        [[NSNotificationCenter defaultCenter] postNotificationName:requestSuccess object:nil userInfo:@{@"response":response}];
    //    }
    
    //    if (!response) return;
    if (_serverResponse != nil) {
        _serverResponse(nil);
    }
}


- (void)handleProgress:(NSProgress *)progress {
    NSLog(@"download progress is %f",progress.fractionCompleted);
}

- (void)handleRequestError:(NSError *)error task:(NSURLSessionDataTask *)task{
    
    NSInteger statusCode = ((NSHTTPURLResponse*)task.response).statusCode;
    if(statusCode == 200){
        _serverResponse(nil);
        return;
    }
    
    NSData* data = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
    if (data) {
        id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];//[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSString* msg = [responseObject objectForKey:@"msg"];
        NSNumber* code = [responseObject objectForKey:@"code"];
        if (!code) {
            code = [responseObject objectForKey:@"errorCode"];
        }
        if (!msg) {
            msg = [responseObject objectForKey:@"errorMsg"];
        }
        if(statusCode == 401
           && code.intValue == 33){
            LYTAlertView *Alert = [[LYTAlertView alloc] initWithText:@"登录失效，请重新登录" cancelButton:nil confirmButton:nil];
            [Alert show];
//            [AppDelegate popToLoginView:YES];
            return;
        }
        else if (statusCode == 400 && code.intValue == 9999){
            LYTAlertView *Alert = [[LYTAlertView alloc] initWithText:msg cancelButton:nil confirmButton:nil];
            [Alert show];
//            [AppDelegate popToLoginView:YES];
            return;
        }
        if (msg) {
            LYTAlertView *Alert = [[LYTAlertView alloc] initWithText:msg cancelButton:nil confirmButton:nil];
            [Alert show];
            NSLog(@"error msg: %@", msg);
            if (_serverResponse != nil) {
                _serverResponse(error);
            }
            return;
        }
    }
    if (statusCode == 0) {
//        LYTAlertView *Alert = [[LYTAlertView alloc] initWithText:@"网络有点慢，请稍后再试~" cancelButton:nil confirmButton:nil];
//        [Alert show];
    }
    else{
        LYTAlertView *Alert = [[LYTAlertView alloc] initWithText:@"数据异常" cancelButton:nil confirmButton:nil];
        [Alert show];
    }
    
    NSLog(@"request error %@",error.localizedDescription);
    if (_serverResponse != nil) {
        _serverResponse(error);
    }
    //    LYTAlertView *Alert = [[LYTAlertView alloc] initWithText:@"数据异常" cancelButton:nil confirmButton:nil];
    //    [Alert show];
}

//- (void)configureExtralHttpHeadField:(AFHTTPSessionManager *)manager {
//    NSString* id = [AccountMgr instance].id;
//    NSString* token = [AccountMgr instance].token;
//    if (id && token) {
//        NSString *authStr = [NSString stringWithFormat:@"%@ %@", id, token];
//        [manager.requestSerializer setValue:authStr forHTTPHeaderField:@"Authorization"];
//    }
//    for (NSString *keypath in _extralHTTPHeaderField) {
//        [manager.requestSerializer setValue:_extralHTTPHeaderField[keypath] forHTTPHeaderField:keypath];
//    }
//}

- (void)dealloc {
    
}

@end
