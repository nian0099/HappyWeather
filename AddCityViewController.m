//
//  AddCityViewController.m
//  HappyWeather
//
//  Created by 念 on 16/4/15.
//  Copyright © 2016年 小念. All rights reserved.
//

#import "AddCityViewController.h"
#import "BaseViewController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
#import "cityCollectionViewCell.h"
#import "NNSearchBar.h"
#import "headCollectionReusableView.h"
#import "CityURLDataHandel.h"
#import "RootViewController.h"
#import "FMDataHandle.h"
#import <AMapLocationKit/AMapLocationManager.h>
#import <AMapLocationKit/AMapLocationServices.h>
#import <AMapSearchKit/AMapSearchObj.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchKit.h>


@interface AddCityViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,AMapLocationManagerDelegate,AMapSearchDelegate>
{
    NSString *name;
    AMapSearchAPI *_search;
}
@property (nonatomic,strong) AMapLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) CityURLDataHandel *CityURL;
@property (nonatomic,strong) RootViewController *root;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) NSArray *cityHotArr;
@property (nonatomic,strong) NSArray *cityArr;
@property (nonatomic,assign) BOOL *isSearch;
@property (nonatomic,strong) NSArray *cityNameArr;
@end


static NSString  *cellId = @"cityCollectionViewCell";
@implementation AddCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NNSearchBar *search = [NNSearchBar setNNSearchBar];
    [search searchDelegate];
    search.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 120, 40);
    search.searchBarBlock = ^(NSString *searchText){
        NSLog(@"searchtext = %@",searchText);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image_ouba"]];
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    self.searchBar.placeholder = @"请输入城市：例如（北京市）";
    self.searchBar.delegate = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.navigationItem.titleView = self.searchBar;
    [self setLeftBarButton:@"返回"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"cityCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellId];
    _cityHotArr = [NSArray arrayWithObjects:@"定位",@"北京市",@"上海市",@"广州市",@"深圳市",@"南京市",@"天津市",@"重庆市",@"大连市",@"长春市",@"长沙市",@"郑州市",@"合肥市",@"沈阳市",@"武汉市",@"哈尔滨市",@"太原市",@"杭州市",@"嘉兴市",@"济南市",@"海口",@"昆明市",@"拉萨市 ",@"呼和浩特", nil];
    
//    _cityArr = [NSArray arrayWithObjects:@"北京",@"上海",@"砀山",@"北京",@"上海",@"砀山",@"北京",@"上海",@"砀山",@"北京",@"上海",@"砀山",@"北京",@"上海",@"砀山",@"北京",@"上海",@"砀山",@"北京",@"上海",@"砀山", nil];
    //设置布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.headerReferenceSize = CGSizeMake(40, 40);
    [self.collectionView registerClass:[headCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
//    [CityURLDataHandel sharedDataHandle].CityNameBlock = ^(id obj,BOOL flag){
//        self.cityNameArr =  obj;
//        NSLog(@"%@",obj);
//        NSDictionary *retData = [obj objectForKey:@"retData"];
//        NSLog(@"%@",retData);
////        NSArray *name_cn = [retData valueForKey:@"name_cn"];
////        NSLog(@"name_cn = %@",name_cn);
//        NSLog(@"CityNameArr = %@",self.cityNameArr);
//    };
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.cityHotArr.count;
    
//    if (section == 0)
//    {
//        return self.cityHotArr.count;
//    }else{
//        return self.cityArr.count;
//    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//    if (indexPath.section == 0)
//    {
//    [cell.cityLabel setText:self.cityHotArr[indexPath.row]];
//    }else if (indexPath.section == 1)
//    {
//    [cell.cityLabel setText:self.cityArr[indexPath.row]];
//        
//    }
    
    cell.cityLabel.text = self.cityHotArr[indexPath.row];
    cell.cityLabel.layer.cornerRadius = 20;
    cell.cityLabel.layer.borderColor = [UIColor grayColor].CGColor;
    cell.cityLabel.layer.borderWidth = 1.0f;
    cell.cityLabel.textColor = [UIColor whiteColor];
    cell.cityLabel.font = [UIFont boldSystemFontOfSize:13];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDMenuController *ddmc = (DDMenuController *)((AppDelegate *)[UIApplication sharedApplication].delegate).DDMenuController;
    [ddmc showRootController:YES];
    if (indexPath.row == 0) {
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

    }
    cityCollectionViewCell *cell = (cityCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"cell.cityLabel.text=%@",cell.cityLabel.text);
    if ([self.searchBar.text isEqualToString:@""]) {
        self.searchBar.text = cell.cityLabel.text;
        name = [[NSMutableString alloc] init];
        name = self.searchBar.text;
        NSLog(@"name%@",name);
        name = [name stringByReplacingOccurrencesOfString:@"区" withString: @""];
        name = [name stringByReplacingOccurrencesOfString:@"市" withString: @""];
        name = [name stringByReplacingOccurrencesOfString:@"县" withString: @""];
        NSLog(@"name2%@",name);

        [[CityURLDataHandel sharedDataHandle]request:name];
        NSLog(@"searchBar%@",self.searchBar.text);
    }
    //发送通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification" object:self.searchBar.text];

    if (_TextBlock) {
        _TextBlock(self.searchBar.text);
    }
//    NSLog(@"cell.cityLabel.text=%@",cell.cityLabel.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    DDMenuController *ddmc = (DDMenuController *)((AppDelegate *)[UIApplication sharedApplication].delegate).DDMenuController;
    [ddmc showRootController:YES];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification" object:self.searchBar.text];
    NSLog(@"searchBar%@",self.searchBar.text);
    name = [[NSMutableString alloc] init];
    name = self.searchBar.text;
    NSLog(@"name%@",name);
    name = [name stringByReplacingOccurrencesOfString:@"区" withString: @""];
    name = [name stringByReplacingOccurrencesOfString:@"市" withString: @""];
    name = [name stringByReplacingOccurrencesOfString:@"县" withString: @""];
    [[CityURLDataHandel sharedDataHandle]request:name];
    if (_TextBlock) {
        _TextBlock(self.searchBar.text);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *headerId = @"header";
    
    headCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
    
    if (indexPath.section==0) {
        header.headLabel.text = @"热门城市";
    }
    else{
        
        header.headLabel.text =@"所有城市";
    }
    
    return header;
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

@end
