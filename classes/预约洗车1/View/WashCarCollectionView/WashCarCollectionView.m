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
#import "ScheduleListModel.h"
@interface WashCarCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WashCarCollectionViewCellDelegate>

/**
 *  显示选中状态的唯一按钮
 */
@property (nonatomic, strong)UIButton* currentBtn;
/**
 *  当前选中的位置
 */
@property (nonatomic, assign) NSInteger  currentIndex;
@end
@implementation WashCarCollectionView

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
        
        self.currentIndex = -1;
    
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
    return self.washCarDateListModel.Schedule.count>0?self.washCarDateListModel.Schedule.count:0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell * cell;
    id object = nil;
    if (indexPath.section == 0)
    {
        WashCarCollectionViewCell * commonCell = [WashCarCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:WashCarCollectionViewCell1Id forIndexPath:indexPath];
        object = self.washCarDateListModel.Schedule[indexPath.row];
        commonCell.delegate = self;
        
        
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
    for (ScheduleListModel* scheduleListModel in self.washCarDateListModel.Schedule)
    {
        NSString* countStr = scheduleListModel.AppointmentCount;
        
        if (countStr.integerValue >= self.washCarDateListModel.MaxPlaceNum.integerValue)
        {
            scheduleListModel.AppointmentCount = @"full";//他人预约
        }
        if (scheduleListModel.MyAppointmentCount.integerValue>0)
        {
            scheduleListModel.AppointmentCount = @"myOrder";//我的预约
        }
        
    }
}
#pragma mark -WashCarCollectionViewCellDelegate
-(void)didSelectedButtonWithWashCarCollectionViewCell:(WashCarCollectionViewCell *)washCarCollectionViewCell withCurrentBtn:(UIButton *)sender
{
    
    if (self.currentBtn != sender)
    {
        //        self.currentBtn.selected = NO;
        
        self.currentBtn = sender;
        
    }
    self.currentBtn.selected = YES;
    
    
  
    
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentIndex != -1)
    {
        if (self.currentIndex != indexPath.row)
        {
            
            ScheduleListModel* scheduleListModel = self.washCarDateListModel.Schedule[self.currentIndex];
            /**
             *  之前选中的按钮不是，我的预约和他人已预约时，改变颜色
             */
            if (![scheduleListModel.AppointmentCount isEqualToString:@"myOrder"] && ![scheduleListModel.AppointmentCount isEqualToString:@"full"])
            {
                scheduleListModel.AppointmentCount = @"0";
            }
            
            
            self.currentIndex = indexPath.row;
        }
        
    }
    else
    {
        self.currentIndex = indexPath.row;
    }
    
    ScheduleListModel* scheduleListModel1 = self.washCarDateListModel.Schedule[self.currentIndex];
    scheduleListModel1.AppointmentCount = @"myTempOrder";
    
    [collectionView reloadData];//刷新界面
    
    /**
     *  选中的时间传递出去
     */
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotify_myOrder_StartTime object:nil userInfo:@{@"time":scheduleListModel1.TimeSegment}];
}
@end
