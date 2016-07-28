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
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel* label1 = [[UILabel alloc]init];
        label1.text = @"免费便民服务区";
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = FONT_FZZYJW(12);
        label1.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:label1];
        
        UIView* baseView = [[UIView alloc]init];
        baseView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:baseView];
        
        UIImageView * imageView1 = [[UIImageView alloc]initWithImage:ImageNamed(@"home_line")];
        imageView1.clipsToBounds = YES;
        imageView1.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:imageView1];
        
        UILabel* label2 = [[UILabel alloc]init];
        label2.text = @"Convenience service";
        label2.textAlignment = NSTextAlignmentCenter;
        label2.font = FONT_Aparajita(12);
        
        label2.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:label2];
        
        UIImageView * imageView2 = [[UIImageView alloc]initWithImage:ImageNamed(@"home_line")];
        imageView2.translatesAutoresizingMaskIntoConstraints = NO;
        imageView2.clipsToBounds = YES;
        [baseView addSubview:imageView2];
        
        CommonCollectionView* collectionView = [[CommonCollectionView alloc]init];
        collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        collectionView.fontSize = 10;
        collectionView.pageName = @"home";
        collectionView.textColor = UIColorFromRGB(0x7b7b7b);
        [self addSubview:collectionView];
        self.commonCollectionView = collectionView;
        
        label1.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(self,11).autoHeightRatio(0);
        baseView.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(label1,7).heightIs(ScreenHeight*0.017);
        label2.sd_layout.centerXEqualToView(baseView).centerYEqualToView(baseView).heightRatioToView(baseView,1).widthIs(ScreenWidth*0.3);
        imageView1.sd_layout.leftSpaceToView(baseView,ScreenWidth*0.048).centerYEqualToView(label2).widthIs((ScreenWidth-36-label2.width-20)*0.5).heightIs(0.5);
        imageView2.sd_layout.rightSpaceToView(baseView,ScreenWidth*0.048).centerYEqualToView(label2).widthIs((ScreenWidth-36-label2.width-20)*0.5).heightIs(0.5);
        
        collectionView.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(baseView,ScreenHeight*0.22*0.1).bottomSpaceToView(self,0);
        
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
