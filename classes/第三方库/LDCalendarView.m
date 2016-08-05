//
//  LDCalendarView.m
//
//  Created by lidi on 15/9/1.
//  Copyright (c) 2015年 lidi. All rights reserved.
//

#import "LDCalendarView.h"
#import "NSDate+Extend.h"
#import "UIColor+Extend.h"

#define UNIT_WIDTH  35 * SCREEN_RAT

//行 列 每小格宽度 格子总数
static const NSInteger kRow         = 1 + 6;//一,二,三... 1行 日期6行
static const NSInteger kCol         = 7;//7列
//static const NSInteger kTotalNum    = (kRow - 1) * kCol;//日期总数
static const NSInteger kBtnStartTag = 100;// 按钮的tag初始值

@interface LDCalendarView()<UIGestureRecognizerDelegate>
//UI
@property (nonatomic, strong) UIView         *contentBgView,*dateBgView;
@property (nonatomic, strong) UILabel        *titleLab;//标题

//Data
@property (nonatomic, assign) NSUInteger kTotalNum;//当前月总的天数
@property (nonatomic, assign) int32_t        year,month;
@property (nonatomic, strong) NSDate         *today,*firstDay; //今天 当月第一天
@property (nonatomic, strong) NSMutableArray *currentMonthDaysArray;//当前月的天数数组
@property (nonatomic, strong) NSNumber* selectedDay;//选中的某天
@property (nonatomic, assign) CGRect         touchRect;//可操作区域
@end

@implementation LDCalendarView
/**
 *  获取格式化的今天
 */
- (NSDate *)today {
    if (!_today) {
        NSDate *currentDate = [NSDate date];
        
        NSDate *yesterday = [NSDate dateWithTimeInterval:-60 * 60 * 24 sinceDate:currentDate];

        //字符串转换为日期,今天0点的时间
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        _today = [dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",@(yesterday.year),@(yesterday.month),@(yesterday.day)]];
        
    }
    return _today;
}
/**
 *  当月第一天
 */
- (NSDate *)firstDay {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *firstDay =[dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",@(self.year),@(self.month),@(1)]];
    return firstDay;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if (_complete) {
            _complete(_selectedDay);
        }
        
        self.dateBgView =
        ({
            UIView *view         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            view.alpha           = 0.3;
            view.backgroundColor = [UIColor blackColor];
            [self addSubview:view];
            view;
        });
        /**
         添加手势，点击背景图，隐藏时间列表
         */
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCollectionView)];
        tapGesture.delegate = self;
        [self.dateBgView addGestureRecognizer:tapGesture];

        /**
         *  内容区的背景, 包括左右两边的箭头View
         */
        self.contentBgView = ({
            
            UIView        *view         = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-UNIT_WIDTH*kCol)/2.0, 100, UNIT_WIDTH*kCol, 42+UNIT_WIDTH*kRow)];
            view.layer.cornerRadius     = 2.0;
            view.layer.masksToBounds    = YES;
            view.userInteractionEnabled = YES;
            view.backgroundColor        = [UIColor whiteColor];
            [self addSubview:view];
            
            ({
                UIImageView *leftImage = [UIImageView new];
                leftImage.image        = [UIImage imageNamed:@"com_arrows_right"];
                leftImage.image        = [UIImage imageWithCGImage:leftImage.image.CGImage scale:1 orientation:UIImageOrientationDown];
                [view addSubview:leftImage];
                leftImage.frame        = CGRectMake(CGRectGetWidth(view.frame)/3.0 - 8 - 20, (42-13)/2.0, 8, 13);
            });
            
            ({
                UIImageView *rightImage = [UIImageView new];
                rightImage.image        = [UIImage imageNamed:@"com_arrows_right"];
                [view addSubview:rightImage];
                rightImage.frame        = CGRectMake(CGRectGetWidth(view.frame)*2/3.0 + 18, (42-13)/2.0, 8, 13);
            });
            
            view;
        });

        /**
         *  年份月份标题View
         */
        self.titleLab = ({
            UILabel *lab               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_contentBgView.frame), 42)];
            lab.backgroundColor        = [UIColor clearColor];
            lab.textColor              = [UIColor blackColor];
            lab.font                   = [UIFont systemFontOfSize:14];
            lab.textAlignment          = NSTextAlignmentCenter;
            lab.userInteractionEnabled = YES;
            [_contentBgView addSubview:lab];
            
            ({
                UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchMonthTap:)];
                [lab addGestureRecognizer:titleTap];
                
                UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame) - 0.5, CGRectGetWidth(_contentBgView.frame), 0.5)];
                line.backgroundColor = [UIColor hexColorWithString:@"dddddd"];
                [_contentBgView addSubview:line];
            });
            
            lab;
        });
        /**
         *  日期详情列表的背景View
         */
        self.dateBgView = ({
            UIView *view                = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLab.frame), CGRectGetWidth(_contentBgView.frame), UNIT_WIDTH*kRow)];
            view.userInteractionEnabled = YES;
            view.backgroundColor        = [UIColor hexColorWithString:@"ededed"];
            [_contentBgView addSubview:view];
            
            ({
                UIView *bottomLine         = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), CGRectGetWidth(_contentBgView.frame), 0.5)];
                bottomLine.backgroundColor = [UIColor hexColorWithString:@"dddddd"];
                [_contentBgView addSubview:bottomLine];
            });
            
            ({
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
                [view addGestureRecognizer:tap];
            });
            view;
        });
        /**
         初始化数据
         */
        [self initData];
    }
    return self;
}
#pragma mark - 初始化数据
- (void)initData {
    
    if (!_selectedDay)
    {
        _selectedDay        = 0;
    }
    
    //获取当前选择日期的年月
    NSDate *currentDate = [NSDate date];
    self.month          = (int32_t)currentDate.month;
    self.year           = (int32_t)currentDate.year;
    /**
     *  初始化当月的总天数
     */
    self.kTotalNum = [NSDate numberOfDaysInMonthWithMounth:currentDate];
    /**
     *  刷新月份年份标题View
     */
    [self refreshDateTitle];

    _currentMonthDaysArray = [NSMutableArray array];
    for (int i = 0; i < self.kTotalNum; i++) {
        [_currentMonthDaysArray addObject:@(0)];
    }

    /**
     *  显示日期列表View
     */
    [self showDateView];
}
#pragma mark - 点击更换月份，年份
- (void)switchMonthTap:(UITapGestureRecognizer *)tap {
   CGPoint loc =  [tap locationInView:_titleLab];
    CGFloat titleLabWidth = CGRectGetWidth(_titleLab.frame);
    if (loc.x <= titleLabWidth/3.0) {
        [self leftSwitch];
    }else if(loc.x >= titleLabWidth/3.0*2.0){
        [self rightSwitch];
    }
}

/**
 *  点击左边的按钮，月份-1
 */
- (void)leftSwitch{
    if (self.month > 1) {
        self.month -= 1;
    }else {
        self.month = 12;
        self.year -= 1;
    }
    
    [self refreshDateTitle];
}

/**
 *  点击右边的按钮，月份+1
 */
- (void)rightSwitch {
    if (self.month < 12) {
        self.month += 1;
    }else {
        self.month = 1;
        self.year += 1;
    }
    /**
     *  刷新月份年份标题View
     */
    [self refreshDateTitle];
}
#pragma mark -刷新月份年份标题View
- (void)refreshDateTitle {
    _titleLab.text = [NSString stringWithFormat:@"%@月,%@年",@(self.month),@(self.year)];
    /**
     *  显示日期列表
     */
    [self showDateView];
}

/**
 *  星期一到星期日的View的展示
 */
- (void)drawTitleView {
    CGRect baseRect = CGRectMake(0.0,0.0, UNIT_WIDTH, UNIT_WIDTH);
    NSArray *tmparr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    for(int i = 0 ;i < 7; i++)
    {
        UILabel *lab        = [[UILabel alloc] initWithFrame:baseRect];
        lab.textColor       = [UIColor hexColorWithString:@"848484"];
        lab.textAlignment   = NSTextAlignmentCenter;
        lab.font            = [UIFont systemFontOfSize:10];
        lab.backgroundColor = [UIColor clearColor];
        lab.text            = [tmparr objectAtIndex:i];
        [_dateBgView addSubview:lab];
        
        baseRect.origin.x   += baseRect.size.width;
    }
}

- (CGFloat)calculateStartIndex:(NSDate *)firstDay {
    NSInteger startDayIndex = [NSDate acquireWeekDayFromDate:firstDay];
    //第一天是今天，特殊处理
    if (startDayIndex == 1) {
        //星期天（对应一）
        startDayIndex = 6;
    }else {
        //周一到周六（对应2-7）
        startDayIndex -= 2;
    }
    return startDayIndex;
}

- (void)createBtn:(NSInteger)i frame:(CGRect)baseRect {
    UIButton *btn              = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag                    = kBtnStartTag + i;
    [btn setFrame:baseRect];
    btn.userInteractionEnabled = NO;
    btn.backgroundColor = [UIColor clearColor];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    
    NSInteger startDayIndex = [self calculateStartIndex:self.firstDay];
    NSDate * date = [self.firstDay dateByAddingTimeInterval: (i-startDayIndex)*24*60*60];
    _currentMonthDaysArray[i] = @([date timeIntervalSince1970]);
    NSString *title = INTTOSTR(date.day);
    if ([date isToday]) {
        title = @"今天";
        /**
         *  选中的日期为0的时候，将今天设置为高亮
         */
        if (!_selectedDay || [_selectedDay isEqual:@0])
        {
            [btn setBackgroundImage:ImageNamed(@"order_choose_blue") forState:UIControlStateNormal];
            self.selectedButton = btn;
        }
        
    }
    else if(date.day == 1) {
        //1号在下面标一下月份
        UILabel *monthLab        = [[UILabel alloc] initWithFrame:CGRectMake(baseRect.origin.x, baseRect.origin.y + baseRect.size.height - 7, baseRect.size.width, 7)];
        monthLab.backgroundColor = [UIColor clearColor];
        monthLab.textAlignment   = NSTextAlignmentCenter;
        monthLab.font            = [UIFont systemFontOfSize:7];
        monthLab.textColor       = [UIColor hexColorWithString:@"c0c0c0"];
        monthLab.text            = [NSString stringWithFormat:@"%@月",@(date.month)];
        [_dateBgView addSubview:monthLab];
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    if ([self.today compare:date] < 0) {
        //时间比今天大,同时是当前月
        [btn setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
    }else {
        [btn setTitleColor:[UIColor hexColorWithString:@"bfbfbf"] forState:UIControlStateNormal];
    }
    [btn setBackgroundColor:[UIColor clearColor]];
    
    [_dateBgView addSubview:btn];
}

- (void)showDateView {
    //移除之前子视图
    [_dateBgView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    //一，二，三，四...
    [self drawTitleView];

    CGFloat startDayIndex       = [self calculateStartIndex:self.firstDay];
    CGRect baseRect             = CGRectMake(UNIT_WIDTH * startDayIndex,UNIT_WIDTH, UNIT_WIDTH, UNIT_WIDTH);
    
    /**
     *  获取当月总天数
     */
    self.kTotalNum = [NSDate numberOfDaysInMonthWithMounth:self.firstDay];
    [self.currentMonthDaysArray removeAllObjects];
    for (int i = 0; i < self.kTotalNum; i++)
    {
        [self.currentMonthDaysArray addObject:@(0)];
    }
    
    //设置触摸区域
    self.touchRect = ({
        CGRect rect = CGRectZero;
        rect.origin      = baseRect.origin;
        rect.origin.x    = 0;
        rect.size.width  = kCol * UNIT_WIDTH;
        rect.size.height = kRow * UNIT_WIDTH;
        
        rect;
    });
    
    for(int i = startDayIndex; i < self.kTotalNum+startDayIndex;i++) {
        //需要换行且不在第一行
        if (i % kCol == 0 && i != 0) {
            baseRect.origin.y += (baseRect.size.height);
            baseRect.origin.x = 0.0;
        }
        /**
         *  创建日期按钮
         */
        [self createBtn:i frame:baseRect];

        baseRect.origin.x += (baseRect.size.width);
    }
    
    //高亮选中的
    [self refreshDateView];
}
-(void)setDefaultDay:(NSNumber *)defaultDay
{
    _defaultDay = defaultDay;
    if (defaultDay)
    {
        _selectedDay = defaultDay.copy;
    }
    else
    {
        _selectedDay = 0;
    }
}

/**
 *  高亮选中的日期
 */
- (void)refreshDateView {
    for(int i = 0; i < self.kTotalNum; i++) {
        UIButton *btn = (UIButton *)[_dateBgView viewWithTag:kBtnStartTag + i];
        NSNumber *interval = [_currentMonthDaysArray objectAtIndex:i];

        if (i < [_currentMonthDaysArray count] && btn)
        {
            if ([_selectedDay isEqual:interval])
            {
                [btn setBackgroundImage:ImageNamed(@"order_choose_blue") forState:UIControlStateNormal];
                self.selectedButton = btn;
            }
            else
            {
                [btn setBackgroundImage:nil forState:UIControlStateNormal];
            }
        }
    }
}
#pragma mark - 点击选择日期
-(void)tap:(UITapGestureRecognizer *)gesture{
    CGPoint point = [gesture locationInView:_dateBgView];
    if (CGRectContainsPoint(_touchRect, point)) {
        CGFloat w       = (CGRectGetWidth(_dateBgView.frame)) / kCol;
        CGFloat h       = (CGRectGetHeight(_dateBgView.frame)) / kRow;
        int row         = (int)((point.y - _touchRect.origin.y) / h);
        int col         = (int)((point.x) / w);

        NSInteger index = row * kCol + col;
        [self clickForIndex:index];
    }
}

- (void)clickForIndex:(NSInteger)index
{
    UIButton *btn = (UIButton *)[_dateBgView viewWithTag:kBtnStartTag + index];
    
    if (index < [_currentMonthDaysArray count]) {
        NSNumber *interval = [_currentMonthDaysArray objectAtIndex:index];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval.doubleValue];
        
        if ([self.today  compare:date] < 0) {
            //时间比今天大,同时是当前月
        }else {
            return;
        }
        
        if ([_selectedDay isEqual: interval]) {
            
            if (_complete) {
                _complete(_selectedDay);
            }
            [self hide];
            
        }
        else {
            //未选中,想选择
            [self.selectedButton setBackgroundImage:nil forState:UIControlStateNormal];
            _selectedDay = interval;
            btn.selected =!btn.isSelected;
            if (_complete) {
                _complete(_selectedDay);
            }
            [self hide];
            
        }
    }
    self.selectedButton = btn;
}
/**
 *  点击上一天按钮调用
 */
-(void)clickLastDayButton
{
    NSDate *selectedDate = [NSDate dateWithTimeIntervalSince1970:self.selectedDay.doubleValue];
    
    NSDate * date = [selectedDate dateByAddingTimeInterval: (-1)*24*60*60];
    self.selectedDay = @([date timeIntervalSince1970]);
    
    /**
     *  将新的日期传递回View
     */
    if (_complete) {
        _complete(_selectedDay);
    }
    /**
     *  刷新高亮的日期
     */
    [self refreshDateView];
}
/**
 *  点击下一天按钮调用
 */
-(void)clickNextDayButton
{
    NSDate *selectedDate;
    if (!self.selectedDay)
    {
        selectedDate = [NSDate date];
    }
    else
    {
        selectedDate = [NSDate dateWithTimeIntervalSince1970:self.selectedDay.doubleValue];
    }
    
    NSDate * date = [selectedDate dateByAddingTimeInterval: (1)*24*60*60];
    self.selectedDay = @([date timeIntervalSince1970]);
    
    /**
     *  将新的日期传递回View
     */
    if (_complete) {
        _complete(_selectedDay);
    }
    /**
     *  刷新高亮的日期
     */
    [self refreshDateView];
}

- (void)show {
    self.hidden = NO;
}

- (void)hide {
    self.hidden = YES;
}
/**
 *  点击背景图，隐藏日期列表
 */
-(void)tapCollectionView
{
    self.hidden = YES;
}
@end
