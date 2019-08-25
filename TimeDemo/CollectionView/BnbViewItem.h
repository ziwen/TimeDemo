//
//  BnbViewItem.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/25.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataItem;

NS_ASSUME_NONNULL_BEGIN

@interface BnbViewItem : UIView
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UILabel *positionLbl;
@property (nonatomic, strong)UILabel *nameLbl;
@property (nonatomic, weak)DataItem *item;

- (void)setDataItem:(DataItem *)item;

@end

NS_ASSUME_NONNULL_END
