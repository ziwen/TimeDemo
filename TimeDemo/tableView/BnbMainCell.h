//
//  BnbMainCell.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/25.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface BnbMainCell : UITableViewCell

- (void)setDataItems:(NSArray<DataItem *> *)items;
+ (CGFloat)heightForItems:(NSArray<DataItem *> *)items;

@end

NS_ASSUME_NONNULL_END
