//
//  AddCityViewController.h
//  HappyWeather
//
//  Created by 念 on 16/4/15.
//  Copyright © 2016年 小念. All rights reserved.
//

#import "BaseViewController.h"

@interface AddCityViewController : BaseViewController

@property (nonatomic,copy) void (^TextBlock)(NSString *);

@end
