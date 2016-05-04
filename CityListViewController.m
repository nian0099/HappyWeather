//
//  CityListViewController.m
//  HappyWeather
//
//  Created by 念 on 16/4/15.
//  Copyright © 2016年 小念. All rights reserved.
//

#import "CityListViewController.h"
#import "CityListTableViewCell.h"
#import "AddCityViewController.h"
#import "DDMenuController.h"
#import "BaseNavigationViewController.h"
#import "AddCity.h"
#import "FMDataHandle.h"
#import "CityURLDataHandel.h"
#import "AppDelegate.h"


static NSString *cellId = @"CityListTableViewCell";
@interface CityListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arr;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableLayerOut;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    AddCityViewController *addCity = [[AddCityViewController alloc] init];
    self.title = @"我的城市";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CityListTableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
//    [self setLeftBarButton:@"返回"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddCity:)];
    self.tableLayerOut.constant = [UIScreen mainScreen].bounds.size.width / 3;
    arr = [NSMutableArray array];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image_list"]];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    arr = [[FMDataHandle sharedFMDataHandele]getAll];
    NSLog(@"%@",arr);
    [_tableView reloadData];
}

- (void)AddCity:(UIBarButtonItem *)button
{
    AddCityViewController *add = [[AddCityViewController alloc] init];
    BaseNavigationViewController * nav = [[BaseNavigationViewController alloc] initWithRootViewController:add];
//    add.TextBlock = ^(NSString *str){
//        self.title = str;
//        NSLog(@"title===%@",str);
//    };
    
//    if (_TextBlock2) {
//        self.TextBlock2(self.title);
//    }
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    AddCity *city = [arr objectAtIndex:indexPath.row];
//    cell.textLabel.text = city.city;
    [cell tableViewCityLabel:city.city windLabel:city.wind temperatureLabel:city.temperature];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

//侧滑删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    AddCity *city = [arr objectAtIndex:indexPath.row];
    [[FMDataHandle sharedFMDataHandele]deleteCity:city];
    [arr removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
//    [menu showRootController:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//设置编辑风格
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//设置删除按钮上的标题
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddCity *city = [arr objectAtIndex:indexPath.row];
    [[CityURLDataHandel sharedDataHandle]request:city.city];
    if (_TextBlock2) {
        _TextBlock2(city.city);
    }
    DDMenuController *ddmc = (DDMenuController *)((AppDelegate *)[UIApplication sharedApplication].delegate).DDMenuController;
    [ddmc showRootController:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
