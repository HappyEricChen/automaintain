//
//  CommonCollectionView.m
//  automaintain
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "CommonCollectionView.h"
#import "CommonCollectionViewCell.h"
#import "BaseCollectionViewFlowLayout.h"

@interface CommonCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation CommonCollectionView

-(NSMutableArray *)totalArr
{
    if (!_totalArr)
    {
        _totalArr = [NSMutableArray array];
    }
    return _totalArr;
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
//        flowLayout.delegate = self;
        flowLayout.minimumLineSpacing = ScreenWidth*0.026;
        UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollEnabled = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        [collectionView registerClass:[CommonCollectionViewCell class] forCellWithReuseIdentifier:commonCellId];
        collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        
        collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
//        [self addObserver:self forKeyPath:@"totalArr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}


//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    if (object == self && [keyPath isEqualToString:@"totalArr"])
//    {
//        [self.collectionView reloadData];
//    }
//    else
//    {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//    
//}

//-(void)dealloc
//{
//    if (self ! = nil)
//    {
//        [self removeObserver:self forKeyPath:<#(nonnull NSString *)#>];
//    }
//}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalArr.count>0?self.totalArr.count:0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    id object = nil;
    CommonCollectionViewCell * commonCell = [CommonCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:commonCellId forIndexPath:indexPath];
    object = self.totalArr[indexPath.row];
    
    [commonCell layoutWithObject:object];
    return commonCell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth*0.42, ScreenHeight*0.048);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(ScreenWidth*0.042, ScreenWidth*0.042, 0, ScreenWidth*0.042);
}

@end
