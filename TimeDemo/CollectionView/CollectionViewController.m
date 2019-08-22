//
//  CollectionViewController.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "CollectionViewController.h"
#import "MyLayout.h"
#import "BnbPhotoCell.h"
#import "BnbCollectionReusableHeader.h"
#import "BnbCollectionReusableFooter.h"
@interface CollectionViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation CollectionViewController

// 注意const的位置
static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CollectionViewDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
}


- (void)setupView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //layout.scrollDirection =UICollectionViewScrollDirectionHorizontal; //UICollectionViewScrollDirectionVertical;
   // layout.itemSize = CGSizeMake(150, 150);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    //layout.minimumInteritemSpacing = 30;
    layout.minimumLineSpacing = 5;
    //layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[BnbPhotoCell class] forCellWithReuseIdentifier:cellId];
    [collectionView registerClass:[BnbCollectionReusableHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [collectionView registerClass:[BnbCollectionReusableFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    //创建长按手势监听
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(myHandleTableviewCellLongPressed:)];
    longPress.minimumPressDuration = 1.0;
    //将长按手势添加到需要实现长按操作的视图里
    [collectionView addGestureRecognizer:longPress];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}


- (void)myHandleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gesture
{
    CGPoint pointTouch = [gesture locationInView:self.collectionView];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateBegan");
        
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointTouch];
        if (indexPath == nil) {
            NSLog(@"空");
        }else{
            
            NSLog(@"Section = %ld,Row = %ld",(long)indexPath.section,(long)indexPath.row);
            
        }
    }
    if (gesture.state == UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged");
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
    }
}

#pragma mark - UICollectionViewDataSource -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BnbCollectionReusableHeader *headerView = (BnbCollectionReusableHeader *)[_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[BnbCollectionReusableHeader alloc] init];
            headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
        }
        headerView.backgroundColor = [UIColor grayColor];

        return headerView;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        BnbCollectionReusableFooter *footerView = (BnbCollectionReusableFooter *)[_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[BnbCollectionReusableFooter alloc] init];
            
        }
        footerView.backgroundColor = [UIColor grayColor];

        return footerView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BnbPhotoCell * cell = (BnbPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    NSString *imageName = [NSString stringWithFormat:@"image-%d.jpg",indexPath.row];
    UIImage *image = [UIImage imageNamed:imageName];
    [cell setImage:image];
    return cell;
}

//返回头headerView 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size= CGSizeMake(self.view.frame.size.width, 50);
    return size;
}
//返回头footerview 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size= CGSizeMake(self.view.frame.size.width, 50);
    return size;
}
//返回头item 的大小, 主要注意高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
     return CGSizeMake((collectionView.bounds.size.width-50)/2.0, 140);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 20, 0, 20);
}

#pragma mark - UICollectionViewDelegate -
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d,%d", indexPath.section, indexPath.row);
}


@end
