//
//  CityURLDataHandel.h
//  HappyWeather
//
//  Created by 念 on 16/4/18.
//  Copyright © 2016年 小念. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityURLDataHandel : NSObject

+ (instancetype)sharedDataHandle;

- (void)request: (NSString*)httpUrl;

@property (nonatomic,copy) void (^CityNameBlock)(id,BOOL);
@end
