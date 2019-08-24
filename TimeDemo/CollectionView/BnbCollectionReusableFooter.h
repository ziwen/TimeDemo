//
//  BnbCollectionReusableFooter.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/23.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BnbCollectionReusableFooter : UICollectionReusableView

+ (CGFloat)heightForFooterWithData:(NSString *)footer;
@end

NS_ASSUME_NONNULL_END
