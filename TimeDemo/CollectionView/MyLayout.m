//
//  MyLayout.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "MyLayout.h"

@implementation MyLayout

- (void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat collectionW = self.collectionView.frame.size.width;
    self.itemSize = CGSizeMake(collectionW * 0.5, collectionW * 0.6);
    
    CGFloat leftRight =(collectionW - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, leftRight, 0, leftRight);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *originArr = [super layoutAttributesForElementsInRect:rect];
    NSArray *newArr = [[NSArray alloc] initWithArray:originArr copyItems:YES];
    CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5 + self.collectionView.contentOffset.x;
    for (UICollectionViewLayoutAttributes *attributes in newArr) {
        CGFloat scale = 1 - ABS(attributes.center.x - collectionViewCenterX);
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return newArr;
}

// 返回本应该偏移距离的最终距离(有点拗口)保证有一张图片一直在最中间
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5 + proposedContentOffset.x;
    
    CGFloat x = proposedContentOffset.x;
    CGFloat y = 0;
    CGFloat wh = self.collectionView.frame.size.width;
    NSArray * attributesArr = [super layoutAttributesForElementsInRect:CGRectMake(x, y, wh, wh)];
    
    //通过比较得到离中心距离最小的那张图片
    CGFloat minMagin = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attributes in attributesArr) {
        if (ABS(minMagin)  > ABS(attributes.center.x - collectionViewCenterX)) {
            minMagin = attributes.center.x - collectionViewCenterX;
        }
    }
    //原有偏移量的基础上,加上minMagin,保证有一张图片在最中间
    proposedContentOffset.x += minMagin;
    
    return proposedContentOffset;
}


@end
