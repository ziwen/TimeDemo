//
//  BnbScrollViewCell.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/23.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataItem;
NS_ASSUME_NONNULL_BEGIN

@interface BnbScrollViewCell : UICollectionViewCell

- (void)setDataItem:(NSArray<DataItem *> *)items;

+ (CGFloat)heightForItem:(NSArray<DataItem *> *)items;

@end

NS_ASSUME_NONNULL_END
