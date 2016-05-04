//
//  RootViewController.m
//  HappyWeather
//
//  Created by 念 on 16/4/15.
//  Copyright © 2016年 小念. All rights reserved.
//

#import "RootViewController.h"

#import "BaseNavigationViewController.h"
#import "CityListViewController.h"
#import "AddCityViewController.h"
#import "CityURLDataHandel.h"
#import "AddCity.h"
#import "FMDataHandle.h"
#import <AMapLocationKit/AMapLocationManager.h>
#import <AMapLocationKit/AMapLocationServices.h>
#import <AMapSearchKit/AMapSearchObj.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <MJRefresh.h>

@interface RootViewController ()<AMapLocationManagerDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>
{
    AMapSearchAPI *_search;
    UITableView *table;
    NSString *blockTitle;
    NSArray *weatherDataArr;
    NSArray *detailArr;
    NSDictionary *index;
    NSString *dress;
    NSString *dressKind;
    NSString *washCar;
    NSString *washCarKind;
    NSString *trip;
    NSString *tripKind;
    NSString *sport;
    NSString *sportKind;
    NSString *purpleline;
    NSString *purplelineKind;
    
}
@property (nonatomic,strong) AMapLocationManager *locationManager;
@property (nonatomic,strong) CityListViewController *listView;
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *temperature;
@property (nonatomic,strong) NSString *pm25;
@property (nonatomic,strong) NSString *currentCity;
@property (nonatomic,strong) NSString *cold;
@property (nonatomic,strong) NSString *dateWeek;
@property (nonatomic,strong) NSString *wind;
@property (nonatomic,strong) NSString *coldKind;
@property (nonatomic,strong) NSString *weather;
@property (nonatomic,strong) NSString *coldExponent;
@property (nonatomic,strong) NSString *kindly;
@property (nonatomic,strong) NSString *weather2;
@property (nonatomic,strong) NSString *wind2;
@property (nonatomic,strong) NSString *dateWeek2;
@property (nonatomic,strong) NSString *temperature2;
@property (nonatomic,strong) NSString *weather3;
@property (nonatomic,strong) NSString *wind3;
@property (nonatomic,strong) NSString *dateWeek3;
@property (nonatomic,strong) NSString *temperature3;
@property (nonatomic,strong) NSString *weather4;
@property (nonatomic,strong) NSString *wind4;
@property (nonatomic,strong) NSString *dateWeek4;
@property (nonatomic,strong) NSString *temperature4;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image_yueliang"]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image_BBck"]];
    self.title = @"当前城市";
//    NSMutableArray *tempArr = [NSMutableArray array];
    UIImageView *imgBack = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imgBack.image = [UIImage imageNamed:@"image_BBck"];
    //设置动画播放图片
//    for (int i = 1; i < 5; i++) {
//        NSString *strImage = [NSString stringWithFormat:@"%d.JPG",i];
//        
//        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:strImage ofType:nil]];
//        
//        [tempArr addObject:image];
//    }
//    imgBack.animationImages = tempArr;
//    imgBack.animationDuration = 15;
//    imgBack.animationRepeatCount = 0;
    imgBack.userInteractionEnabled = YES;
//    [imgBack startAnimating];
    [self.view addSubview:imgBack];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds .size.width, [UIScreen mainScreen].bounds .size.height-70) style:UITableViewStylePlain];
//    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    table.backgroundColor = [UIColor clearColor];
    table.rowHeight = 70;
    [self.view addSubview:table];
    
//    table.delegate = self;
//    
//    table.dataSource = self;
//
//    [table reloadData];
    //注册通知，监听传递数据
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Notification:) name:@"Notification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Notifica:) name:@"nian" object:nil];

    //初始化地位信息
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    //开始连续定位,调用此方法会cancel掉所有的单次定位请求
    [self.locationManager startUpdatingLocation];
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    //遵守协议
    _search.delegate = self;
    
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.3];

    //下拉刷新
    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        AddCity *cc = [[AddCity alloc] init];
        [[CityURLDataHandel sharedDataHandle]request:cc.city];
        [table.mj_header endRefreshing];
        [table reloadData];
    }];
    //上拉加载
//    table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        AddCity *cc = [[AddCity alloc] init];
//        [[CityURLDataHandel sharedDataHandle]request:cc.city];
//        [table.mj_footer endRefreshing];
//        [table reloadData];
//    }];

    // 带逆地理信息的一次定位（返回坐标和地址信息）
//    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
//       定位超时时间，可修改，最小2s
//    self.locationManager.locationTimeout = 5;
//       逆地理请求超时时间，可修改，最小2s
//    self.locationManager.reGeocodeTimeout = 5;
//
    //带逆地理（返回坐标和地址信息）
//    [self.locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//        
//        if (error)
//        {
//            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
//            
//            if (error.code == AMapLocationErrorLocateFailed)
//            {
//                return;
//            }
//        }
//        
//        NSLog(@"location:%@", location);
//        
//        if (regeocode)
//        {
//            NSLog(@"reGeocode:%@", regeocode);
//        }
//    }];
    
}

-(void)delayMethod
{
    [self.locationManager stopUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    //初始化逆地理编码请求
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    //接收实时位置
    regeo.location = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    //返回扩展信息
    regeo.requireExtension = YES;
    //发起逆地理编码
    [_search AMapReGoecodeSearch:regeo];

}


/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    //精确到县
    NSLog(@"====%@",response.regeocode.addressComponent.district);
//    if (_CityLocationBlock) {
//        self.CityLocationBlock(response.regeocode.addressComponent.district);
//    }
    NSString *str = [[NSMutableString alloc] init];
    str = response.regeocode.addressComponent.district;
    str = [str stringByReplacingOccurrencesOfString:@"区" withString: @""];
    str = [str stringByReplacingOccurrencesOfString:@"市" withString: @""];
    str = [str stringByReplacingOccurrencesOfString:@"县" withString: @""];

    [[CityURLDataHandel sharedDataHandle]request:str];

    
}



- (void)Notifica:(NSNotification *)send
{
    NSDictionary *obj          = send.object;
    NSDictionary *retData      = [obj objectForKey:@"results"][0];
//    NSLog(@"retData = %@",retData);
    if (retData != nil)
    {
        NSString     *datettt         = [obj objectForKey:@"date"];
        NSLog(@"date = %@",datettt);
        
        NSDictionary *weather_data = [retData valueForKey:@"weather_data"][0];
        //    NSLog(@"weather_data = %@",weather_data);
        
        _weather          = [weather_data valueForKey:@"weather"];
        NSLog(@"weather = %@",_weather);
        
        _wind             = [weather_data valueForKey:@"wind"];
        NSLog(@"wind = %@",_wind);
        
        _temperature      = [weather_data valueForKey:@"temperature"];
        NSLog(@"temperature = %@",_temperature);
        
        _dateWeek             = [weather_data valueForKey:@"date"];
        NSLog(@"dateWeek = %@",_dateWeek);
        
        NSDictionary *weather_data2 = [retData valueForKey:@"weather_data"][1];
        
        _weather2          = [weather_data2 valueForKey:@"weather"];
        
        _wind2             = [weather_data2 valueForKey:@"wind"];
        
        _temperature2      = [weather_data2 valueForKey:@"temperature"];
        
        _dateWeek2         = [weather_data2 valueForKey:@"date"];
        
        NSDictionary *weather_data3 = [retData valueForKey:@"weather_data"][2];
        
        _weather3          = [weather_data3 valueForKey:@"weather"];
        
        _wind3             = [weather_data3 valueForKey:@"wind"];
        
        _temperature3      = [weather_data3 valueForKey:@"temperature"];
        
        _dateWeek3         = [weather_data3 valueForKey:@"date"];
        
        NSDictionary *weather_data4 = [retData valueForKey:@"weather_data"][3];
        
        _weather4          = [weather_data4 valueForKey:@"weather"];
        
        _wind4             = [weather_data4 valueForKey:@"wind"];
        
        _temperature4      = [weather_data4 valueForKey:@"temperature"];
        
        _dateWeek4         = [weather_data4 valueForKey:@"date"];
        
        _currentCity  = [retData valueForKey:@"currentCity"];
        NSLog(@"currentCity = %@",_currentCity);
        
        _pm25         = [retData valueForKey:@"pm25"];
        NSLog(@"pm25 = %@",_pm25);
        
        index        = [retData valueForKey:@"index"][0];
        
        dress             = [index valueForKey:@"tipt"];
        NSLog(@"tipt = %@",dress);
        
        dressKind              = [index valueForKey:@"des"];
        NSLog(@"des = %@",dressKind);

        index        = [retData valueForKey:@"index"][1];
        
        washCar             = [index valueForKey:@"tipt"];
        NSLog(@"tipt = %@",washCar);
        
        washCarKind              = [index valueForKey:@"des"];
        NSLog(@"des = %@",washCarKind);

        index        = [retData valueForKey:@"index"][2];
        
        trip             = [index valueForKey:@"tipt"];
        NSLog(@"tipt = %@",trip);
        
        tripKind              = [index valueForKey:@"des"];
        NSLog(@"des = %@",tripKind);

        index        = [retData valueForKey:@"index"][3];
        
        _cold            = [index valueForKey:@"tipt"];
        NSLog(@"tipt = %@",_cold);
        
        _coldKind              = [index valueForKey:@"des"];
        NSLog(@"des = %@",_coldKind);

        index        = [retData valueForKey:@"index"][4];
        
        sport             = [index valueForKey:@"tipt"];
        NSLog(@"tipt = %@",sport);
        
        sportKind              = [index valueForKey:@"des"];
        NSLog(@"des = %@",sportKind);
        
        index        = [retData valueForKey:@"index"][5];
        
        purpleline             = [index valueForKey:@"tipt"];
        NSLog(@"tipt = %@",purpleline);
        
        purplelineKind              = [index valueForKey:@"des"];
        NSLog(@"des = %@",purplelineKind);

    }
    weatherDataArr = [NSArray arrayWithObjects:self.weather,self.dateWeek,dress,washCar,trip,_cold,sport,purpleline,self.dateWeek2,self.dateWeek3,self.dateWeek4, nil];
    detailArr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",self.wind],self.temperature,dressKind,washCarKind,tripKind,_coldKind,sportKind,purplelineKind,[NSString stringWithFormat:@"%@    %@     %@",self.weather2,self.wind2,self.temperature2],[NSString stringWithFormat:@"%@    %@     %@",self.weather3,self.wind3,self.temperature3],[NSString stringWithFormat:@"%@    %@     %@",self.weather4,self.wind4,self.temperature4], nil];
    AddCity *m = [[AddCity alloc]init];
    m.city = self.currentCity;
    m.temperature = self.temperature;
    m.wind = self.wind;
    NSLog(@"m.temperature = %@",m.temperature);
    [[FMDataHandle sharedFMDataHandele]insertCity:m];
//    if (retData != nil)
//    {
//             city  = [retData objectForKey:@"city"];
//        _cityCode  = [retData objectForKey:@"citycode"];
//          _h_temp  = [retData objectForKey:@"h_tmp"];
//          _t_temp  = [retData objectForKey:@"l_tmp"];
////       _longitude  = [retData objectForKey:@"longitude"];
////        _latitude  = [retData objectForKey:@"latitude"];
//        _date      = [retData objectForKey:@"date"];
//        _pinyin    = [retData objectForKey:@"pinyin"];
//        _WD        = [retData objectForKey:@"WD"];
//        _WS        = [retData objectForKey:@"WS"];
//        _sunset    = [retData objectForKey:@"sunset"];
//        _sunrise   = [retData objectForKey:@"sunrise"];
//        _weather   = [retData objectForKey:@"weather"];
//       
//        NSLog(@"city==%@",city);
//        
//    }

    
    self.title = self.currentCity;
    

    
    table.delegate = self;
    
    table.dataSource = self;
    
    [table reloadData];
    NSLog(@"%@",weatherDataArr);
    
    

}

//- (void)Notification:(NSNotification *)sender
//{
//    //接收通知
//    self.title = sender.object;
//
////    CityURLDataHandel *city2 =[[CityURLDataHandel alloc]init];
////    city2.CityNameBlock =^(id obj,BOOL flag)
////    {
////        NSLog(@"obj=======%@",obj);
////    };
////    [CityURLDataHandel sharedDataHandle].CityNameBlock = ^(id obj,BOOL flag){
////        NSLog(@"%@",obj);
////        NSDictionary *retData = [obj objectForKey:@"retData"];
////        NSLog(@"retData==========%@",retData);
////        if (retData != nil) {
////            city = [retData objectForKey:@"city"];
////            NSLog(@"city==%@",city);
////        }
////    };
//
//    
//}

-(void)viewWillAppear:(BOOL)animated
{
    [table reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 表格方法 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return weatherDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    [cell.detailTextLabel setNumberOfLines:5];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = weatherDataArr[indexPath.row];
    cell.detailTextLabel.text = detailArr[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    NSArray *imageArr = [NSArray arrayWithObjects:@"image_weather",@"image_ temperature",@"image_dress",@"image_washCar",@"image_trip",@"image_cold",@"image_sport",@"image_purline",@"image_weather",@"image_weather",@"image_weather",@"image_weather",nil];
    cell.imageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
//    NSArray *labArr = [NSArray arrayWithObjects:@"日出:",@"日落:",@"当前日期:",@"拼音:",@"风力:",@"天气情况:",@"城市编码:",@"风向:",@"最高气温:",@"最低气温:", nil];
//
//    NSArray *weatherDataArr = [NSArray arrayWithObjects:self.sunrise,self.sunset,self.date,self.pinyin,self.WD,self.weather,self.cityCode,self.WS,self.h_temp,self.t_temp, nil];
//    NSLog(@"");
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [table deselectRowAtIndexPath:indexPath animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
