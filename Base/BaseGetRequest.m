//
//  BaseGetRequest.m
//  YTKNetworking
//
//  Created by 念 on 16/4/25.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import "BaseGetRequest.h"

@implementation BaseGetRequest
{
    NSString *_url;
    NSDictionary *_parmer;
    YTKRequestMethod _method;
}

- (instancetype)initWithUrl:(NSString *)url parmer:(NSDictionary *)parmer method:(YTKRequestMethod)method
{
    self = [super init];
    if (self) {
        _url = url;
        _parmer = parmer;
        _method = method;
    }
    return self;
}

/// 请求成功的回调
- (void)requestCompleteFilter
{
    NSLog(@"菊花消失");
}

/// 请求失败的回调
- (void)requestFailedFilter
{
    NSLog(@"请求失败");
}

/// 请求的URL
- (NSString *)requestUrl
{
    return _url;
}

/// 请求的连接超时时间，默认为60秒
- (NSTimeInterval)requestTimeoutInterval
{
    return 8;
}

/// 请求的参数列表
- (id)requestArgument;
{
    return _parmer;
}

/// Http请求的方法
- (YTKRequestMethod)requestMethod
{
    return _method;
}

/// 请求的SerializerType
- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

-(id)responseJSONObject
{
    id data = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"data = %@",data);
    return data;
}

@end
