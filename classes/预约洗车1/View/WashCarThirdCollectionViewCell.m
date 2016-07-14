//
//  WashCarThirdCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/6/28.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WashCarThirdCollectionViewCell.h"
#import "WashCarCollectionView.h"
#import "WashCarDateListModel.h"

@interface WashCarThirdCollectionViewCell()

@property (nonatomic, weak) WashCarCollectionView* washCarCollectionView;


@end
@implementation WashCarThirdCollectionViewCell

NSString* const WashCarThirdCollectionViewCellId = @"WashCarThirdCollectionViewCellId";

+(WashCarThirdCollectionViewCell *)collectionView:(UICollectionView *)collectionView
           dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                     forIndexPath:(NSIndexPath *)indexPath
{
    WashCarThirdCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                      forIndexPath:indexPath];
    
    return cell;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = UIColorFromRGB(0xf6f6f6);
        
        WashCarCollectionView* collectionView = [[WashCarCollectionView alloc]init];
        collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:collectionView];
        self.washCarCollectionView = collectionView;
        
        collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
      
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    if ([object isKindOfClass:[WashCarDateListModel class]])
    {
        self.washCarCollectionView.washCarDateListModel = (WashCarDateListModel*)object;
        [self.washCarCollectionView parseWashCarDateListModel];//解析模型
        [self.washCarCollectionView.collectionView reloadData];
    }
}
@end
