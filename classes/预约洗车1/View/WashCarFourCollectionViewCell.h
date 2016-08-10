//
//  WashCarFourCollectionViewCell.h
//  一号车库
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@class WashCarFourCollectionViewCell;
@protocol WashCarFourCollectionViewCellDelegate <NSObject>

@optional
-(void)didClickSubmitButtonWithWashCarFourCollectionViewCell:(WashCarFourCollectionViewCell*)washCarFourCollectionViewCell;

@end
@interface WashCarFourCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const WashCarFourCollectionViewCellId;
/**
 *  cell创建方法
 */
+(WashCarFourCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@property (nonatomic, weak) id <WashCarFourCollectionViewCellDelegate> delegate;
@end
