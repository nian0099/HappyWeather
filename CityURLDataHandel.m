//
//  CityURLDataHandel.m
//  HappyWeather
//
//  Created by 念 on 16/4/18.
//  Copyright © 2016年 小念. All rights reserved.
//

#import "CityURLDataHandel.h"
#import "AFHTTPSessionManager.h"
#import "BaseGetRequest.h"

@implementation CityURLDataHandel

static  CityURLDataHandel *_sharedURLDataHandle = nil;

#pragma mark - 单例方法 -
+(instancetype)sharedDataHandle
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedURLDataHandle = [[CityURLDataHandel alloc]init];
    });
    
    return _sharedURLDataHandle;
}

//重写allocWithZone:方法
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (_sharedURLDataHandle == nil) {
        _sharedURLDataHandle = [super allocWithZone:zone];
    }
    return _sharedURLDataHandle;
}

-(void)request: (NSString*)httpUrl
{
//    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@%@%@", CITY_URL,httpUrl,CITY_URL2];
//    
//    NSLog(@"urlstr%@",urlStr);
//    
//    NSString *str =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSURL *url = [NSURL URLWithString:str];
//    
//    NSLog(@"=====%@",url);
//    
//    
//    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
//    
//    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
//    
//    [manager.requestSerializer setValue:APP_KEY forHTTPHeaderField:@"apikey"];
//    [manager GET:str parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSDictionary *obj = responseObject;
//        NSLog(@"obj = %@",obj);
//        
////        dispatch_async(dispatch_get_main_queue(), ^{
////            self.CityNameBlock(obj,YES);
////        });
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"nian" object:obj];
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"error%@",error);
//    }];
    
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"/telematics/v3/weather?location=%@%@",httpUrl,CITY_URL2];
    
    NSLog(@"urlstr%@",urlStr);
    
    NSString *str =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    BaseGetRequest *base = [[BaseGetRequest alloc] initWithUrl:url.absoluteString parmer:nil method:YTKRequestMethodGet];
    [base startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        NSLog(@"%@",request.responseJSONObject);
        NSDictionary *obj = request.responseJSONObject;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"nian" object:obj];

    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
    
//    NSLog(@"%@",urlStr);
//    NSString *str =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString: str];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
//    [request setHTTPMethod: @"GET"];
//    [request addValue:APP_KEY forHTTPHeaderField: @"apikey"];
//    [NSURLConnection sendAsynchronousRequest: request
//                                       queue: [NSOperationQueue mainQueue]
//                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
//    if (error) {
//        NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
//        } else {
//            NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"HttpResponseCode:%ld", responseCode);
//            NSLog(@"HttpResponseBody %@",responseString);
//            NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.CityNameBlock(obj,YES);
//            });
//                }
//        }];
    
}

@end
