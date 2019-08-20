//
//  CollectionViewController.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "CollectionViewController.h"
#import "MyLayout.h"
#import "YYPhotoCell.h"
@interface CollectionViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CollectionViewDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
}


- (void)setupView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //layout.scrollDirection =UICollectionViewScrollDirectionHorizontal; //UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(150, 150);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    //layout.minimumInteritemSpacing = 30;
    //layout.minimumLineSpacing = 30;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[YYPhotoCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:collectionView];
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    YYPhotoCell * cell = (YYPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    NSString *imageName = [NSString stringWithFormat:@"image-%d.jpg",indexPath.row];
    UIImage *image = [UIImage imageNamed:imageName];
    [cell setImage:image];
    return cell;
}


//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//     return CGSizeMake(250, 400);
//    if (indexPath.row %2 == 0) {
//        return CGSizeMake(50, 50);
//    }
//    else
//    {
//        return CGSizeMake(150, 300);
//    }
//}

#pragma mark - UICollectionViewDelegate -
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d,%d", indexPath.section, indexPath.row);
}


@end
