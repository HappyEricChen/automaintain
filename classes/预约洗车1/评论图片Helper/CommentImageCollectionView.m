//
//  CommentImageCollectionView.m
//  一号车库
//
//  Created by eric on 16/8/25.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "CommentImageCollectionView.h"
#import "CommentImageCollectionViewCell.h"
#import "UserCommentModel.h"

@interface CommentImageCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation CommentImageCollectionView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.minimumLineSpacing = 5.0;
        UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.scrollEnabled = NO;
        [collectionView registerClass:[CommentImageCollectionViewCell class] forCellWithReuseIdentifier:CommentImageCollectionViewCellId];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        
        collectionView.sd_layout.leftEqualToView(self).rightEqualToView(self).topEqualToView(self).heightIs(ScreenWidth*0.3);
        
    }
    return self;
}




#pragma mark - 在模型的set方法里面刷新collectionView
-(void)setUserCommentModel:(UserCommentModel *)userCommentModel
{
    _userCommentModel = userCommentModel;
    [self.collectionView reloadData];
    
    
}


#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.userCommentModel.PhotoUrls.count);
    
    if (self.userCommentModel.PhotoUrls.count >3)
    {
        return 3;
    }
    return self.userCommentModel.PhotoUrls.count>0?self.userCommentModel.PhotoUrls.count:0;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell * cell;
    id object = nil;
    
    CommentImageCollectionViewCell * commonCell = [CommentImageCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:CommentImageCollectionViewCellId forIndexPath:indexPath];
    object = self.userCommentModel.PhotoUrls[indexPath.row];
    cell = commonCell;
    
    [cell layoutWithObject:object];
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    return CGSizeMake(ScreenWidth*0.27, ScreenWidth*0.27);
    
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* imageUrl = self.userCommentModel.PhotoUrls[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(didClickCommentImageWithCommentImageCollectionView:withImageUrl:)])
    {
        [self.delegate didClickCommentImageWithCommentImageCollectionView:self withImageUrl:imageUrl];
    }
}
////每个item之间的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5f;
}
@end
