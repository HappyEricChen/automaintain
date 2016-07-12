//
//  CommonCollectionView.m
//  automaintain
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "CommonCollectionView.h"
#import "CommonCollectionViewCell.h"

@interface CommonCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation CommonCollectionView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 5.0f;
        flowLayout.minimumInteritemSpacing = 5.0f;
        
        UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsVerticalScrollIndicator = NO;
        [collectionView registerClass:[CommonCollectionViewCell class] forCellWithReuseIdentifier:commonCellId];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:collectionView];
        
        collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return self;
}

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
    BaseCollectionViewCell * cell = nil;
    id object = nil;
    if (indexPath.section == 0)
    {
        CommonCollectionViewCell * commonCell = [CommonCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:commonCellId forIndexPath:indexPath];
        object = self.totalArr[indexPath.row];
        [commonCell layoutTextColorWithColor:self.textColor];
        [commonCell layoutBackgroundColorWithColor:self.backgroundColor];
        cell = commonCell;
    }
    [cell layoutWithObject:object];
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.pageName isEqualToString:@"washCar"])
    {
        return CGSizeMake(90, 25);
    }
//    CGSize size = [self calculateSizeWithLabelContent:self.titleArr[indexPath.row] WithFontName:nil WithFontSize:self.fontSize];
    
//    return CGSizeMake(size.width+30, size.height+15);
    return CGSizeMake(110, 25);
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
