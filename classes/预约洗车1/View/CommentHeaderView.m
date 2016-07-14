//
//  CommentHeaderView.m
//  一号车库
//
//  Created by eric on 16/6/28.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "CommentHeaderView.h"

@implementation CommentHeaderView


NSString* const headerId = @"headerId";

+(CommentHeaderView *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath
{
    CommentHeaderView* cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        /**
         用户评价（文字）
         */
        UILabel* label = [[UILabel alloc]init];
        label.text = @"用户评价(288条)";
        label.font = [UIFont systemFontOfSize:11];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:label];
        
        label.sd_layout.leftSpaceToView(self,10).topEqualToView(self).bottomEqualToView(self).widthIs(ScreenWidth*0.5);
    }
    return self;
}
@end
