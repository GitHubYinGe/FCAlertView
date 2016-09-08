//
//  ViewController.m
//  demo
//
//  Created by 李再民 on 16/9/7.
//  Copyright © 2016年 FengChe. All rights reserved.
//

#import "ViewController.h"
#import "FCAlertView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
  
}
                    
- (IBAction)btnClick:(id)sender {
    

    [FCAlertView FCAlertWithTitle:@"" cancelName:@"" determineName:@"" preferredStyle:FCAlertStyleStyleAlert cancel:^{
        NSLog(@"1111111");
        
    } determine:^{
        
        NSLog(@"2222222");
    }];
        
   
}
- (IBAction)bottomBtnClick:(id)sender {
    
    [FCAlertView FCAlertWithTitle:@"" cancelName:@"" determineName:@"" preferredStyle:FCAlertStyleStyleActionSheet cancel:^{
        NSLog(@"1111111");
        
    } determine:^{
        
        NSLog(@"2222222");
    }];

}



- (IBAction)textFieldBtnClick:(id)sender {
    
    
    __block NSString *str = @"";
    [FCAlertView FCAlertAddTextFieldWithTitle:@"" cancelName:@"" determineName:@"" textFIeld:^(UITextField *textField) {
        
        str = textField.text;
        NSLog(@"1111111---------%@",str);
    } cancel:^{
        NSLog(@"2222222---------%@",str);
        
    } determine:^{
        NSLog(@"3333333---------%@",str);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
