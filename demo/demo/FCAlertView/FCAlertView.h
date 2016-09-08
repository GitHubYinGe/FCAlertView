//
//  FCAlertView.h
//  demo
//
//  Created by 李再民 on 16/9/8.
//  Copyright © 2016年 FengChe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FCAlertStyle) {
    FCAlertStyleStyleActionSheet = 0, // 默认底部弹出
    FCAlertStyleStyleAlert            // 默认中间弹出
};

@interface FCAlertView : UIView


@property (nonatomic, assign) FCAlertStyle preferredStyle;


+ (instancetype)showWithAlertViewStyle:(FCAlertStyle)style;

/**
 * title            头部名字
 * preferredStyle   弹出的样式
 * cancaelName      默认文字 "取消"
 * determineName    默认文字 "确定"
 * cancel           点击取消按钮
 * determine        点击确认按钮
 */
+ (void)FCAlertWithTitle:(NSString *)title
                       cancelName:(NSString *)cancaelName
                       determineName:(NSString *)determineName
                       preferredStyle:(FCAlertStyle)preferredStyle
                       cancel:(void(^)())cancel
                       determine:(void(^)())determine;

/**
 *  默认样式 中间弹出
 * title            头部名字
 * cancaelName      默认文字 "取消"
 * determineName    默认文字 "确定"
 * setUpTextField   可以拿到textField,进行设置
 * cancel           点击取消按钮
 * determine        点击确认按钮
 */
+ (void)FCAlertAddTextFieldWithTitle:(NSString *)title
                        cancelName:(NSString *)cancelName
                        determineName:(NSString *)determineName
                        textFIeld:(void (^)(UITextField *textField))setUpTextField
                        cancel:(void(^)())cancel
                        determine:(void(^)())determine;
@end
