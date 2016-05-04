//
//  FMDataHandle.h
//  HappyWeather
//
//  Created by 念 on 16/4/19.
//  Copyright © 2016年 小念. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "AddCity.h"


@interface FMDataHandle : NSObject

//初始化单例类
+ (FMDataHandle *)sharedFMDataHandele;


//增插
- (void)insertCity:(AddCity *)cityInsert;

//删除
- (void)deleteCity:(AddCity *)cityDelete;

//查
- (NSMutableArray *)getAll;
@end
