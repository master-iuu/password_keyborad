//
//  YYLCustomKeyboardView.m
//  YYPassAndKeyboard
//
//  Created by 杨永亮 on 2018/8/13.
//  Copyright © 2018年 cstroll. All rights reserved.
//

#import "YYLCustomKeyboardView.h"


#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]

@interface YYLCustomKeyboardView ()

@property (nonatomic, strong) NSArray *keyArr;      // 键集合
@end

@implementation YYLCustomKeyboardView


/**
 数字按钮点击事件
 
 @param btn 数字按钮
 */
-(void)didClickKeyBorad:(UIButton *)btn{
    
    if (btn.tag == 11) {
        // 删除单个字符
        NSString *singleStr = btn.titleLabel.text;
        if (self.delegeSingleCharacters) {
            self.delegeSingleCharacters(singleStr);
        }
    }else if(btn.tag == 9){
        // 此字符为占位字符, 不做处理
    }else{
        // 添加单个字符
        NSString *singleStr = btn.titleLabel.text;
        if (self.inputSingleCharacters) {
            self.inputSingleCharacters(singleStr);
        }
    }
}




#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:223/255.f green:223/255.f blue:223/255.f alpha:1];
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews{
    
    for(int i=0; i<self.keyArr.count; i++)
    {
        NSInteger index = i%3;
        NSInteger page = i/3;
        
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat w = self.bounds.size.width/3;
        btn.frame = CGRectMake(index * (self.bounds.size.width/3), page  * 50,w,50);
        btn.tag=i;
        NSString *title = [self.keyArr objectAtIndex:i];
        [btn setTitle:title forState:normal];
        [btn setTitleColor:[UIColor blackColor] forState:normal];
        btn.layer.borderColor=[ColorHUI CGColor];
        btn.layer.borderWidth=0.5;
        if ([title isEqualToString:@" "] || [title isEqualToString:@"x"]) {
            if ([title isEqualToString:@"x"]) {
                [btn setTitle:@"" forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"keyboard_delete"] forState:UIControlStateNormal];
            }
            btn.backgroundColor = ColorHUI;
        }else{
            btn.backgroundColor = [UIColor whiteColor];
        }
        [btn addTarget:self action:@selector(didClickKeyBorad:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
- (NSArray *)keyArr{
    if (_keyArr == nil) {
        _keyArr =[[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@" ",@"0",@"x", nil];
    }
    return _keyArr;
}

@end
