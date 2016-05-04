//
//  CityListTableViewCell.m
//  HappyWeather
//
//  Created by 念 on 16/4/15.
//  Copyright © 2016年 小念. All rights reserved.
//

#import "CityListTableViewCell.h"

@implementation CityListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)tableViewCityLabel:(NSString *)city windLabel:(NSString *)windLabel temperatureLabel:(NSString *)temperatureLabel
{
    self.cityLabel.text = [self stringIsNull:city];
    self.windLabel.text = [self stringIsNull:windLabel];
    NSString *str;
    if ([[self stringIsNull:temperatureLabel] isEqualToString:@""]) {
        str = @"0";
    }else{
        str = [self stringIsNull:temperatureLabel];
    }
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@",temperatureLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
