//
//  ThirdCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "ThirdCollectionViewCell.h"
#import "CommonCollectionView.h"
#import "ConvenienceServiceModel.h"

@interface ThirdCollectionViewCell()
@property (nonatomic, weak) CommonCollectionView* commonCollectionView;
/**
 *  免费便民服务区label
 */
@property (nonatomic, weak) UILabel* label;
@end
@implementation ThirdCollectionViewCell

NSString* const thirdCellId = @"thirdCellId";

+(ThirdCollectionViewCell *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath
{
    ThirdCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        CommonCollectionView* commonCollectionView = [[CommonCollectionView alloc]init];
        self.commonCollectionView = commonCollectionView;
        [self.contentView addSubview:commonCollectionView];
        
        commonCollectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));

    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    
    if ([object isKindOfClass:[NSArray class]])
    {
        NSMutableArray* totalArr = [NSMutableArray array];
        [totalArr removeAllObjects];
        for (ConvenienceServiceModel* convenienceServiceModel in (NSArray*)object)
        {
            [totalArr addObject:convenienceServiceModel.ServiceName];
        }
        [self.commonCollectionView.totalArr removeAllObjects];
        [self.commonCollectionView.totalArr addObjectsFromArray:totalArr];
        
        [self.commonCollectionView.collectionView reloadData];
    }
}
@end
