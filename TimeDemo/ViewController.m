//
//  ViewController.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/16.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

//实现tableview
#import "ViewController.h"
#import "CollectionViewController.h"
#import "BigAreaViewController.h"
#import "NSString+Height.h"
#import "BnbMainViewController.h"
@interface ViewController ()
<UITableViewDelegate, UITableViewDataSource>
{
    NSTimer *_timer;
}
@property (nonatomic, strong)NSMutableArray *dataSource;

@property (nonatomic, assign)BOOL loading;
@property (nonatomic, assign)BOOL hasMore;
@property (nonatomic, assign)CGFloat downRefreshHeight;
@property (nonatomic, assign)CGFloat upRefreshHeight;

@end

@implementation ViewController


- (void)setupTableView{
    //__weak __typeof(self) weakSelf = self;
    UITableView *tableView = [[UITableView alloc]
                              initWithFrame:CGRectMake(0,
                                                    0,
                                                    [UIScreen mainScreen].bounds.size.width,
                                                    [UIScreen mainScreen].bounds.size.height - 64)
                              style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
//    tableView.backgroundColor = [UIColor redColor];
    
     self.edgesForExtendedLayout = UIRectEdgeNone;
    //left inset
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    tableView.estimatedRowHeight= 0;
    
    tableView.estimatedSectionHeaderHeight= 0;
    
   // tableView.estimatedSectionFooterHeight= 0;
    //remove sepactorStyle
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;//推荐该方法
    _tableView = tableView;
//    _tableView.contentOffset = CGPointMake(0, 60);
//    _tableView.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObject:@"各种算高，几个 delegate 的方法顺序。"];
        [_dataSource addObject:@"加 footer，加 header 高度总是不对不显示。"];
        [_dataSource addObject:@"collectionView, ok"];
        [_dataSource addObject:@"给 button 扩大点击区域，判断点击的view，遮挡什么的都可以。ok "];
        [_dataSource addObject:@"tableView ok"];
        [_dataSource addObject:@"做个 view，盖住一个 button，然后点击这个 view, 下面的 button 可以响应。"];
        [_dataSource addObject:@"做个 button，是的点击这个 button 上下左右，都可以响应，扩大范围。"];
        [_dataSource addObject:@"做个 view，点击这个 view 拖动他，拖动到某个位置，删除这个view"];
        [_dataSource addObject:@"你给 tableview 价格 foot and header，里面都有 label，都是高度自适应的。"];
        [_dataSource addObject:@"做个 collectionView，可以支持点击里面的 cell 排序。"];
        [_dataSource addObject:@"做个 collectionView，自定义一下瀑布流显示。"];
        [_dataSource addObject:@"给个数组，数组中还有数组，你给 输出了"];
        [_dataSource addObject:@"给你两个 view，找出他们最近的父 view"];
        [_dataSource addObject:@"单向的树:LCA"];
        [_dataSource addObject:@"各种算高，几个 delegate 的方法顺序。"];
        [_dataSource addObject:@"加 footer，加 header 高度总是不对不显示。"];
        [_dataSource addObject:@"collectionView"];
        [_dataSource addObject:@"给 button 扩大点击区域，判断点击的 view，遮挡什么的都可以。"];
        [_dataSource addObject:@"做个 view，盖住一个 button，然后点击这个 view, 下面的 button 可以响应。"];
        [_dataSource addObject:@"做个 button，是的点击这个 button 上下左右，都可以响应，扩大范围。"];
        [_dataSource addObject:@"做个 view，点击这个 view 拖动他，拖动到某个位置，删除这个 view"];
        [_dataSource addObject:@"你给 tableview 价格 foot and header，里面都有 label，都是高度自适应的。"];
        [_dataSource addObject:@"做个 collectionView，可以支持点击里面的 cell 排序。"];
        [_dataSource addObject:@"做个 collectionView，自定义一下瀑布流显示。"];
        [_dataSource addObject:@"给个数组，数组中还有数组，你给 输出了"];
        [_dataSource addObject:@"给你两个 view，找出他们最近的父 view"];
        [_dataSource addObject:@"单向的树:LCA"];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"first";
    [self setupTableView];
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.tableView];
    _hasMore = YES;
    _loading = NO;
    _downRefreshHeight = 40;
    _upRefreshHeight = 30;
}

#pragma - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        UIViewController *vc = [[CollectionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.row == 3)
    {
        UIViewController *vc = [[BigAreaViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.row == 4)
    {
        UIViewController *vc = [[BnbMainViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = self.dataSource[indexPath.row];
    //calculate the height
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    CGSize size = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT)
                                          options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : style}
                                          context:nil].size;
   
    return size.height+4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *text = @"自适应文本header高度，自适应文本高度，自适应文本高度，自适应文本高度，自适应文本高度，111111";
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
   return [text heightForSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT)                                     options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : style}];
}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 50;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *text = @"自适应文本header高度，自适应文本高度，自适应文本高度，自适应文本高度，自适应文本高度，111111";
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    CGFloat height =  [text heightForSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT)                                     options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : style}];
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.numberOfLines = 0;
    headerLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, height);
    headerLabel.backgroundColor = [UIColor grayColor];
    headerLabel.font = [UIFont systemFontOfSize:18];
    headerLabel.text = text;
    return headerLabel;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UILabel *headerLabel = [[UILabel alloc] init];
//    headerLabel.numberOfLines = 0;
//    headerLabel.backgroundColor = [UIColor lightGrayColor];
//    headerLabel.text = @"自适应文本footer高度，自适应文本高度，自适应文本高度，自适应文本高度，自适应文本高度，";
//    return headerLabel;
//}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *resusedIdentifier = @"reusedIdentifier";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:resusedIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resusedIdentifier];
    }
    //cell.textLabel.text = self.dataSource[indexPath.row];
    //cell.textLabel.backgroundColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.numberOfLines = 0;
   
    if(indexPath.row+3 == self.dataSource.count-1 &&
       _loading == NO &&
       _hasMore == YES) {
      
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self addMore];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
    }
}

- (void)addMore{
    _loading = YES;
    
    if (self.dataSource.count >= 40) {
        _hasMore = false;
        return;
    }
    
    for (int i =0; i< 20; i++) {
        [self.dataSource addObject:self.dataSource[i]];
    }
    
    _loading = false;
}
#pragma - UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"%s", __func__);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%s", __func__);
    return self.dataSource.count;
}

#pragma mark - uiscrollview delegate-
//但用户停止拖动，手指将要离开屏幕的时候调用。
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    //#warning 下拉刷新
    //在这里，判断tableView被拖动的距离，如果小于downRefreshView的高度，则不做操作，让tableView自动回复原来的地方；如果超过downRefreshView的高度，则调整tableView的contentInset，使其保持在下拉的状态。
    //因为下拉时，tableView的contentOffset.y值是负值，越往下，数值越小。
    if (scrollView.contentOffset.y < -_downRefreshHeight) {
        //下拉的距离超过了downRefreshView的高度，保持下拉刷新状态。
        [self beginDownRefresh];
    }
    
    //#warning 上拉加载更多
    //首先判断scrollView的contentSize.height和scrollView.frame.size.height的大小，如果scrollView的contentSize.height小于scrollView.frame.size.height，scrollView滑动的距离就是contentOffset.y值。
    
     if(scrollView.contentSize.height <= scrollView.frame.size.height &&
        scrollView.contentOffset.y > _upRefreshHeight)
     {
         //上拉距离超过了底部upRefreshHeight的距离，保持上拉加载更多状态，不够一屏高度
          [self beginUpRefresh];
     }
     else if(scrollView.contentSize.height > scrollView.frame.size.height&&
             scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height+ _upRefreshHeight)
     {
         //上拉距离超过了底部upRefreshHeight的距离，保持上拉加载更多状态
         [self beginUpRefresh];
    }
}

- (void)beginUpRefresh
{
    CGFloat upRefreshBottomHeight;
    //不够一屏
    if (self.tableView.contentSize.height <= self.tableView.frame.size.height)
    {
        upRefreshBottomHeight =self.tableView.frame.size.height-self.tableView.contentSize.height+self.upRefreshHeight;
    }
    else //超过一屏幕
    {
        upRefreshBottomHeight = self.upRefreshHeight;
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        //  frame发生偏移,距离顶部downRefreshHeight的距离(可自行设定)
        self.tableView.contentInset = UIEdgeInsetsMake(0.0f,0.0f, upRefreshBottomHeight, 0.0f);
        self.tableView.contentOffset = CGPointMake(0,self.tableView.contentSize.height + upRefreshBottomHeight -self.tableView.frame.size.height);
        NSLog(@"test");
        } completion:^(BOOL finished) {
          //这儿开始请求网络
          [self endUpRefresh];
    }];
}

- (void)endUpRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            UIEdgeInsets edgeInsets =self.tableView.contentInset;
            edgeInsets.bottom = 0;
            self.tableView.contentInset = edgeInsets;
        }];
    });
}

- (void)beginDownRefresh
{
    [UIView animateWithDuration:0.5 animations:^{
        //  frame发生偏移,距离顶部downRefreshHeight的距离(可自行设定)
        self.tableView.contentInset = UIEdgeInsetsMake(self.downRefreshHeight, 0.0f, 0.0f, 0.0f);
        self.tableView.contentOffset = CGPointMake(0, -self.downRefreshHeight);
        } completion:^(BOOL finished) {
            //这儿开始请求网络
            [self downRefresh];
    }];
}

- (void)downRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            UIEdgeInsets edgeInsets =self.tableView.contentInset;
            edgeInsets.top = 0;
            self.tableView.contentInset = edgeInsets;
    }];
        
//        [UIView animateWithDuration:0.5 animations:^{
//            //  frame发生偏移,距离顶部downRefreshHeight的距离(可自行设定)
//            self.tableView.contentInset = UIEdgeInsetsMake(0, 0.0f, 0.0f, 0.0f);
//            self.tableView.contentOffset = CGPointMake(0, 0);
//        } completion:^(BOOL finished) {
//            //这儿开始请求网络
//            self.tableView.contentInset = UIEdgeInsetsMake(0, 0.0f, 0.0f, 0.0f);
//            self.tableView.contentOffset = CGPointMake(0, 0);
//
//        }];
    });
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // headerHeight
    CGFloat sectionHeaderHeight = [self tableView:self.tableView heightForHeaderInSection:0];
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y >= sectionHeaderHeight )
    {
        UIEdgeInsets insets = scrollView.contentInset;
        insets.top =-sectionHeaderHeight;
        scrollView.contentInset = insets;
    }
    // 向上滑动到最下面了
    //   if (isLoading || !hasMore) return;
    if(scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= 0 && scrollView.contentOffset.y > 0){
        // [self loadMore];
        NSLog(@"-----");
        self.tableView.tableFooterView.hidden = NO;
    }{
          NSLog(@"-----=====");
        self.tableView.tableFooterView.hidden = YES;
    }
}
@end
