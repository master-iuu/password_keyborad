//
//  YYLPasswordView.m
//  YYPassAndKeyboard
//
//  Created by 杨永亮 on 2018/8/13.
//  Copyright © 2018年 cstroll. All rights reserved.
//

#import "YYLPasswordView.h"



/**
 密码长度
 */
#define kPasswordLength 6

#define SCREEN_WIDTH  (self.bounds.size.width)

#define SCREEN_HEIGHT  (self.bounds.size.height)

#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]

@interface YYLPasswordView ()

/**
 textfield 集合数组
 */
@property (nonatomic, strong) NSArray *textfieldArr;
@property (nonatomic, assign) int cursor;                   // 密码游标

@property (nonatomic, strong) UIButton *closeBtn;           // 关闭按钮
@property (nonatomic, strong) UILabel *titleLbl;            // 标题
@property (nonatomic, strong) UIView *lineView;             // 分割线
@property (nonatomic, strong) UILabel *describeLbl;         // 描述 lbl
@property (nonatomic, strong) UILabel *moneyLbl;            // 金额


@end


@implementation YYLPasswordView

#pragma mark - 逻辑处理
- (void)settingUpASinglePassword:(NSString *)singlePass{
    
    UITextField *singleText = [self.textfieldArr objectAtIndex:self.cursor];
    
    if (singleText.text.length > 0) {
        // 增加游标
        if (self.cursor == kPasswordLength-1) {
            return;
        }
        self.cursor++;
        singleText = [self.textfieldArr objectAtIndex:self.cursor];
    }
    
    // 使用正则表达式, 验证输入文字
    NSString *regex = @"^\\d?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:singlePass]) {
        // 判断当前字符是否是个位数字
        singleText.text = singlePass;
        
        // 判断当前输入的密码和设定长度是否一致
        if (self.cursor == kPasswordLength-1) {
            // 调用支付接口
            NSString *password = [self passwordStr];
            if (password.length == kPasswordLength) {
                // 调用支付接口
                if (self.confirmBlock) {
                    self.confirmBlock(password);
                }
            }
        }else{
        }
    }else{
        NSLog(@"输入的文本是非数字类型");
    }
}
- (void)deleteSinglePassword{
    
    UITextField *singleText = [self.textfieldArr objectAtIndex:self.cursor];
    singleText.text = @"";
    
    // 处理游标
    if (self.cursor == 0) {
        
    }else{
        self.cursor--;
    }
}
- (NSString *)passwordStr{
    
    NSMutableString *passStr = [NSMutableString stringWithCapacity:kPasswordLength];
    for (UITextField *passText in self.textfieldArr) {
        [passStr appendString:passText.text];
    }
    return passStr.copy;
}
- (void)initializationPassView{
    
    for (UITextField *passText in self.textfieldArr) {
        passText.text = @"";
    }
    self.cursor = 0;
}

- (void)didClickCloseBtn{
    if (self.closeBtnClick) {
        self.closeBtnClick();
    }
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubviews];
        self.cursor = 0;
    }
    return self;
}
- (void)addSubviews{
    
    self.closeBtn.frame = CGRectMake(7, 10, 40, 40);
    [self addSubview:self.closeBtn];
    
    self.titleLbl.frame = CGRectMake(0, 10, self.bounds.size.width, 40);
    [self addSubview:self.titleLbl];
    
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLbl.frame)+7, self.bounds.size.width, 1);
    [self addSubview:self.lineView];
    
    self.describeLbl.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame)+10, self.bounds.size.width, 20);
    [self addSubview:self.describeLbl];
    
    self.moneyLbl.frame = CGRectMake(0, CGRectGetMaxY(self.describeLbl.frame)+10, self.bounds.size.width, 50);
    [self addSubview:self.moneyLbl];
    
    // 根据密码长度生成密码输入框
    CGFloat WH = 40;
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:kPasswordLength];
    CGFloat textFieldX = (self.bounds.size.width - (WH+(WH-1)*(kPasswordLength-1)))/2;
    for (int i = 0; i < kPasswordLength; i++) {
        UITextField *passText = [[UITextField alloc]initWithFrame:CGRectMake(textFieldX, CGRectGetMaxY(self.moneyLbl.frame)+20, WH, WH)];
        passText.textAlignment = NSTextAlignmentCenter;
        passText.textColor = [UIColor blackColor];
        [passText setSecureTextEntry:YES];
        passText.font = [UIFont systemFontOfSize:14.0f];
        passText.layer.borderWidth = 1;
        [passText setEnabled:NO];
        passText.layer.borderColor = [ColorHUI CGColor];
        passText.tag = i;
        passText.text = @"";
        textFieldX += WH-1;
        [self addSubview:passText];
        [tempArr addObject:passText];
    }
    self.textfieldArr = tempArr.copy;
    
#if DEBUG
    [self.closeBtn setTitle:@"╳" forState:UIControlStateNormal];
    [self.closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.moneyLbl.text = @"¥100.00";
#endif
}
- (UIButton *)closeBtn{
    if (_closeBtn == nil) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [_closeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(didClickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _closeBtn;
}
- (UILabel *)titleLbl{
    if (_titleLbl == nil) {
        _titleLbl = [[UILabel alloc]init];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = [UIFont boldSystemFontOfSize:18.f];
        _titleLbl.text = @"请输入支付密码";
    }
    return _titleLbl;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _lineView;
}
- (UILabel *)describeLbl{
    if (_describeLbl == nil) {
        _describeLbl = [[UILabel alloc]init];
        _describeLbl.text = @"付款给商家";
        _describeLbl.textAlignment = NSTextAlignmentCenter;
        _describeLbl.font = [UIFont systemFontOfSize:14.f];
    }
    return _describeLbl;
}
- (UILabel *)moneyLbl{
    if (_moneyLbl == nil) {
        _moneyLbl = [[UILabel alloc]init];
        _moneyLbl.textAlignment = NSTextAlignmentCenter;
        _moneyLbl.font = [UIFont boldSystemFontOfSize:40.f];
    }
    return _moneyLbl;
}

@end
