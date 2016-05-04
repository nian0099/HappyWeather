//
//  FMDataHandle.m
//  HappyWeather
//
//  Created by 念 on 16/4/19.
//  Copyright © 2016年 小念. All rights reserved.
//

#import "FMDataHandle.h"
#import "FMResultSet.h"
#import "AddCityViewController.h"

//静态设置
static FMDatabase *_fmdb;
static FMDataHandle *_fmHandel;
@implementation FMDataHandle

//初始化单例类
+(FMDataHandle *)sharedFMDataHandele
{
    if (!_fmHandel) {
        _fmHandel = [[FMDataHandle alloc] init];
    }
    return _fmHandel;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (!_fmHandel) {
        _fmHandel = [super allocWithZone:zone];
        [_fmHandel initDB];
    }
    return _fmHandel;
}
-(id)mutableCopy{
    return self;
}

-(id)copy{
    return self;
}

- (void)initDB
{
    NSString *docmentpath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [docmentpath stringByAppendingPathComponent:@"city.sqlite"];
    NSLog(@"%@",path);
    _fmdb = [[FMDatabase alloc]initWithPath:path];
    if ([_fmdb open]) {
        [_fmdb executeUpdate:@"CREATE TABLE citys(ids INTEGER PRIMARY KEY AUTOINCREMENT, city TEXT, temperature TEXT , wind TEXT)"];
        
        
        [_fmdb close];
        
    }else{
        
        NSLog(@"数据表创建失败");
        
    }

}

- (void)insertCity:(AddCity *)cityInsert
{
    BOOL is = false;
    NSArray *arr = [self getAll];
    for (AddCity *c in arr)
    {
        
        if ([c.city isEqualToString:cityInsert.city])
        {
            is = true;
            
        }
    }
    if (is)
    {
//        NSLog(@"数据相同8888888888");
//        //        [[NSNotificationCenter defaultCenter]postNotificationName:@"zhangyu3" object:addCity.city];
    }
    else
    {
        [_fmdb open];
        BOOL isb = [_fmdb executeUpdate:@"insert into citys VALUES(null,?,?,?)",cityInsert.city,cityInsert.temperature,cityInsert.wind];
        if (isb)
        {
            NSLog(@"添加成功");
        }
        else
        {
            NSLog(@"添加失败");
        }
    }
        [_fmdb close];
}

- (void)deleteCity:(AddCity *)cityDelete
{
    [_fmdb open];
    NSString * sql=[NSString  stringWithFormat:@"DELETE FROM citys WHERE ids =%ld",cityDelete.IDs];
    
    BOOL isb = [_fmdb executeUpdate:sql];
    if (isb) {
        NSLog(@"删除成功");
        
    }else{
        NSLog(@"删除失败");
    }
    [_fmdb close];

}

- (NSMutableArray *)getAll
{
    NSMutableArray *arr = [NSMutableArray array];
    [_fmdb open];
    FMResultSet *fmset = [[FMResultSet alloc]init];
    fmset = [_fmdb executeQuery:@"select * from citys"];
    while ([fmset next]) {
        NSInteger IDs = [fmset intForColumn:@"ids"];
        NSString *city = [fmset stringForColumn:@"city"];
        NSString *temperature = [fmset stringForColumn:@"temperature"];
        NSString *wind = [fmset stringForColumn:@"wind"];
        AddCity *ci = [[AddCity alloc]init];
        ci.IDs = IDs;
        ci.city = city;
        ci.temperature = temperature;
        ci.wind = wind;
        NSLog(@"dis===%ld",IDs);
        
        [arr addObject:ci];
    }
    [_fmdb close];
    return arr;
}

@end
