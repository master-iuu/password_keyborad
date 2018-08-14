//
//  YYLInputPasswordView.m
//  YYPassAndKeyboard
//
//  Created by 杨永亮 on 2018/8/13.
//  Copyright © 2018年 cstroll. All rights reserved.
//

#import "YYLInputPasswordView.h"
#import "YYLPasswordView.h"
#import "YYLCustomKeyboardView.h"

@interface YYLInputPasswordView ()

@property (nonatomic, strong)YYLPasswordView *payPassView;
@property (nonatomic, strong)YYLCustomKeyboardView *keyboardView;
@property (nonatomic, strong)UIView *backgroundView;

@end

@implementation YYLInputPasswordView

- (void)showInputPasswordView{
    
    CGRect passFrame = self.payPassView.frame;
    self.payPassView.frame = CGRectMake(passFrame.origin.x, passFrame.origin.y + 50, passFrame.size.width, passFrame.size.height);
    
    CGRect keyboardFrame = self.keyboardView.frame;
    self.keyboardView.frame = CGRectMake(keyboardFrame.origin.x, keyboardFrame.origin.y + keyboardFrame.size.height, keyboardFrame.size.width, keyboardFrame.size.height);
    
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:0.25f];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
    
    self.backgroundView.alpha=0.5;
    self.payPassView.frame = passFrame;
    self.keyboardView.frame = keyboardFrame;
    
    [UIView commitAnimations];
    
    [self.payPassView initializationPassView];
}
- (void)hideInputPasswordView{
    self.hidden = YES;
}

- (void)didClickBackgroundView{
    [self hideInputPasswordView];
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews{
    
    [self addSubview:self.backgroundView];
    
    [self addSubview:self.payPassView];
    
    __weak __typeof(self) weakSelf = self;
    self.payPassView.confirmBlock = ^(NSString *password) {
        // 输入密码到控制器
        if (weakSelf.confirmBlock){
            weakSelf.confirmBlock(password);
        }
        [weakSelf hideInputPasswordView];
    };
    self.payPassView.closeBtnClick = ^{
        [weakSelf hideInputPasswordView];
    };
    
    [self addSubview:self.keyboardView];
    self.keyboardView.inputSingleCharacters = ^(NSString *singleChar) {
        [weakSelf.payPassView settingUpASinglePassword:singleChar];
    };
    self.keyboardView.delegeSingleCharacters = ^(NSString *singleChar) {
        [weakSelf.payPassView deleteSinglePassword];
    };
}
#pragma mark - 控件懒加载
- (YYLPasswordView *)payPassView{
    if (_payPassView == nil) {
        _payPassView = [[YYLPasswordView alloc]initWithFrame:CGRectMake(40, 80, self.bounds.size.width - 80, 220)];
        _payPassView.layer.cornerRadius = 5.f;
        _payPassView.layer.masksToBounds = YES;
    }
    return _payPassView;
}
- (YYLCustomKeyboardView *)keyboardView {
    if (_keyboardView == nil) {
        _keyboardView = [[YYLCustomKeyboardView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-200, self.bounds.size.width, 200)];
    }
    return _keyboardView;
}
- (UIView *)backgroundView{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor lightGrayColor];
        _backgroundView.alpha = 0.5;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickBackgroundView)];
        [_backgroundView addGestureRecognizer:tapGes];
    }
    return _backgroundView;
}

@end
