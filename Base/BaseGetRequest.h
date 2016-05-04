//
//  BaseGetRequest.h
//  YTKNetworking
//
//  Created by 念 on 16/4/25.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface BaseGetRequest : YTKBaseRequest

- (instancetype)initWithUrl:(NSString *)url parmer:(NSDictionary *)parmer method:(YTKRequestMethod)method;

@end
