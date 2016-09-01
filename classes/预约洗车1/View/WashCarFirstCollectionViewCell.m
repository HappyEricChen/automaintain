//
//  WashCarFirstCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/6/28.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WashCarFirstCollectionViewCell.h"
#import "LDCalendarView.h"
#import "NSDate+Extend.h"

@interface WashCarFirstCollectionViewCell()

@property (nonatomic, strong)LDCalendarView    *calendarView;//日历控件
@property (nonatomic, strong)NSNumber *seletedDay;//选择的日期
@property (nonatomic, weak) UILabel* dateLabel;
@property (nonatomic, copy)NSString *showStr;//显示的日期内容
@property (nonatomic, weak) UIButton* lastDayButton;//上一天按钮
@end

@implementation WashCarFirstCollectionViewCell

NSString* const washCarFirstId = @"washCarFirstId";

+(WashCarFirstCollectionViewCell *)collectionView:(UICollectionView *)collectionView
    dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                              forIndexPath:(NSIndexPath *)indexPath
{
    WashCarFirstCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                              forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = UIColorFromRGB(0xf0f8fb);
        
        UIButton* lastDayButton = [[UIButton alloc]init];
        [lastDayButton setTitle:@"上一天" forState:UIControlStateNormal];
        [lastDayButton addTarget:self action:@selector(clickYesterdayButton) forControlEvents:UIControlEventTouchUpInside];
        lastDayButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [lastDayButton setTitleColor:UIColorFromRGB(0x40add8) forState:UIControlStateNormal];
        lastDayButton.hidden = YES;
        [self addSubview:lastDayButton];
        self.lastDayButton = lastDayButton;
        CGFloat lastDayWidth = [lastDayButton calculateWidthWithLabelContent:@"上一天"
                                                                 WithFontName:nil
                                                                 WithFontSize:11
                                                                     WithBold:NO];
        
        
        UILabel* dateLabel = [[UILabel alloc]init];
        dateLabel.font = [UIFont boldSystemFontOfSize:12];
        dateLabel.text = [NSDate stringWithTimestamp:[NSDate date].timeIntervalSince1970 format:@"yyyy年MM月dd日"];
        [self addSubview:dateLabel];
        CGFloat dateLabelWidth = [dateLabel calculateWidthWithLabelContent:@"2016年06月30日"
                                                     WithFontName:nil
                                                     WithFontSize:12
                                                         WithBold:YES];
        self.dateLabel = dateLabel;
        
        dateLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickDateLabel)];
        singleRecognizer.numberOfTapsRequired = 1;
        [dateLabel addGestureRecognizer:singleRecognizer];
        
        
        UIButton* nextDayButton = [[UIButton alloc]init];
        [nextDayButton setTitle:@"下一天" forState:UIControlStateNormal];
        nextDayButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [nextDayButton addTarget:self action:@selector(clickTomorrowButton) forControlEvents:UIControlEventTouchUpInside];
        [nextDayButton setTitleColor:UIColorFromRGB(0x40add8) forState:UIControlStateNormal];
        [self addSubview:nextDayButton];
        
        dateLabel.sd_layout.centerXEqualToView(self).centerYEqualToView(self).heightRatioToView(self,1).widthIs(dateLabelWidth+5);
        lastDayButton.sd_layout.leftSpaceToView(self,ScreenWidth*0.184).topEqualToView(self).bottomEqualToView(self).widthIs(lastDayWidth);
        nextDayButton.sd_layout.rightSpaceToView(self,ScreenWidth*0.184).topEqualToView(self).bottomEqualToView(self).widthRatioToView(lastDayButton,1);
        
        [self.dateLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotify_selected_date object:nil userInfo:@{@"currentDate":self.dateLabel.text}];
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)dealloc
{
    if (self.dateLabel)
    {
        [self.dateLabel removeObserver:self forKeyPath:@"text"];
    }
}

-(void)clickDateLabel
{
    self.calendarView.defaultDay = _seletedDay;
    [self.calendarView changeYearAndMonth];
    [self.calendarView refreshDateTitle];
    [self.calendarView show];
}


- (NSString *)showStr {
    
    NSString *partStr = [NSDate stringWithTimestamp:self.seletedDay.doubleValue format:@"yyyy年MM月dd日"];
    
    NSString* todayStr = [NSDate stringWithTimestamp:[NSDate date].timeIntervalSince1970 format:@"yyyy年MM月dd日"];
    if ([partStr isEqualToString:todayStr])
    {
        self.lastDayButton.hidden = YES;
    }
    else
    {
        self.lastDayButton.hidden = NO;
    }
    
    return partStr;
}

- (LDCalendarView *)calendarView
{
    if (!_calendarView)
    {
        _calendarView = [[LDCalendarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
        [self.window addSubview:_calendarView];
//        self.seletedDay = @([[NSDate date]timeIntervalSince1970]);
        [_calendarView hide];//第一次点上一天下一天时隐藏界面
        __weak typeof(self) weakSelf = self;
        _calendarView.complete = ^(NSNumber *result)
        {
            if (result)
            {
                weakSelf.seletedDay = result;
                weakSelf.dateLabel.text = weakSelf.showStr;
            }
        };
    }
    return _calendarView;
}
#pragma mark - 点击上一天按钮
- (void)clickYesterdayButton
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
//    [self.calendarView clickForIndex:self.calendarView.selectedButton.tag-100-1];
    [self.calendarView clickLastDayButton];
    
    NSString* todayStr = [NSDate stringWithTimestamp:[NSDate date].timeIntervalSince1970 format:@"yyyy年MM月dd日"];
    if ([self.dateLabel.text isEqualToString:todayStr])
    {
        self.lastDayButton.hidden = YES;
    }
    
}
#pragma mark - 点击下一天按钮
- (void)clickTomorrowButton
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    //    [self.calendarView clickForIndex:self.calendarView.selectedButton.tag-100+1];
    [self.calendarView clickNextDayButton];
    if (self.lastDayButton.hidden)
    {
        self.lastDayButton.hidden = NO;//显示上一天按钮
    }
    
    
}
@end
