//
//  ViewController.m
//  ALAssetsLibraryDemo
//
//  Created by Daniel on 16/5/20.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

#import "PhotosManager.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong)PhotosManager *manager;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, copy)NSArray *imageArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) blockSelf = self;
    _manager = [PhotosManager shareManagerWithloadedAImageBlock:^(NSArray *imageArr) {
        blockSelf.imageArr = imageArr;
        [self.collectionView reloadData];
    }];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
        CGFloat itemWith = (self.view.frame.size.width-40)/3;
        layout.itemSize = CGSizeMake(itemWith, itemWith);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerNib:[CollectionViewCell nib] forCellWithReuseIdentifier:@"CollectionViewCell"];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell"
                                              forIndexPath:indexPath];
    cell.imageView.image = _imageArr[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
