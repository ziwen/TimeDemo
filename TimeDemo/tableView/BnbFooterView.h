//
//  BnbFooterView.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/25.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BnbFooterView : UITableViewHeaderFooterView

+ (CGFloat)heightForFooterWithData:(NSString *)footer;

- (void)setFooterData:(NSString *)footer;
@end

NS_ASSUME_NONNULL_END
