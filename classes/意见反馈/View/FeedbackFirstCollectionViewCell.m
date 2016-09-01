//
//  FeedbackFirstCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "FeedbackFirstCollectionViewCell.h"

@interface FeedbackFirstCollectionViewCell()

@property (nonatomic, weak) UILabel* contentLabel;
@end
@implementation FeedbackFirstCollectionViewCell

NSString * const FeedbackFirstCollectionViewCellId = @"FeedbackFirstCollectionViewCellId";

+(FeedbackFirstCollectionViewCell *)collectionView:(UICollectionView *)collectionView
           dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                     forIndexPath:(NSIndexPath *)indexPath
{
    FeedbackFirstCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                     forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UILabel* titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"反馈类型";
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:titleLabel];
        
        CGFloat titleLabelWidth = [titleLabel calculateWidthWithLabelContent:titleLabel.text
                                                                WithFontName:nil
                                                                WithFontSize:14
                                                                    WithBold:YES];
        
        UIView* baseView = [[UIView alloc]init];
        baseView.backgroundColor = [UIColor whiteColor];
        baseView.layer.borderWidth = 1;
        baseView.layer.borderColor = UIColorFromRGBWithAlpha(0x000000, 0.3).CGColor;
        [self addSubview:baseView];
        
        UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBaseView)];
        baseView.userInteractionEnabled = YES;
        [baseView addGestureRecognizer:tapRecognizer];
        
        UILabel* contentLabel = [[UILabel alloc]init];
        contentLabel.font = [UIFont systemFontOfSize:11];
        [baseView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        
        
        UIImageView* arrowImgeView= [[UIImageView alloc]init];
        arrowImgeView.image = ImageNamed(@"suggestion_down");
        
        [baseView addSubview:arrowImgeView];
        
        
        titleLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.04).topSpaceToView(self,ScreenHeight*0.027).widthIs(titleLabelWidth).autoHeightRatio(0);
        baseView.sd_layout.centerYEqualToView(titleLabel).centerXEqualToView(self).widthIs(ScreenWidth*0.538).heightIs(ScreenHeight*0.034);
        contentLabel.sd_layout.leftSpaceToView(baseView,ScreenWidth*0.048).topEqualToView(baseView).bottomEqualToView(baseView).widthIs(ScreenWidth*0.4);
        arrowImgeView.sd_layout.rightSpaceToView(baseView,5).centerYEqualToView(baseView).widthIs(7).heightIs(4);
        
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    if ([object isKindOfClass:[NSString class]])
    {
        self.contentLabel.text = (NSString*)object;
    }
    
}

/**
 *  点击下拉菜单，弹出tableView
 */
-(void)clickBaseView
{
    if ([self.delegate respondsToSelector:@selector(didClickListButtonWithFeedbackFirstCollectionViewCell:)])
    {
        [self.delegate didClickListButtonWithFeedbackFirstCollectionViewCell:self];
    }
}
/**
 *  回缩列表tableView
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(hiddenListTableView)])
    {
        [self.delegate hiddenListTableView];
    }
}
@end
