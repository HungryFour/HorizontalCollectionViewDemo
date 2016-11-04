# HorizontalCollectionViewDemo

CollectionView Horizontal slip page, the more close to the center position, is larger, the more clear. Click the cell, not in the center of the view, then jump into the center of the view

CollectionView 水平滑动  分页 ,越靠近中心位置,越大,越清楚.被点击cell,没有在视图中心,则跳转到视图中心

![image](https://github.com/wjmwjmwb/GitImage/blob/master/%E6%B0%B4%E5%B9%B3%E6%BB%9A%E5%8A%A8.gif )   

``` 
使用方法
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

简单吧....
```
```
以下为FWZoomCollectionView.h文件对外属性.
/**
 中间item的尺寸
 */
@property (assign,nonatomic)CGSize maxItemSize;

/**
 两个item之间的间隔
 */
@property (assign,nonatomic)CGFloat miniLineSpacing;


/**
 透明度是否打开(item变小时,添加模糊效果) 默认NO/不打开
 */
@property (assign, nonatomic) BOOL isAlpha;


```
