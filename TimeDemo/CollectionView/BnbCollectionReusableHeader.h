//
//  BnbCollectionReusableHeader.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/23.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeaderItem;
NS_ASSUME_NONNULL_BEGIN

@protocol BnbCollectionReusableHeaderDelegate <NSObject>

@optional

- (void)didClickHeader:(HeaderItem *)headerItem;

@end
@interface BnbCollectionReusableHeader : UICollectionReusableView

@property (nonatomic, weak) id<BnbCollectionReusableHeaderDelegate> delegate;

- (void)setHeaderData:(HeaderItem *)headerItem;

+ (CGFloat)heightForHeaderWithData:(HeaderItem *)headerItem;

@end

NS_ASSUME_NONNULL_END
