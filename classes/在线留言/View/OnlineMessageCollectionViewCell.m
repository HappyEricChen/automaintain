//
//  OnlineMessageCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "OnlineMessageCollectionViewCell.h"
#import "OnlineMessageModel.h"

@interface OnlineMessageCollectionViewCell()

@property (nonatomic, weak) UILabel* questionLabel;

@property (nonatomic, weak) UILabel* answerLabel;

@property (nonatomic, weak) UILabel* stateLabel;
@end
@implementation OnlineMessageCollectionViewCell

NSString* const OnlineMessageCollectionViewCellId = @"OnlineMessageCollectionViewCellId";

+(OnlineMessageCollectionViewCell *)collectionView:(UICollectionView *)collectionView
            dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                      forIndexPath:(NSIndexPath *)indexPath
{
    OnlineMessageCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                      forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        

        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 2;
        self.layer.borderColor = UIColorFromRGB(0x929292).CGColor;
       
        
        UILabel* questionLabel = [[UILabel alloc]init];
        questionLabel.font = [UIFont boldSystemFontOfSize:12];
        questionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        questionLabel.numberOfLines = 0;
        [self addSubview:questionLabel];
        self.questionLabel = questionLabel;
        
        
        UILabel* answerLabel = [[UILabel alloc]init];
        answerLabel.translatesAutoresizingMaskIntoConstraints = NO;
        answerLabel.font = [UIFont systemFontOfSize:9];
        answerLabel.textColor = [UIColor blueColor];
        answerLabel.numberOfLines = 0;
        [self addSubview:answerLabel];
        self.answerLabel = answerLabel;
        
        
        UILabel* stateLabel = [[UILabel alloc]init];
        stateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        stateLabel.font = [UIFont systemFontOfSize:12];
        stateLabel.textColor = UIColorFromRGB(0xe71a39);
        stateLabel.textAlignment = NSTextAlignmentRight;
        stateLabel.text = @"未回复";
        [self addSubview:stateLabel];
        self.stateLabel = stateLabel;
        
        
        questionLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.035).topSpaceToView(self,ScreenHeight*0.02).rightSpaceToView(self,ScreenWidth*0.035).autoHeightRatio(0);
        
        answerLabel.sd_layout.leftEqualToView(questionLabel).bottomSpaceToView(self,ScreenHeight*0.015).rightEqualToView(questionLabel).autoHeightRatio(0);

        stateLabel.sd_layout.bottomSpaceToView(self,ScreenHeight*0.015).rightSpaceToView(self,ScreenWidth*0.032).leftSpaceToView(self,ScreenWidth*0.032).autoHeightRatio(0);
        
        
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    if ([object isKindOfClass:[OnlineMessageModel class]])
    {
        OnlineMessageModel* onlineMessageModel = (OnlineMessageModel*)object;
        
        self.questionLabel.text = onlineMessageModel.Text;
        self.answerLabel.text = onlineMessageModel.ReplyContent;
        
        if (!self.answerLabel.text || [self.answerLabel.text isEqualToString:@""])
        {
            self.stateLabel.hidden = NO;
        }
        else
        {
            self.stateLabel.hidden = YES;
        }
        
    }
}

@end
