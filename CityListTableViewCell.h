//
//  CityListTableViewCell.h
//  HappyWeather
//
//  Created by 念 on 16/4/15.
//  Copyright © 2016年 小念. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface CityListTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;

- (void)tableViewCityLabel:(NSString *)city windLabel:(NSString *)windLabel temperatureLabel:(NSString *)temperatureLabel;
@end
