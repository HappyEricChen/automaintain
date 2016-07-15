//
//  WashCarFiveCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WashCarFiveCollectionViewCell.h"
#import "UserCommentModel.h"
@interface WashCarFiveCollectionViewCell()

@property (nonatomic, weak) UIImageView* carImageView;

@property (nonatomic, getter=isClick) BOOL click;
/**
 *  评论内容
 */
@property (nonatomic, weak) UILabel* contentLabel;
/**
 *  评论发布时间
 */
@property (nonatomic, weak) UILabel* timeLabel;
/**
 *  用户名
 */
@property (nonatomic, weak) UILabel* userName;
@end
@implementation WashCarFiveCollectionViewCell

NSString* const WashCarFiveCollectionViewCellId = @"WashCarFiveCollectionViewCellId";

+(WashCarFiveCollectionViewCell *)collectionView:(UICollectionView *)collectionView
          dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                    forIndexPath:(NSIndexPath *)indexPath
{
    WashCarFiveCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                    forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        /**
         头像／用户名／星星／时间
         */
        UIView* baseView = [[UIView alloc]init];
        baseView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:baseView];
        
        UIImageView* iconImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"order_user")];
        iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:iconImageView];
        
        UILabel* userName = [[UILabel alloc]init];
        userName.text = @"zhujunyi";
        userName.font = [UIFont systemFontOfSize:11];
        userName.textColor = UIColorFromRGB(0x4a4a4a);
        userName.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:userName];
        self.userName = userName;
        CGFloat userNameWidth = [userName calculateWidthWithLabelContent:@"zhujunyi"
                                                            WithFontName:nil
                                                            WithFontSize:11
                                                                WithBold:NO];
        
        
        UIView *baseView1 = [[UIView alloc]init];
        baseView1.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:baseView1];
        
        for (NSInteger i=0; i<5; i++)
        {
            UIImageView* starImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"order_star")];
            starImageView.frame = CGRectMake(5+13*i, 6, 13, 13);
            [baseView1 addSubview:starImageView];
            
        }
        
        UILabel* timeLabel = [[UILabel alloc]init];
        timeLabel.font = [UIFont systemFontOfSize:11];
        timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        
        /**
         *  评论内容
         */
        UILabel* contentLabel = [[UILabel alloc]init];
        contentLabel.font = [UIFont systemFontOfSize:11];
        contentLabel.textColor = UIColorFromRGB(0x4a4a4a);
        contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;

        UIView * carView = [[UIView alloc]init];
        carView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:carView];
        
        for (NSInteger i=0; i<3; i++)
        {
            UIImageView* carImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"order_img")];
            carImageView.frame = CGRectMake((12+70)*i, 0, ScreenWidth*0.189, ScreenHeight*0.073);
            [carView addSubview:carImageView];
            
            UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction)];
            [recognizer setNumberOfTapsRequired:1];
            carImageView.userInteractionEnabled = YES;
            [carImageView addGestureRecognizer:recognizer];
            self.carImageView = carImageView;
        }
        
        baseView.sd_layout.leftSpaceToView(self,10).rightEqualToView(self).topEqualToView(self).heightIs(ScreenHeight*0.03);
        iconImageView.sd_layout.leftEqualToView(baseView).topEqualToView(baseView).widthIs(26).heightIs(26);
        userName.sd_layout.centerYEqualToView(iconImageView).leftSpaceToView(iconImageView,ScreenWidth*0.026).widthIs(userNameWidth).topEqualToView(iconImageView).bottomEqualToView(iconImageView);
        baseView1.sd_layout.centerYEqualToView(userName).leftSpaceToView(userName,ScreenWidth*0.026).heightRatioToView(userName,1).widthIs(ScreenWidth*0.26);
        timeLabel.sd_layout.centerYEqualToView(userName).rightEqualToView(baseView).topEqualToView(userName).bottomEqualToView(userName).widthIs(ScreenWidth*0.24);
        contentLabel.sd_layout.leftSpaceToView(iconImageView,ScreenWidth*0.026).topSpaceToView(baseView,13).rightSpaceToView(self,10).autoHeightRatio(0);
        carView.sd_layout.leftSpaceToView(iconImageView,ScreenWidth*0.026).topSpaceToView(contentLabel,10).bottomEqualToView(self).rightSpaceToView(self,10);
        
        
        
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    UserCommentModel* userCommentModel = (UserCommentModel*)object;
     self.contentLabel.text = userCommentModel.CommentContent;
    self.timeLabel.text = [userCommentModel.CreateTime substringToIndex:10];
//    self.userName.text = userCommentModel.
}



-(void)tapImageAction
{
    
 
    if ([self.delegate respondsToSelector:@selector(didClickCarImageWithWashCarFiveCollectionViewCell:withImageView:)])
    {
        [self.delegate didClickCarImageWithWashCarFiveCollectionViewCell:self withImageView:self.carImageView];
    }
//    if (self.isClick)
//    {
//        /**
//         ios7 后动画效果
//         */
//        __weak WashCarFiveCollectionViewCell* weakSelf = self;
//        [UIView animateWithDuration:1.0//动画时长
//                              delay:0.0//动画延迟
//             usingSpringWithDamping:1.0//弹簧效果0~1
//              initialSpringVelocity:5.0//初始速度
//                            options:UIViewAnimationOptionCurveEaseInOut//动画过渡效果
//                         animations:^{
//                             CGRect temp = weakSelf.carImageView.frame;
//                             temp.origin.x = 0.0f;
//                             temp.size.width = ScreenWidth;
//                             temp.size.height = ScreenWidth*imageRect.size.height/imageRect.size.width;
//                             weakSelf.carImageView.frame = temp;
//                             
//                         } completion:^(BOOL finished) {
//                             
//                         }];
//
//    }

}

@end
