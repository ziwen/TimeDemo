//
//  BnbMainScrollViewCell.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/25.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataItem;
NS_ASSUME_NONNULL_BEGIN

@interface BnbMainScrollViewCell : UITableViewCell

- (void)setDataItems:(NSArray<DataItem *> *)items;
+ (CGFloat)heightForItems:(NSArray<DataItem *> *)items;
@end

NS_ASSUME_NONNULL_END
