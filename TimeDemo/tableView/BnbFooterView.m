//
//  BnbFooterView.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/25.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BnbFooterView.h"
@interface BnbFooterView ()
@property (nonatomic, strong)UIButton *btn;
@end

@implementation BnbFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.btn];
    }
    return self;
}

- (UIButton *)btn
{
    if (!_btn)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.layer.cornerRadius = 5;
        _btn.layer.borderWidth = 1;
        _btn.layer.borderColor = [UIColor greenColor].CGColor;
        _btn.frame = CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width - 20, 35);
        [_btn setTitle:@"显示更多北京房源" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)setFooterData:(NSString *)footer
{
      [_btn setTitle:footer forState:UIControlStateNormal];
}


+ (CGFloat)heightForFooterWithData:(NSString *)footer
{
    if (footer.length > 0) {
        return 45;
    };
    return 0;
}

- (void)btnClicked:(UIButton *)sender
{
    NSLog(@"%s", __FUNCTION__);
}
@end
