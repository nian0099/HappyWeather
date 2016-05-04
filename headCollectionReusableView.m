//
//  headCollectionReusableView.m
//  HappyWeather
//
//  Created by 念 on 16/4/18.
//  Copyright © 2016年 小念. All rights reserved.
//

#import "headCollectionReusableView.h"

@implementation headCollectionReusableView

- (UILabel *)headLabel
{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 3 * 1.3, 50, [UIScreen mainScreen].bounds.size.width / 3 * 1, 30)];
        _headLabel.textColor = [UIColor whiteColor];
        _headLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    return _headLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.headLabel];
    }
    return self;
}

@end
