//
//  YYPhotoCell.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataItem;
NS_ASSUME_NONNULL_BEGIN

@interface BnbPhotoCell : UICollectionViewCell

- (void)setImage:(UIImage *)image;

- (void)setDataItem:(DataItem *)item;
@end

NS_ASSUME_NONNULL_END
