//
//  FCAlertView.m
//  demo
//
//  Created by 李再民 on 16/9/8.
//  Copyright © 2016年 FengChe. All rights reserved.
//

#import "FCAlertView.h"

#define FCScreenW [UIScreen mainScreen].bounds.size.width
#define FCScreenH [UIScreen mainScreen].bounds.size.height
#define FCColor(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface FCAlertView()<UITextFieldDelegate>

@property (nonatomic, copy) NSString *cancaelName;
@property (nonatomic, copy) NSString *determineName;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *dividerCenter;

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *dividerCenter1;
@property (nonatomic, strong) UIButton *determineBtn;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) void(^cancelBlock)();
@property (nonatomic, copy) void(^determineBlock)();
@property (nonatomic, copy) void(^setUpTextFieldBlock)(UITextField *textField);
@end

@implementation FCAlertView

static UIWindow *window_;

// 初始化
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self setUp];
    }

    return self;
}

- (void)setUp{
    
    // 头部文字
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = FCColor(249, 249, 249);
    [self addSubview:label];
    self.titleLabel = label;
    
    // 头部分割线
    UIView *dividerCenter = [[UIView alloc] init];
    dividerCenter.backgroundColor = FCColor(219, 219, 219);
    [self addSubview:dividerCenter];
    self.dividerCenter = dividerCenter;
    
    // 取消按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:FCColor(0, 122, 255) forState:UIControlStateNormal];
    [btn setTitleColor:FCColor(153, 153, 153) forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = FCColor(249, 249, 249);
    [self addSubview:btn];
    self.cancelBtn = btn;
    
    // 确定和取消分割线
    UIView *dividerCenter1 = [[UIView alloc] init];
    dividerCenter1.backgroundColor = FCColor(219, 219, 219);
    [self addSubview:dividerCenter1];
    self.dividerCenter1 = dividerCenter1;
    
    // 确定按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitleColor:FCColor(255, 59, 48) forState:UIControlStateNormal];
    [btn1 setTitleColor:FCColor(153, 153, 153) forState:UIControlStateHighlighted];
    btn1.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn1 addTarget:self action:@selector(determineBtnClick) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = FCColor(249, 249, 249);
    [self addSubview:btn1];
    self.determineBtn = btn1;
    
    // textField
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = self;
    [self addSubview:textField];
    self.textField = textField;
    
}

// 显示
+ (instancetype)showWithAlertViewStyle:(FCAlertStyle)style{
    
    // 创建窗口
    window_ = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window_.backgroundColor = [[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] colorWithAlphaComponent:0.5];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.frame = window_.frame;
    window_.rootViewController = vc;
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    
    FCAlertView *alertV = [[FCAlertView alloc] init];
    alertV.layer.cornerRadius = 10;
    alertV.layer.masksToBounds = YES;
    alertV.frame = CGRectMake(0, FCScreenH, 250, 100);
    
    
    
    if (style == FCAlertStyleStyleAlert) {
        
        CGFloat x = (FCScreenW - 250) / 2;
        CGFloat y = (FCScreenH - 100) / 2;
        alertV.frame = CGRectMake(x, FCScreenH, 250, 100);
        [UIView animateWithDuration:0.3 animations:^{
            
            alertV.frame = CGRectMake(x, y, 250, 100);
        }];
    } else{
        
        CGFloat x = 20;
        CGFloat y = FCScreenH - 150;
        CGFloat w = FCScreenW - 40;
        alertV.frame = CGRectMake(x, FCScreenH, w, 140);
        [UIView animateWithDuration:0.3 animations:^{
            
            alertV.frame =CGRectMake(x, y, w, 140);
        }];
        
        
    }
    
    
    
    [vc.view addSubview:alertV];
    
    return alertV;
}

+ (void)FCAlertWithTitle:(NSString *)title
                              cancelName:(NSString *)cancelName
                              determineName:(NSString *)determineName
                              preferredStyle:(FCAlertStyle)preferredStyle
                              cancel:(void (^)())cancel
                               determine:(void (^)())determine{
    
    FCAlertView *alertV = [FCAlertView showWithAlertViewStyle:preferredStyle];
    alertV.cancelBlock = cancel;
    alertV.determineBlock = determine;
    
    if (preferredStyle == FCAlertStyleStyleAlert) {
    
        alertV.titleLabel.frame = CGRectMake(0, 0, 250, 59.5);
        alertV.dividerCenter.frame = CGRectMake(0, 59.5, 250, 0.5);
        alertV.cancelBtn.frame = CGRectMake(0, 60, 124.75, 40);
        alertV.dividerCenter1.frame = CGRectMake(124.75, 60, 0.5, 39.5);
        alertV.determineBtn.frame = CGRectMake(125.25, 60, 124.75, 40);

    } else{
    
        alertV.titleLabel.frame = CGRectMake(0 , 0, FCScreenW - 40, 29.5);
        alertV.dividerCenter.frame = CGRectMake(0, 29.5, FCScreenW - 40, 0.5);
        alertV.cancelBtn.frame = CGRectMake(0, 30, FCScreenW - 40, 50);
        alertV.dividerCenter1.frame = CGRectMake(0, 1500, 0.5, 0.5);
        alertV.determineBtn.frame = CGRectMake(0, 90, FCScreenW - 40, 50);
        alertV.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        // 设置下面 左右圆角
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:alertV.cancelBtn.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0f, 10.0f}].CGPath;
        alertV.cancelBtn.layer.masksToBounds = YES;
        alertV.cancelBtn.layer.mask = maskLayer;
    
        alertV.determineBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        alertV.determineBtn.layer.cornerRadius = 10;
        alertV.determineBtn.layer.masksToBounds = YES;
    }
    
    alertV.titleLabel.text = title.length > 0 ? title : @"请选择";
    
    if (cancelName.length > 0) {
        [alertV.cancelBtn setTitle:cancelName forState:UIControlStateNormal];
    } else{
        [alertV.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
    
    if (determineName.length > 0) {
        [alertV.determineBtn setTitle:determineName forState:UIControlStateNormal];
    } else{
        [alertV.determineBtn setTitle:@"确定" forState:UIControlStateNormal];
    }

}


+ (void)FCAlertAddTextFieldWithTitle:(NSString *)title
                           cancelName:(NSString *)cancelName
                           determineName:(NSString *)determineName
                           textFIeld:(void (^)(UITextField *textField))setUpTextField
                           cancel:(void (^)())cancel
                           determine:(void (^)())determine{


    FCAlertView *alertV = [FCAlertView showWithAlertViewStyle:FCAlertStyleStyleAlert];
    alertV.backgroundColor = FCColor(249, 249, 249);
    CGFloat x = (FCScreenW - 270) / 2.0;
    CGFloat y = (FCScreenH - 140) / 2.0;
    alertV.frame = CGRectMake(x, y, 270, 140);
    
    alertV.titleLabel.frame = CGRectMake(0, 0, 270, 50);
    alertV.textField.frame = CGRectMake(10, 57, 250, 35);
    
    alertV.dividerCenter.frame = CGRectMake(0, 99.5, 270, 0.5);
    
    alertV.cancelBtn.frame = CGRectMake(0, 100, 134.75, 40);
    alertV.dividerCenter1.frame = CGRectMake(134.75, 100, 0.5, 40);
    alertV.determineBtn.frame = CGRectMake(135.25, 100, 134.75, 40);
    
    
    alertV.titleLabel.text = title.length > 0 ? title : @"请选择";
    
    if (cancelName.length > 0) {
        [alertV.cancelBtn setTitle:cancelName forState:UIControlStateNormal];
    } else{
        [alertV.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
    
    if (determineName.length > 0) {
        [alertV.determineBtn setTitle:determineName forState:UIControlStateNormal];
    } else{
        [alertV.determineBtn setTitle:@"确定" forState:UIControlStateNormal];
    }

    alertV.setUpTextFieldBlock = setUpTextField;
    alertV.cancelBlock = cancel;
    alertV.determineBlock = determine;
    
}


- (void)dismiss{

    if (self.preferredStyle == FCAlertStyleStyleAlert) {
        
        CGFloat x = (FCScreenW - 250) / 2.0;
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(x, FCScreenH, 250, 100);
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            window_.hidden = YES;
            window_ = nil;
        }];

    } else{
        
        CGFloat x = 20;
        CGFloat w = FCScreenW - 40;
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(x, FCScreenH, w, 140);
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            window_.hidden = YES;
            window_ = nil;
        }];
        
    }

}

#pragma mark 按钮点击事件
// 取消按钮
- (void)cancelBtnClick{

    if (self.cancelBlock) {
        
        self.cancelBlock();
    }
    
    
    
    [self dismiss];
    
}
// 确定按钮
- (void)determineBtnClick{

    if (self.determineBlock) {
        
        self.determineBlock();
    }
    
    
    [self dismiss];

}

// textField 监听文字改变事件
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (self.setUpTextFieldBlock) {
        
        self.setUpTextFieldBlock(textField);
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];

    return YES;
}



@end
