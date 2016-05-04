//
//  NNSearchBar.h
//  HappyWeather
//
//  Created by 念 on 16/4/16.
//  Copyright © 2016年 小念. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNSearchBar : UIView <UITextFieldDelegate>

+ (NNSearchBar *)setNNSearchBar;

- (void)searchDelegate;

@property (weak, nonatomic) IBOutlet UITextField *searchText;

@property (nonatomic,copy) void (^searchBarBlock)(NSString *searchText);


@end
