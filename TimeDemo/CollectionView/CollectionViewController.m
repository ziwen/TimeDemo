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
#import "HeaderItem.h"
#import "BnbScrollViewCell.h"
@interface CollectionViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,BnbCollectionReusableHeaderDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, assign)BOOL loading;
@property (nonatomic, assign)BOOL hasMore;

@property (nonatomic, strong)NSMutableArray *headerDataSource;
@end

@implementation CollectionViewController

// 注意const的位置

static NSString *const kScrollViewCellId = @"scrollViewCellId";
static NSString *const kCellId = @"cellId";
static NSString *const kHeaderId = @"headerId";
static NSString *const kFooterId = @"footerId";


- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)headerDataSource
{
    if (!_headerDataSource)
    {
        _headerDataSource = [NSMutableArray array];
 
        HeaderItem *item2 = [[HeaderItem alloc] init];
        item2.name = @"最近浏览记录";
        [_headerDataSource addObject:item2];
    }
    return _headerDataSource;
}

- (void)addItems {
    
    //section1
    //header
    HeaderItem *headerItem0 = [[HeaderItem alloc] init];
    headerItem0.name = @"秋季特惠房源";
    headerItem0.subName = @"低至8折，可叠加使用权";
    headerItem0.cities = @[@"北京", @"上海", @"杭州", @"南京", @"成都"];
    
    //cell
    NSMutableArray *cellDataItems = [NSMutableArray array];
    for (int i = 0; i< 20; i++) {
        DataItem *item = [[DataItem alloc] init];
        item.name = [NSString stringWithFormat:@"第%d个cell", i];
        
        if (arc4random() % 3 == 0) {
            item.name = [NSString stringWithFormat:@"第%d个cell，日式榻榻米日式榻榻米日式榻榻米日式榻榻米", i];
        }
        item.position = @"北京";
        if (i %2 ==0)
        {
            item.imageUrl = @"https://img.25pp.com/uploadfile/soft/images/2014/0731/20140731100212732.jpg";
        }
        else
        {
            item.imageUrl = @"https://img.25pp.com/uploadfile/soft/images/2014/0731/20140731100212732.jpg";
        }
        [cellDataItems addObject:item];
    }
    
    //footer
    NSString *footer = @"显示更多北京房源";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:headerItem0 forKey:@"header"];
    [dict setObject:cellDataItems forKey:@"content"];
    [dict setObject:footer forKey:@"footer"];
    [_dataSource addObject:dict];
    
    
    //section1
    HeaderItem *headerItem1 = [[HeaderItem alloc] init];
    headerItem1.name = @"最近浏览记录";
    
    //content
    //cell
    NSMutableArray *cellDataItems1 = [NSMutableArray array];
    for (int i = 0; i< 10; i++) {
        DataItem *item = [[DataItem alloc] init];
        item.name = [NSString stringWithFormat:@"第%d个cell", i];
        
        if (arc4random() % 3 == 0) {
            item.name = [NSString stringWithFormat:@"第%d个cell，日式榻榻米日式榻榻米日式榻榻米日式榻榻米", i];
        }
        item.position = @"北京";
        if (i %2 ==0)
        {
            item.imageUrl = @"https://img.25pp.com/uploadfile/soft/images/2014/0731/20140731100212732.jpg";
        }
        else
        {
            item.imageUrl = @"https://2e.zol-img.com.cn/product/138/560/ce3jiswVHj2vo.jpg";
        }
        [cellDataItems1 addObject:item];
    }
    
    NSMutableDictionary *sectionDict1 = [NSMutableDictionary dictionary];
    [sectionDict1 setObject:headerItem1 forKey:@"header"];
    [sectionDict1 setObject:cellDataItems1 forKey:@"content"];
    
    [_dataSource addObject:sectionDict1];
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
    [collectionView registerClass:[BnbPhotoCell class] forCellWithReuseIdentifier:kCellId];
      [collectionView registerClass:[BnbScrollViewCell class] forCellWithReuseIdentifier:kScrollViewCellId];
    [collectionView registerClass:[BnbCollectionReusableHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderId];
    [collectionView registerClass:[BnbCollectionReusableFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterId];
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
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    NSArray *items = self.dataSource[section][@"content"];
    return items.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        HeaderItem *headerItem = [self.dataSource[indexPath.section] objectForKey:@"header"];
        if (headerItem == nil) {
            return nil;
        }
        BnbCollectionReusableHeader *headerView = (BnbCollectionReusableHeader *)[_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderId forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[BnbCollectionReusableHeader alloc] init];
            headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
        }
        [headerView setHeaderData:headerItem];
        headerView.delegate = self;
        
        return headerView;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        NSString *footer = [self.dataSource[indexPath.section] objectForKey:@"footer"];
        if (footer == nil  || footer.length <= 0) {
            return nil;
        }
        BnbCollectionReusableFooter *footerView = (BnbCollectionReusableFooter *)[_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kFooterId forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[BnbCollectionReusableFooter alloc] init];
        }
        return footerView;
    }
    
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (indexPath.section == 0) {
        cell = (BnbPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    }else {
        cell = (BnbScrollViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kScrollViewCellId forIndexPath:indexPath];
    }
   // cell1.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [self.dataSource objectAtIndex:indexPath.section][@"content"];
    if (indexPath.section == 0) {
         BnbPhotoCell * cell1 = (BnbPhotoCell *)cell;
        [cell1 setDataItem:items[indexPath.row]];
        return;
    }
    else
    {
        BnbScrollViewCell *cell1 = (BnbScrollViewCell *)cell;
         [cell1 setDataItem:items];
    }
  
//    if (indexPath.row +4 >= items.count -1 && _hasMore == YES && _loading == NO) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [self loadMore];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.collectionView reloadData];
//            });
//        });
//    }
}
//返回头headerView 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat height = [BnbCollectionReusableHeader heightForHeaderWithData:self.dataSource[section][@"header"]];
    CGSize size= CGSizeMake(self.view.frame.size.width, height);
    return size;
}
//返回头footerview 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGFloat height = [BnbCollectionReusableFooter heightForFooterWithData:self.dataSource[section][@"footer"]];
    CGSize size = CGSizeMake(self.view.frame.size.width, height);
    return size;
}
//返回头item 的大小, 主要注意高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
          return CGSizeMake((collectionView.bounds.size.width-50)/2.0, 140);
    }
    else
    {
        return CGSizeMake(collectionView.bounds.size.width, [BnbScrollViewCell heightForItem:self.dataSource[indexPath.section][@"content"]]);
    }
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

- (void)didClickHeader:(HeaderItem *)headerItem
{
    NSLog(@"%s:selected:%@",__func__,headerItem.cities[headerItem.selectedIndex]);
}
@end
