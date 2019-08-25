//
//  BnbMainViewController.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BnbMainViewController.h"
#import "HeaderItem.h"
#import "DataItem.h"
#import "BnbHeaderView.h"
#import "BnbFooterView.h"
#import "BnbMainScrollViewCell.h"
#import "BnbMainCell.h"
@interface BnbMainViewController ()
<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation BnbMainViewController


static NSString *const kScrollViewCellId = @"scrollViewCellId";
static NSString *const kCellId = @"cellId";
static NSString *const kHeaderId = @"headerId";
static NSString *const kFooterId = @"footerId";


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"MainPageDemo";
//    self.view.backgroundColor = [UIColor yellowColor];
    //data init
    [self dataSource];
    [self addItems];
    
    //view init
    [self.view addSubview:self.tableView];
    
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   [UIScreen mainScreen].bounds.size.width,
                                                                   [UIScreen mainScreen].bounds.size.height - 56)
                                                  style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        //left inset
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]){
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
        
        _tableView.estimatedRowHeight= 0;
        
        _tableView.estimatedSectionHeaderHeight= 0;
        
        // tableView.estimatedSectionFooterHeight= 0;
        //remove sepactorStyle
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;//推荐该方法
        
        [_tableView registerClass:[BnbHeaderView class] forHeaderFooterViewReuseIdentifier:kHeaderId];
        [_tableView registerClass:[BnbFooterView class] forHeaderFooterViewReuseIdentifier:kFooterId];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
    for (int i = 0; i< 4; i++) {
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

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    HeaderItem *item = self.dataSource[section][@"header"];
    return [BnbHeaderView heightForHeaderWithData:item];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSString *footer = self.dataSource[section][@"footer"];
    return [BnbFooterView heightForFooterWithData:footer];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderItem *item = self.dataSource[section][@"header"];
    BnbHeaderView *headerView = (BnbHeaderView *)[self.tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderId];
    if (headerView == nil)
    {
        headerView = [[BnbHeaderView alloc] init];
    }
     [headerView setHeaderData:item];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSString *footer = self.dataSource[section][@"footer"];
    BnbFooterView *footerView = (BnbFooterView *)[self.tableView dequeueReusableHeaderFooterViewWithIdentifier:kFooterId];
    if (footerView == nil)
    {
        footerView = [[BnbFooterView alloc] init];
    }
    [footerView setFooterData:footer];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.dataSource[indexPath.section][@"content"];
    
    if (indexPath.section == 0) {
        return [BnbMainCell heightForItems:array];
    }
    else if (indexPath.section == 1) {
        return [BnbMainScrollViewCell heightForItems:array];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
       BnbMainCell *cell = (BnbMainCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellId];
        if (nil == cell)
        {
            cell = [[BnbMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        BnbMainScrollViewCell *cell = (BnbMainScrollViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kScrollViewCellId];
        if (nil == cell)
        {
            cell = [[BnbMainScrollViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kScrollViewCellId];
        }
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *dataItems = self.dataSource[indexPath.section][@"content"];
    DataItem *item = dataItems[indexPath.row];
    if (indexPath.section == 0)
    {
         BnbMainCell *mainCell = (BnbMainCell *)cell;
        [mainCell setDataItems:dataItems];
    }
    else
    {
        BnbMainScrollViewCell *scrollcell = (BnbMainScrollViewCell *)cell;
        [scrollcell setDataItems:dataItems];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //用不到
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

@end
