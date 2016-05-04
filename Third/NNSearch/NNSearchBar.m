//
//  NNSearchBar.m
//  HappyWeather
//
//  Created by 念 on 16/4/16.
//  Copyright © 2016年 小念. All rights reserved.
//

#import "NNSearchBar.h"

@implementation NNSearchBar

//初始化

+ (NNSearchBar *)setNNSearchBar
{
    NNSearchBar *search = [[NSBundle mainBundle] loadNibNamed:@"NNSearchBar" owner:nil options:nil][0];
    return search;
}

- (void)searchDelegate
{
    self.searchText.delegate = self;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 2;
    [self.layer masksToBounds];
}

- (IBAction)searchBtnAction:(id)sender {
    if ([self.searchText.text isEqualToString:@""]) {
        [self.searchText becomeFirstResponder];
        NSLog(@"%@",self.searchText.text);
        NSLog(@"地址不能为空");
        return;
    }
    if (_searchBarBlock) {
        self.searchBarBlock(self.searchText.text);
    }
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFiled = %@",textField.text);
}

@end
