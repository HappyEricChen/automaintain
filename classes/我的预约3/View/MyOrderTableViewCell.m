//
//  MyOrderTableViewCell.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyOrderTableViewCell.h"
#import "MyOrderModel.h"

@interface MyOrderTableViewCell()
/**
 *   审核状态
 */
@property (nonatomic, weak) UILabel* stateTypeLabel;
/**
 *  取消预约/发表评论
 */
@property (nonatomic, weak) UIButton* selectedButton;
/**
 *  距离完成的时间
 */
@property (nonatomic, weak) UILabel* timeCompleteLabel;
/**
 *  2016-05-28 17:00-17:30
 */
@property (nonatomic, weak) UILabel* timeContentLabel;
/**
 *  预约类型
 */
@property (nonatomic, weak) UILabel* typeContentLabel;

/**
 *  倒计时的对象和indexpath
 */
@property (nonatomic, weak)   id           object;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

@end
@implementation MyOrderTableViewCell

NSString* const MyOrderTableViewCellId = @"MyOrderTableViewCellId";

+(MyOrderTableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath
{
    MyOrderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil)
    {
        cell = [[MyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        /**
         注册倒计时的通知
         */
        [self registerNSNotificationCenter];
        
        /**
         预约时间
         */
        UILabel* timeLabel = [[UILabel alloc]init];
        timeLabel.font = [UIFont systemFontOfSize:14];
        timeLabel.text = @"预约时间:";
        [self addSubview:timeLabel];
        CGFloat timeLabelWidth = [timeLabel calculateWidthWithLabelContent:timeLabel.text
                                                                      WithFontName:nil
                                                                      WithFontSize:14
                                                                          WithBold:NO];
        /**
         预约类型
         */
        UILabel* typeLabel = [[UILabel alloc]init];
        typeLabel.font = [UIFont systemFontOfSize:14];
        typeLabel.text = @"预约类型:";
        [self addSubview:typeLabel];
        CGFloat typeLabelWidth = [typeLabel calculateWidthWithLabelContent:typeLabel.text
                                                                     WithFontName:nil
                                                                     WithFontSize:14
                                                                         WithBold:NO];
        /**
         2016-05-28 17:00-17:30
         */
        UILabel* timeContentLabel = [[UILabel alloc]init];
        timeContentLabel.font = [UIFont systemFontOfSize:14];
        timeContentLabel.text = @"2016-05-28 17:00-17:30";
        timeContentLabel.textColor = UIColorFromRGB(0x929292);
        [self addSubview:timeContentLabel];
        self.timeContentLabel = timeContentLabel;
        
        /**
         洗车/维修/更换轮胎
         */
        UILabel* typeContentLabel = [[UILabel alloc]init];
        typeContentLabel.font = [UIFont systemFontOfSize:14];
        typeContentLabel.text = @"洗车/维修/更换轮胎";
        typeContentLabel.textColor = UIColorFromRGB(0x929292);
        [self addSubview:typeContentLabel];
        self.typeContentLabel = typeContentLabel;
        CGFloat typeContentLabelWidth = [typeContentLabel calculateWidthWithLabelContent:typeContentLabel.text
                                                                     WithFontName:nil
                                                                     WithFontSize:14
                                                                         WithBold:NO];
        /**
         审核状态
         */
        UILabel* stateTypeLabel = [[UILabel alloc]init];
        stateTypeLabel.font = [UIFont systemFontOfSize:11];
        stateTypeLabel.textColor = UIColorFromRGB(0xe71a39);
        stateTypeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:stateTypeLabel];
        self.stateTypeLabel = stateTypeLabel;
        
        /**
         取消预约/发表评论
         */
        UIButton* selectedButton = [[UIButton alloc]init];
        selectedButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [selectedButton setTitleColor:UIColorFromRGB(0xff7e31) forState:UIControlStateNormal];
        [selectedButton setBackgroundImage:ImageNamed(@"order_myorder_k") forState:UIControlStateNormal];
        [selectedButton addTarget:self action:@selector(clickSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectedButton];
        self.selectedButton = selectedButton;
        
        UIImageView* lineView = [[UIImageView alloc]initWithImage:ImageNamed(@"order_type_line")];
        [self addSubview:lineView];
        
        /**
         *  距离完成的时间
         */
        UILabel* timeCompleteLabel = [[UILabel alloc]init];
        timeCompleteLabel.font = [UIFont systemFontOfSize:11];
        timeCompleteLabel.textColor = UIColorFromRGB(0xe71a39);
        timeCompleteLabel.hidden = YES;
        [self addSubview:timeCompleteLabel];
        self.timeCompleteLabel = timeCompleteLabel;
        
        
        timeLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.024).topSpaceToView(self,ScreenHeight*0.04).widthIs(timeLabelWidth).autoHeightRatio(0);
        typeLabel.sd_layout.leftEqualToView(timeLabel).topSpaceToView(timeLabel,ScreenHeight*0.02).widthIs(typeLabelWidth).autoHeightRatio(0);
        
        stateTypeLabel.sd_layout.rightSpaceToView(self,ScreenWidth*0.037).topSpaceToView(self,ScreenHeight*0.04).widthIs(ScreenWidth*0.16).autoHeightRatio(0);
        
        timeContentLabel.sd_layout.leftSpaceToView(timeLabel,ScreenWidth*0.024).topEqualToView(timeLabel).rightSpaceToView(stateTypeLabel,0).autoHeightRatio(0);
        
        typeContentLabel.sd_layout.leftEqualToView(timeContentLabel).topEqualToView(typeLabel).widthIs(typeContentLabelWidth).autoHeightRatio(0);
        
        
        
        selectedButton.sd_layout.rightEqualToView(stateTypeLabel).widthIs(68).heightIs(24).bottomSpaceToView(self,ScreenHeight*0.018);
        lineView.sd_layout.leftEqualToView(timeLabel).rightSpaceToView(self,5).bottomEqualToView(self).heightIs(1);
        
        timeCompleteLabel.sd_layout.leftEqualToView(timeLabel).bottomSpaceToView(self,ScreenHeight*0.02).rightSpaceToView(self,10).autoHeightRatio(0);
        
    }
    return self;
}

-(void)layoutWithObject:(id)object indexPath:(NSIndexPath *)indexPath
{
    
    if ([object isKindOfClass:[MyOrderModel class]])
    {
        MyOrderModel* myOrderModel = (MyOrderModel*)object;
        
        /**
         *  拼接时间格式为:2016-05-28 17:00-17:30
         */
        NSRange range = NSMakeRange(11, 5);
        NSString* startTime = [myOrderModel.StartTime substringWithRange:range];
        NSString* endTime = [myOrderModel.EndTime substringWithRange:range];
        NSString* myOrderDateStr = [myOrderModel.StartTime substringToIndex:10];
        self.timeContentLabel.text = [NSString stringWithFormat:@"%@ %@-%@",myOrderDateStr,startTime,endTime];
        /**
         *  预约的项目内容
         */
        self.typeContentLabel.text = myOrderModel.AppointmentName;
        
        
        if ([myOrderModel.AppointmentStatus isEqualToString:@"Appointmented"])
        {
            self.stateTypeLabel.text = @"未审核";
            [self.selectedButton setTitle:@"取消预约" forState:UIControlStateNormal];
            self.selectedButton.hidden = NO;
            self.timeCompleteLabel.hidden = YES;
        }
        else if ([myOrderModel.AppointmentStatus isEqualToString:@"Approval"])
        {
            self.stateTypeLabel.text = @"已审核";
            [self.selectedButton setTitle:@"取消预约" forState:UIControlStateNormal];
            self.selectedButton.hidden = NO;
            self.timeCompleteLabel.hidden = YES;
        }
        else if ([myOrderModel.AppointmentStatus isEqualToString:@"InService"])
        {
            self.stateTypeLabel.text = @"服务中";
            self.selectedButton.hidden = YES;
            self.timeCompleteLabel.hidden = NO;
            self.timeCompleteLabel.text = [NSString stringWithFormat:@"距离完成时间：%@",[myOrderModel currentTimeString]];
        }
        else if (![myOrderModel.HasComment isEqualToString:@"1"] && [myOrderModel.AppointmentStatus isEqualToString:@"Completed"])
        {
            self.stateTypeLabel.text = @"已完成";
            [self.selectedButton setTitle:@"发表评论" forState:UIControlStateNormal];
            self.selectedButton.hidden = NO;
            self.timeCompleteLabel.hidden = YES;
        }
        else if ([myOrderModel.HasComment isEqualToString:@"1"] && [myOrderModel.AppointmentStatus isEqualToString:@"Completed"])
        {
            self.stateTypeLabel.text = @"已完成";
            self.selectedButton.hidden = YES;
            self.timeCompleteLabel.hidden = YES;
        }
        else if ([myOrderModel.AppointmentStatus isEqualToString:@"Cancel"])
        {
            self.stateTypeLabel.text = @"已取消";
            self.selectedButton.hidden = YES;
            self.timeCompleteLabel.hidden = YES;
        }
        else if ([myOrderModel.AppointmentStatus isEqualToString:@"Refuse"])
        {
            self.stateTypeLabel.text = @"已取消";
            self.selectedButton.hidden = YES;
            self.timeCompleteLabel.hidden = YES;
        }
        else
        {
            self.selectedButton.hidden = YES;
            self.timeCompleteLabel.hidden = YES;
        }
        
        self.object         = object;
        self.m_tmpIndexPath = indexPath;
        
//        
//        if ([self.stateTypeLabel.text isEqualToString:@"服务中"])
//        {
//            
//            self.timeCompleteLabel.text = [NSString stringWithFormat:@"距离完成时间：%@",[myOrderModel currentTimeString]];
//            
//            self.object         = object;
//            self.m_tmpIndexPath = indexPath;
//            
//        }
//        else
//        {
//            self.timeCompleteLabel.hidden = YES;
//        }
        
    }
}
#pragma mark - button click event
-(void)clickSelectedButton:(UIButton*)sender
{
    if ([sender.titleLabel.text isEqualToString:@"发表评论"])
    {
        if ([self.delegate respondsToSelector:@selector(didSelectedCommentButtonWithMyOrderTableViewCell:)])
        {
            [self.delegate didSelectedCommentButtonWithMyOrderTableViewCell:self];
        }
    }
    else if ([sender.titleLabel.text isEqualToString:@"取消预约"])
    {
        if ([self.delegate respondsToSelector:@selector(didSelectedCancelOrderButtonWithMyOrderTableViewCell:)])
        {
            [self.delegate didSelectedCancelOrderButtonWithMyOrderTableViewCell:self];
        }
    }
    
}
#pragma mark -countDownTimer

- (void)dealloc {
    
    [self removeNSNotificationCenter];
}

#pragma mark - 通知中心
- (void)registerNSNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationCenterEvent:)
                                                 name:kNotify_CountDown_Time
                                               object:nil];
}

- (void)removeNSNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotify_CountDown_Time object:nil];
}
- (void)notificationCenterEvent:(id)sender
{
    if (self.m_isDisplayed)
    {
        [self layoutWithObject:self.object indexPath:self.m_tmpIndexPath];
    }
}

@end
