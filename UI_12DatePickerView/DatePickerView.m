//
//  DatePickerView.m
//  UI_12DatePickerView
//
//  Created by 郑小燕 on 16/11/3.
//  Copyright © 2016年 郑小燕. All rights reserved.
//

#import "DatePickerView.h"
#import "SDAutoLayout.h"
@interface DatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

/**
 * 数组装年份
 */
@property (nonatomic, strong) NSMutableArray *yearArray;
/**
 * 本年剩下的月份
 */
@property (nonatomic, strong) NSMutableArray *monthRemainingArray;

@property (nonatomic, strong) NSMutableArray *dayRemainingArray;
/**
 * 不是闰年 装一个月多少天
 */
@property (nonatomic, strong) NSArray *NotLeapYearArray;
/**
 * 闰年 装一个月多少天
 */
@property (nonatomic, strong) NSArray *leapYearArray;
@end
@implementation DatePickerView{
    /**
     * 用三个的原因UIPickerView,而不直接用component这个直接返回3个,由于我们需要的时间选择器年月日都有两条横下,如果没这个要求,可以直接用component这儿属性,不用创建3次
     */
    UIPickerView *yearPicker;/**<年>*/
    UIPickerView *monthPicker;/**<月份>*/
    UIPickerView *dayPicker;/**<天>*/
    UIButton *cancelButton;/**<取消按钮>*/
    UIButton *sureButton;/**<确定按钮>*/
    NSInteger yearIndex;/**<年索引>*/
    NSInteger monthIndex;/**<月索引>*/
    NSInteger dayIndex;/**<日索引>*/
    TimeShowMode timeShowMode;/**<时间显示模式>*/
    NSInteger currentYear;
    NSInteger currentMonth;
    NSInteger currentDay;
    NSDate *date;/**<获得日期>*/
}
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        timeShowMode = ShowTimeBeforeToday;
        self.yearArray = [NSMutableArray array];
        self.monthRemainingArray = [NSMutableArray array];
        self.dayRemainingArray = [NSMutableArray array];
        [self initData];
        [self setViews];
        
        
    }
    return self;
    
}

- (void)initData{
    //非闰年
    self.NotLeapYearArray = @[@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    //闰年
    self.leapYearArray = @[@"31",@"29",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    
    //判断时间显示模式
    if (timeShowMode == ShowTimeBeforeToday){
        
        if (self.isShowTodayDate) {
            //显示今天的时间
            date = [NSDate date];
        }else{
            //不显示今天的时间
            date = [NSDate dateWithTimeIntervalSinceNow:-(24 * 3600)];
            
            
        }
        
        
    }else if (timeShowMode == ShowTimeAfterToday){
        
        if (self.isShowTodayDate) {
            //显示今天的时间
            date = [NSDate date];
        }else{
            //不显示今天的时间
            date = [NSDate dateWithTimeIntervalSinceNow:+(24 * 3600)];
            
            
        }
        
        
    }else if (timeShowMode == ShowAllTime){
        //显示今天的时间
        date = [NSDate date];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy"];
    currentYear = [[dateFormatter stringFromDate:date] integerValue];
    [dateFormatter setDateFormat:@"MM"];
    currentMonth = [[dateFormatter stringFromDate:date] integerValue];
    [dateFormatter setDateFormat:@"dd"];
    currentDay = [[dateFormatter stringFromDate:date] integerValue];
    
    //判断时间显示模式
    if (timeShowMode == ShowTimeBeforeToday){
        
        for (NSInteger i = 0; i < 100; i++) {
            
            [self.yearArray addObject:[NSString stringWithFormat:@"%ld",currentYear - i]];
        }
        
        for (NSInteger i = 0; i < currentMonth + 1; i++) {
            [self.monthRemainingArray addObject:[NSString stringWithFormat:@"%ld",i]];
        }
        for (NSInteger i = 0; i < currentDay + 1; i++) {
            [self.dayRemainingArray addObject:[NSString stringWithFormat:@"%ld",i]];
        }
        
    }else if (timeShowMode == ShowTimeAfterToday){
        
        for (NSInteger i = 0; i < 100; i++) {
            
            [self.yearArray addObject:[NSString stringWithFormat:@"%ld",currentYear + i]];
        }
        
        for (NSInteger i = currentMonth; i < 13; i++) {
            [self.monthRemainingArray addObject:[NSString stringWithFormat:@"%ld",i]];
        }
        NSInteger lastDay = [self LeapYearCompare:currentYear withMonth:currentMonth];
        for (NSInteger i = currentDay; i < lastDay + 1; i++) {
            
            [self.dayRemainingArray addObject:[NSString stringWithFormat:@"%ld", i]];
        }
        
        
    }else if (timeShowMode == ShowAllTime){
        for (NSInteger i = 50; i > 0; i--) {
            [self.yearArray addObject:[NSString stringWithFormat:@"%ld",currentYear - i]];
        }
        for (NSInteger i = 0; i < 50; i++) {
            [self.yearArray addObject:[NSString stringWithFormat:@"%ld",currentYear + i]];
        }
        
    }
    
    
    
    
}
#pragma mark - 判断是否是闰年
- (NSInteger)LeapYearCompare:(NSInteger)year withMonth:(NSInteger)month{
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        
        return [self.leapYearArray[month - 1] integerValue];
        
    }else{
        
        return [self.NotLeapYearArray[month - 1] integerValue];
        
    }
    
}
- (void)setViews{
    
    //年
    //时间选择器
    yearPicker = [[UIPickerView alloc]init];
    yearPicker.delegate = self;
    yearPicker.dataSource = self;
    [self addSubview:yearPicker];
    
    yearPicker.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,20)
    .widthIs(60)
    .heightIs(209);
    ;
    
    //月
    monthPicker = [[UIPickerView alloc]init];
    monthPicker.delegate = self;
    yearPicker.dataSource = self;
    [self addSubview:monthPicker];
    
    monthPicker.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(yearPicker,20)
    .widthIs(60)
    .heightIs(209);
    
    
    //日
    dayPicker = [[UIPickerView alloc]init];
    dayPicker.delegate = self;
    dayPicker.dataSource = self;
    [self addSubview:dayPicker];
    
    dayPicker.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(monthPicker,20)
    .widthIs(60)
    .heightIs(209);
    
//    //取消
//    cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    cancelButton.layer.borderWidth = 0.5;
//    cancelButton.layer.borderColor = [UIColor blueColor].CGColor;
//    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
//    //    self.cancelButton.titleLabel.text = @"取消";
//    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    cancelButton.titleLabel.textColor = [UIColor blackColor];
//    [self addSubview:cancelButton];
//    cancelButton.sd_layout
//    .bottomSpaceToView(self,0)
//    .leftSpaceToView(self,0)
//    .widthIs(155)
//    .heightIs(50);
//    
//    
//    
//    sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
//    sureButton.layer.borderWidth = 0.5;
//    sureButton.layer.borderColor = [UIColor blueColor].CGColor;
//    [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    sureButton.titleLabel.textColor = [UIColor blackColor];
//    [self addSubview:sureButton];
//    sureButton.sd_layout
//    .bottomSpaceToView(self,0)
//    .leftSpaceToView(cancelButton,0)
//    .widthIs(155)
//    .heightIs(50);
//    
    
    
}
#pragma mark - pickerView的delegate方法

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView == yearPicker) {
        
        yearIndex = row;
        [monthPicker reloadAllComponents];
        [dayPicker reloadAllComponents];
        
        
    }else if (pickerView == monthPicker){
        monthIndex = row;
        [dayPicker reloadAllComponents];
        
    }else{
        
        
        dayIndex = row;
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == yearPicker) {
        
        return self.yearArray.count;
        
    }else if (pickerView == monthPicker){
        switch (timeShowMode) {
            case ShowTimeBeforeToday || ShowTimeAfterToday:
                
                return [self MonthInSelectYear];
                
                break;
            case ShowAllTime:
                return 12;
                break;
                
            default:
                break;
        }
        
        
        
        
        
    }else{
        
        switch (timeShowMode) {
            case ShowTimeBeforeToday || ShowTimeAfterToday:
                
                return [self daysInSelectMonth:ShowTimeBeforeToday || ShowTimeAfterToday];
                
                 break;
            case ShowAllTime:
                
                return [self daysInSelectMonth:ShowAllTime];
                break;
                
            default:
                break;
        }
        
 
        
        
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 48;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return 64 ;
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
   
    if (pickerView == yearPicker) {
        
        UILabel *rowLabel = [[UILabel alloc]init];
        rowLabel.textAlignment = NSTextAlignmentCenter;
        rowLabel.backgroundColor = [UIColor whiteColor];
        rowLabel.frame = CGRectMake(0, 0, 39,self.frame.size.width);
        rowLabel.textAlignment = NSTextAlignmentCenter;
        rowLabel.font = [UIFont systemFontOfSize:14];
        rowLabel.textColor = [UIColor blackColor];
        rowLabel.text = self.yearArray[row];
        [pickerView.subviews[1] setBackgroundColor:[UIColor cyanColor]];
        [pickerView.subviews[2] setBackgroundColor:[UIColor cyanColor]];
        [pickerView.subviews[1] setFrame:CGRectMake(0 , 80, 60, 2)];
        [pickerView.subviews[2] setFrame:CGRectMake(0, 130, 60, 2)];
        
        
        [rowLabel sizeToFit];
        return rowLabel;
        
    }else if(pickerView == monthPicker){
        UILabel *rowLabel = [[UILabel alloc]init];
        rowLabel.textAlignment = NSTextAlignmentCenter;
        rowLabel.backgroundColor = [UIColor whiteColor];
        rowLabel.frame = CGRectMake(0, 0, 39, self.frame.size.width);
        rowLabel.textAlignment = NSTextAlignmentCenter;
        rowLabel.font = [UIFont systemFontOfSize:14];
        rowLabel.textColor = [UIColor blackColor];
        NSInteger yearRow = [yearPicker selectedRowInComponent:0] % self.yearArray.count;
        
        switch (timeShowMode) {
            case ShowTimeBeforeToday || ShowTimeAfterToday:
                if ([self.yearArray[yearRow] integerValue] == currentYear) {
                    
                    rowLabel.text = self.monthRemainingArray[row];
                }else{
                rowLabel.text = [NSString stringWithFormat:@"%ld",row % 12 + 1];
                }
                
                break;
            case ShowAllTime:
                rowLabel.text = [NSString stringWithFormat:@"%ld",row % 12 + 1];
                break;
            default:
                break;
        }
        
        [rowLabel sizeToFit];
        [pickerView.subviews[1] setBackgroundColor:[UIColor cyanColor]];
        [pickerView.subviews[2] setBackgroundColor:[UIColor cyanColor]];
        [pickerView.subviews[1] setFrame:CGRectMake(0, 80, 60, 2 )];
        [pickerView.subviews[2] setFrame:CGRectMake(0 , 130 , 60 , 2)];
        
        
        return rowLabel;
        
        
    }else{
        
        UILabel *rowLabel = [[UILabel alloc]init];
        rowLabel.textAlignment = NSTextAlignmentCenter;
        rowLabel.backgroundColor = [UIColor whiteColor];
        rowLabel.frame = CGRectMake(0, 0, 39, self.frame.size.width);
        rowLabel.textAlignment = NSTextAlignmentCenter;
        rowLabel.font = [UIFont systemFontOfSize:14];
        rowLabel.textColor = [UIColor blackColor];
        NSInteger yearRow = [yearPicker selectedRowInComponent:0] % self.yearArray.count;
        NSInteger monthRow = [monthPicker selectedRowInComponent:0] % 12;
         NSInteger monthDays = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:(monthRow + 1)];
        
        switch (timeShowMode) {
            case ShowTimeBeforeToday || ShowTimeAfterToday:
                
              
              
                    
                    if ([self.yearArray[yearRow] integerValue] == currentYear) {
                        if ([self.monthRemainingArray[monthRow] integerValue]== currentMonth) {
                            
                            rowLabel.text = self.dayRemainingArray[row];
                        }else{
                            NSInteger monthRemainingDays = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:[self.monthRemainingArray[monthRow] integerValue]];
                        rowLabel.text = [NSString stringWithFormat:@"%ld", row % monthRemainingDays + 1];
                        }
                        
                        
                    }else{
                        
                       
                       rowLabel.text = [NSString stringWithFormat:@"%ld", row % monthDays + 1];
                        
                        
                        
                   
                }
                
                break;
            case ShowAllTime:
                
               rowLabel.text = [NSString stringWithFormat:@"%ld", row % monthDays + 1];
                break;
                
            default:
                break;
        }
        
        [rowLabel sizeToFit];
        [pickerView.subviews[1] setBackgroundColor:[UIColor cyanColor]];
        [pickerView.subviews[2] setBackgroundColor:[UIColor cyanColor]];
        [pickerView.subviews[1] setFrame:CGRectMake(0 , 80 , 60, 2)];
        [pickerView.subviews[2] setFrame:CGRectMake(0, 130 , 60, 2)];
        
        
        return rowLabel;
        
    }
    
    
    
    
}

- (NSInteger)MonthInSelectYear{
    NSInteger yearRow = [yearPicker selectedRowInComponent:0] % self.yearArray.count;
    if ([self.yearArray[yearRow] integerValue] == currentYear) {
        return self.monthRemainingArray.count;
    }else{
        return 12;
    }
    
}

- (NSInteger)daysInSelectMonth:(TimeShowMode)timeMode{
    NSInteger yearRow = [yearPicker selectedRowInComponent:0] % self.yearArray.count;
    NSInteger monthRow = [monthPicker selectedRowInComponent:0] % 12;
    NSInteger monthDays = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:(monthRow + 1)];
    if (timeMode == ShowTimeAfterToday || timeShowMode == ShowTimeBeforeToday) {
        
        if ([self.yearArray[yearRow] integerValue] == currentYear ) {
            if ([self.monthRemainingArray[monthRow ] integerValue] == currentMonth) {
                
                return self.dayRemainingArray.count;
            }else{
                // [self.monthRemainingArray[monthRow] integerValue]-1
                NSInteger monthRemainingDays = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:[self.monthRemainingArray[monthRow] integerValue]];
                
                return monthRemainingDays;
            }
            
        }else{
            
            return monthDays;
            
            
            
            
        }
    }else{
        NSInteger days = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:(monthRow + 1)];
        return days;
    }
}



#pragma mark - 取消按钮点击方法
- (void)cancelAction{
    
    
    
}
#pragma mark - 确定按钮点击方法

- (void)sureAction{
    
    
    
}

- (void)setIsShowTodayDate:(BOOL)isShowTodayDate{
    _isShowTodayDate = isShowTodayDate;
}

//- (void)setShowMode:(NSInteger)showMode{
//    _showMode = showMode;
//timeShowMode = showMode;
//}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
