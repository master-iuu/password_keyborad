//
//  YYLInputPasswordView.h
//  YYPassAndKeyboard
//
//  Created by 杨永亮 on 2018/8/13.
//  Copyright © 2018年 cstroll. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^confirmationOfPayment)(NSString *password);       // 输入密码长度等于预设长度, 确认支付

/**
 输入密码页面
 */
@interface YYLInputPasswordView : UIView


/**
 确认支付
 */
@property (nonatomic, copy) confirmationOfPayment confirmBlock;

/**
 显示输入密码 view

 @param tranamt 金额
 */
- (void)showInputPasswordViewWithTranamt:(NSString *)tranamt;

/**
 隐藏输入密码 view
 */
- (void)hideInputPasswordView;


@end
