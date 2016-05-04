//
//  BaseViewController.h
//  HappyWeather
//
//  Created by 念 on 16/4/15.
//  Copyright © 2016年 小念. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


#pragma mark - 返回按钮文字样式
- (void)setLeftBarButton:(NSString *)barName;

- (void)popVCLeftBarButtonAction:(UIBarButtonItem *)button;

@end
