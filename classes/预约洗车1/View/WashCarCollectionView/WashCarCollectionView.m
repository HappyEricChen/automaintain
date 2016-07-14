//
//  WashCarCollectionView.m
//  一号车库
//
//  Created by eric on 16/7/14.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WashCarCollectionView.h"
#import "WashCarCollectionViewCell.h"
#import "WashCarDateListModel.h"

@interface WashCarCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WashCarCollectionViewCellDelegate>

/**
 *  显示选中状态的唯一按钮
 */
@property (nonatomic, strong)UIButton* currentBtn;
@end
@implementation WashCarCollectionView

-(NSMutableArray *)fullOrderArr
{
    if (!_fullOrderArr)
    {
        _fullOrderArr = [NSMutableArray array];
    }
    return _fullOrderArr;
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsVerticalScrollIndicator = NO;
        [collectionView registerClass:[WashCarCollectionViewCell class] forCellWithReuseIdentifier:WashCarCollectionViewCell1Id];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        
        collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalArr.count>0?self.totalArr.count:0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell * cell = nil;
    id object = nil;
    if (indexPath.section == 0)
    {
        WashCarCollectionViewCell * commonCell = [WashCarCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:WashCarCollectionViewCell1Id forIndexPath:indexPath];
        object = self.totalArr[indexPath.row];
        commonCell.delegate = self;
        
        commonCell.buttonColor = whiteColor;
        for (NSInteger i=0; i<self.myOrderArr.count; i++)
        {
            if ([object isEqualToString:self.myOrderArr[i]])
            {
                commonCell.buttonColor = blueColor;
            }
        }
        
        for (NSInteger i=0; i<self.fullOrderArr.count; i++)
        {
            if ([object isEqualToString:self.fullOrderArr[i]])
            {
                commonCell.buttonColor = redColor;
            }
        }
        
        
        cell = commonCell;
    }
    [cell layoutWithObject:object];
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(ScreenWidth*0.27, ScreenHeight*0.04);
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, ScreenWidth*0.04, 0, ScreenWidth*0.04);
}
#pragma mark - 解析模型
-(void)parseWashCarDateListModel
{
    NSArray* tempArr =[self.washCarDateListModel.Schedule allKeys];
    self.totalArr = [tempArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];//排序
    
    for (NSString* tempStr in self.totalArr)
    {
        NSString* countStr = [[self.washCarDateListModel.Schedule objectForKey:tempStr]stringValue];
        
        if ([countStr isEqualToString:self.washCarDateListModel.MaxPlaceNum])
        {
            [self.fullOrderArr addObject:tempStr];//他人预约
        }
    }
    
    self.myOrderArr = self.washCarDateListModel.MySchedule;//我的预约
}
#pragma mark -WashCarCollectionViewCellDelegate
-(void)didSelectedButtonWithWashCarCollectionViewCell:(WashCarCollectionViewCell *)washCarCollectionViewCell withCurrentBtn:(UIButton *)sender
{
    
    if (self.currentBtn != sender)
    {
        self.currentBtn.selected = NO;
        self.currentBtn = sender;
    }
    self.currentBtn.selected = YES;
//    for (NSInteger i=0; i<self.fullOrderArr.count; i++)
//    {
//        if ([self.totalArr[indexPath.row] isEqualToString:self.fullOrderArr[i]])
//        {
//            return;
//        }
//    }
//    for (NSInteger i=0; i<self.myOrderArr.count; i++)
//    {
//        if ([self.totalArr[indexPath.row] isEqualToString:self.myOrderArr[i]])
//        {
//            [SVProgressHUD showErrorWithStatus:@"已预约过的请在我的预约取消"];
//            return;
//        }
//    }
//    
//        for (NSString* timeStr in self)
//        {
//            <#statements#>
//        }
//        sender.selected = !sender.isSelected;

}
@end
