//
//  CustomTypeSelectedTableViewCell.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "CustomTypeSelectedTableViewCell.h"
#import "OrderTypeModel.h"

@interface CustomTypeSelectedTableViewCell()

@property (nonatomic, weak) UIButton* selectedButton;
@property (nonatomic, weak) UILabel* typeNameLabel;
@property (nonatomic, weak) UILabel* contentLabel;
@property (nonatomic, weak) UILabel* priceLabel;
@end
@implementation CustomTypeSelectedTableViewCell

NSString* const CustomTypeSelectedTableViewCellId = @"CustomTypeSelectedTableViewCellId";

+(CustomTypeSelectedTableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath
{
    CustomTypeSelectedTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil)
    {
        cell = [[CustomTypeSelectedTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel* typeNameLabel = [[UILabel alloc]init];
        typeNameLabel.font = [UIFont systemFontOfSize:14];
        typeNameLabel.textColor = UIColorFromRGB(0x000000);
        [self addSubview:typeNameLabel];
        self.typeNameLabel = typeNameLabel;
        
        UILabel* contentLabel = [[UILabel alloc]init];
         contentLabel.font = [UIFont systemFontOfSize:11];
        contentLabel.textColor = UIColorFromRGB(0x000000);
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UILabel* priceLabel = [[UILabel alloc]init];
        priceLabel.font = [UIFont systemFontOfSize:13];
        priceLabel.textColor = UIColorFromRGB(0xff7e31);
        priceLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        
        UIButton* selectedButton = [[UIButton alloc]init];
        selectedButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [selectedButton setTitleColor:UIColorFromRGB(0xff7e31) forState:UIControlStateNormal];
        [selectedButton setBackgroundImage:ImageNamed(@"order_type_choose") forState:UIControlStateNormal];
        [selectedButton addTarget:self action:@selector(clickSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectedButton];
        self.selectedButton = selectedButton;
        
        UIImageView* lineView = [[UIImageView alloc]initWithImage:ImageNamed(@"order_type_line")];
        [self addSubview:lineView];
        
        typeNameLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.037).topSpaceToView(self,ScreenHeight*0.03).widthIs(ScreenWidth*0.6).autoHeightRatio(0);
        contentLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.037).topSpaceToView(typeNameLabel,10).widthIs(ScreenWidth*0.8).autoHeightRatio(0);
        selectedButton.sd_layout.widthIs(53).heightIs(24).bottomSpaceToView(self,ScreenHeight*0.024).rightSpaceToView(self,ScreenWidth*0.024);
         priceLabel.sd_layout.centerXEqualToView(selectedButton).rightSpaceToView(self,ScreenWidth*0.048).bottomSpaceToView(selectedButton,6).widthIs(ScreenWidth*0.19).autoHeightRatio(0);
        lineView.sd_layout.leftSpaceToView(self,ScreenWidth*0.037).rightSpaceToView(self,5).bottomEqualToView(self).heightIs(1);
        
        
    }
    return self;
}

-(void)layoutWithObject:(id)object
{

    if ([object isKindOfClass:[OrderTypeModel class]])
    {
        OrderTypeModel* orderTypeModel = (OrderTypeModel*)object;
        
        self.typeNameLabel.text = orderTypeModel.SubjectName;
        /**
         *  判断维修内容是否为空，如果空去掉分号
         */
        if (!orderTypeModel.Note || [orderTypeModel.Note isEqualToString:@""])
        {
            self.contentLabel.text = [NSString stringWithFormat:@"施工约%@分钟",orderTypeModel.NeedTime];
        }
        else
        {
            self.contentLabel.text = [NSString stringWithFormat:@"%@;施工约%@分钟",orderTypeModel.Note,orderTypeModel.NeedTime];
        }
        
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",orderTypeModel.Price];
        
        if (orderTypeModel.IsSelected)
        {
            [self.selectedButton setTitle:@"已选择" forState:UIControlStateNormal];
        }
        else
        {
            [self.selectedButton setTitle:@"选择" forState:UIControlStateNormal];
        }
    }
}

-(void)clickSelectedButton:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectedCustomTypeSelectedTableViewCell:)])
    {
        [self.delegate didSelectedCustomTypeSelectedTableViewCell:self];
    }
    
}
@end
