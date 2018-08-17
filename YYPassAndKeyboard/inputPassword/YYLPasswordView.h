//
//  YYLPasswordView.h
//  YYPassAndKeyboard
//
//  Created by 杨永亮 on 2018/8/13.
//  Copyright © 2018年 cstroll. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^confirmationOfPayment)(NSString *password);       // 输入密码长度等于预设长度, 确认支付
typedef void(^closeBtnDidClickBlock)();

/**
 支付密码输入框
 */
@interface YYLPasswordView : UIView

/**
 确认支付
 */
@property (nonatomic, copy) confirmationOfPayment confirmBlock;

/**
 关闭按钮点击事件处理
 */
@property (nonatomic, copy) closeBtnDidClickBlock closeBtnClick;

/**
 初始化密码输入框
 */
- (void)initializationPassView;

/**
 获取密码字符串
 
 @return 密码
 */
- (NSString *)passwordStr;

/**
 点击了删除按钮, 删除单个密码字符
 */
- (void)deleteSinglePassword;

/**
 设置单个密码字符
 */
- (void)settingUpASinglePassword:(NSString *)singlePass;

/**
 设置支付金额

 @param tranamt 金额
 */
- (void)settingTranamt:(NSString *)tranamt;

@end
