//
//  BigAreaViewController.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BigAreaViewController.h"
#import "BigAreaButton.h"
#import "HittestView.h"
@interface BigAreaViewController ()
@property (nonatomic, strong)BigAreaButton *btn;

@property (nonatomic, strong)BigAreaButton *overrideBtn;
@end

@implementation BigAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"BigArea";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btn];
    //self.view.userInteractionEnabled = YES;
    UIGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick:)];
   // [self.view addGestureRecognizer:rec];
    [self.view addSubview:self.overrideBtn];
}

- (BigAreaButton *)btn
{
    if(!_btn)
    {
        _btn = [BigAreaButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor orangeColor];
        _btn.frame = CGRectMake(100, 100, 20, 20);
        _btn.layer.cornerRadius = 5;
        _btn.layer.borderWidth = 1;
        [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (BigAreaButton *)overrideBtn
{
    if (!_overrideBtn) {
        _overrideBtn = [BigAreaButton buttonWithType:UIButtonTypeCustom];
        _overrideBtn.backgroundColor = [UIColor orangeColor];
        _overrideBtn.frame = CGRectMake(20, 200, 150, 44);
        _overrideBtn.layer.cornerRadius = 5;
        _overrideBtn.layer.borderWidth = 1;
        
        [_overrideBtn addTarget:self action:@selector(overrideClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        HittestView *view = [[HittestView alloc] initWithFrame:CGRectMake(20, -50, 80, 150)];
        view.backgroundColor = [UIColor yellowColor];
        view.userInteractionEnabled = YES;
        [_overrideBtn addSubview:view];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnOverViewlicked:)];
        [view addGestureRecognizer:gesture];
        
    }
    return _overrideBtn;
}

- (void)btnClicked:(UIButton *)btn
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)btnOverViewlicked:(UIButton *)btn
{
    NSLog(@"%s", __FUNCTION__);
}
- (void)overrideClicked:(UIButton *)btn
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewClick:(UIGestureRecognizer *)gesture
{
    NSLog(@"%s", __FUNCTION__);
}


@end
