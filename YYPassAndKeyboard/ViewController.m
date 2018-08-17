//
//  ViewController.m
//  YYPassAndKeyboard
//
//  Created by 杨永亮 on 2018/8/13.
//  Copyright © 2018年 cstroll. All rights reserved.
//

#import "ViewController.h"
#import "YYLInputPasswordView.h"

@interface ViewController ()


@property (nonatomic, strong) YYLInputPasswordView *payPassView;

@property (nonatomic, strong) UIButton *paymentBtn;
@property (nonatomic, strong) UILabel *passwordLbl;

@end

@implementation ViewController

- (void)didClickPaymentBtn{
    [self.view bringSubviewToFront:self.payPassView];
    self.payPassView.hidden = NO;
    [self.payPassView showInputPasswordViewWithTranamt:@"20"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.payPassView];
    self.payPassView.hidden = YES;
    __weak __typeof(self) weakSelf = self;
    self.payPassView.confirmBlock = ^(NSString *password) {
        weakSelf.passwordLbl.text = password;
    };
    
    [self.view addSubview:self.paymentBtn];
    self.paymentBtn.frame = CGRectMake(0, 50, self.view.bounds.size.width, 50);

    [self.view addSubview:self.passwordLbl];
    self.passwordLbl.frame = CGRectMake(0, CGRectGetMaxY(self.paymentBtn.frame)+50, self.view.bounds.size.width, 20);
    
}
- (YYLInputPasswordView *)payPassView{
    if (_payPassView == nil) {
        _payPassView = [[YYLInputPasswordView alloc]initWithFrame:self.view.bounds];
    }
    return _payPassView;
}
- (UIButton *)paymentBtn{
    if (_paymentBtn == nil) {
        _paymentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_paymentBtn addTarget:self action:@selector(didClickPaymentBtn) forControlEvents:UIControlEventTouchUpInside];
        [_paymentBtn setTitle:@"模拟支付" forState:UIControlStateNormal];
        _paymentBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _paymentBtn;
}
- (UILabel *)passwordLbl{
    if (_passwordLbl == nil) {
        _passwordLbl = [[UILabel alloc]init];
        _passwordLbl.backgroundColor=[UIColor clearColor];
        _passwordLbl.textAlignment = NSTextAlignmentCenter;
        _passwordLbl.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _passwordLbl;
}

@end
