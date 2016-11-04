//
//  ViewController.m
//  HorizontalCollectionView
//
//  Created by WJM on 16/3/10.
//  Copyright © 2016年 WJM. All rights reserved.
//

#import "ViewController.h"

#import "DataModel.h"
#import "FWZoomCollectionView.h"

#define ksMainWidth [UIScreen mainScreen].bounds.size.width
#define ksMainHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<FWZoomCollectionViewDatasource,FWZoomCollectionViewDelegate>
{
    NSMutableArray *dataArray;
}
@property (strong, nonatomic) FWZoomCollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    dataArray = [NSMutableArray arrayWithCapacity:19];

    [self.view addSubview:self.collectionView];
    
    for (NSInteger i=0; i<20; i++) {
        DataModel *model = [DataModel new];
        model.img = [NSString stringWithFormat:@"%u",arc4random()%9];
        model.title = [NSString stringWithFormat:@"我是第%ld个Cell的title",i];
        model.dec = [NSString stringWithFormat:@"我是第%ld个Cell的描述啊 我是描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述",i];
        [dataArray addObject:model];
    }
    [self. collectionView reloadData];
}
#pragma mark - Property
- (FWZoomCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[FWZoomCollectionView alloc]initWithFrame:CGRectMake(0, 100, ksMainWidth, ksMainHeight-200)];
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.maxItemSize = CGSizeMake(ksMainWidth-150, (ksMainHeight-200));
        _collectionView.miniLineSpacing = 40.0;
        _collectionView.zDatasource = self;
        _collectionView.zDelegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}
#pragma mark - FWZoomCollectionViewDatasource
- (UICollectionViewCell *)zoomCollectionView:(FWZoomCollectionView *)zoomCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath cellForDataAtIndex:(NSInteger)index{

    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [zoomCollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    DataModel * model = [dataArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:model.img]];

    return cell;
}
- (NSInteger)zoomCollectionView:(FWZoomCollectionView *)zoomCollectionView numberOfItemsInSection:(NSInteger)section{
    return dataArray.count;
}
#pragma mark - FWZoomCollectionViewDelegate
- (void)zoomCollectionView:(FWZoomCollectionView *)zoomCollectionView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了:%ld Item",index);
}
- (void)zoomCollectionView:(FWZoomCollectionView *)zoomCollectionView didScrollowTo:(NSInteger)index{
    NSLog(@"即将以:%ld Item为中心",index);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
