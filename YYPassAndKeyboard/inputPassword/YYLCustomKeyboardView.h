//
//  YYLCustomKeyboardView.h
//  YYPassAndKeyboard
//
//  Created by 杨永亮 on 2018/8/13.
//  Copyright © 2018年 cstroll. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 处理单个按钮的点击事件, 删除或输入
 
 @param singleStr 单个字符
 */
typedef void(^handleSingleCharacters)(NSString *singleStr);

/**
 支付密码数字键盘
 */
@interface YYLCustomKeyboardView : UIView

/**
 删除单个字符
 */
@property (nonatomic, copy) handleSingleCharacters delegeSingleCharacters;

/**
 输入单个字符
 */
@property (nonatomic, copy) handleSingleCharacters inputSingleCharacters;


@end
