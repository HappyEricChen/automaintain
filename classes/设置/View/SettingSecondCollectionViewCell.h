//
//  SettingSecondCollectionViewCell.h
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@class SettingSecondCollectionViewCell;
@protocol SettingSecondCollectionViewCellDelegate <NSObject>

@optional
-(void)didClickSubmitButtonWithSettingSecondCollectionViewCell:(SettingSecondCollectionViewCell*)settingSecondCollectionViewCell;

@end

@interface SettingSecondCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const SettingSecondCollectionViewCellId;
/**
 *  cell创建方法
 */
+(SettingSecondCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;


@property (nonatomic, weak) id <SettingSecondCollectionViewCellDelegate> delegate;
@end
