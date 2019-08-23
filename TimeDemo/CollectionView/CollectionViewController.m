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
#import "DataItem.h"
@interface CollectionViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, assign)BOOL loading;
@property (nonatomic, assign)BOOL hasMore;
@end

@implementation CollectionViewController

// 注意const的位置
static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";


- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)addItems {
    for (int i = 0; i< 20; i++) {
        DataItem *item = [[DataItem alloc] init];
        item.name = [NSString stringWithFormat:@"第%d个cell", i];
        item.position = @"北京";
        if (i %2 ==0) {
            item.imageUrl = @"https://img.25pp.com/uploadfile/soft/images/2014/0731/20140731100212732.jpg";
        }
        else{
            item.imageUrl = @"https://2e.zol-img.com.cn/product/138/560/ce3jiswVHj2vo.jpg";
        }
        [_dataSource addObject:item];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CollectionViewDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    [self dataSource];
    [self addItems];
    
    _loading = NO;
    _hasMore = YES;
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
    return self.dataSource.count;
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
    BnbPhotoCell * cell1 = (BnbPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
   // cell1.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
  //  NSString *imageName = [NSString stringWithFormat:@"image-%d.jpg",indexPath.row];
    //    UIImage *image = [UIImage imageNamed:imageName];
    //    [cell1 setImage:image];
  //  [cell1 setDataItem:[self.dataSource objectAtIndex:indexPath.row]];
    
    return cell1;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
//    BnbPhotoCell * cell1 = (BnbPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    BnbPhotoCell * cell1  = ( BnbPhotoCell *)cell;
     [cell1 setDataItem:[self.dataSource objectAtIndex:indexPath.row]];
    
    if (indexPath.row +4 >= self.dataSource.count -1 && _hasMore == YES && _loading == NO) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self loadMore];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        });
    }
    
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


- (void)loadMore {
    _loading = YES;
    if (self.dataSource.count > 200) {
        _hasMore = NO;
    }
    
    [self addItems];
    
    _loading = NO;
}
@end
