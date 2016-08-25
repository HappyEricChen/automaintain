//
//  WashCarFiveCollectionViewCell.h
//  一号车库
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@class WashCarFiveCollectionViewCell;

@protocol WashCarFiveCollectionViewCellDelegate <NSObject>

@optional
-(void)didClickCarImageWithWashCarFiveCollectionViewCell:(WashCarFiveCollectionViewCell*)washCarFiveCollectionViewCell withImageUrl:(NSString*)imageUrl;
@end
@interface WashCarFiveCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const WashCarFiveCollectionViewCellId;
/**
 *  cell创建方法
 */
+(WashCarFiveCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@property (nonatomic, weak) id<WashCarFiveCollectionViewCellDelegate> delegate;


@end
