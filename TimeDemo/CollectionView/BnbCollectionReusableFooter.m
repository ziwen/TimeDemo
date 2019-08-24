//
//  BnbCollectionReusableFooter.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/23.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BnbCollectionReusableFooter.h"

@interface BnbCollectionReusableFooter ()

@property (nonatomic, strong)UIButton *btn;
@end
@implementation BnbCollectionReusableFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
        _btn.frame = CGRectMake(10, 5, self.bounds.size.width-20, 35);
        [_btn setTitle:@"显示更多北京房源" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
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
