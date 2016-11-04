//
//  ViewController.m
//  UI_12DatePickerView
//
//  Created by 黄明远 on 16/11/3.
//  Copyright © 2016年 郑小燕. All rights reserved.
//

#import "ViewController.h"
#import "SDAutoLayout.h"
#import "DatePickerView.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *yearPicker;
@property (nonatomic, strong) UIPickerView *dayPicker;
@property (nonatomic, strong) UIPickerView *monthPicker;
@property (nonatomic, strong) UIButton *cancelButton;//取消按钮
@property (nonatomic, strong) UIButton *sureButton;//确定
@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSArray *month1Array;/**<非本年的月份>*/
@property (nonatomic, strong) NSMutableArray *month2Array;/**<本年的月份>*/
@property (nonatomic,strong) NSArray *day1Array;/**<非闰年>*/
@property (nonatomic,strong) NSArray *day2Array;/**<闰年>*/
@property (nonatomic,strong) NSMutableArray *day3Array; /**<本月>*/
@property (nonatomic, assign) NSInteger yearIndex;
@property (nonatomic, assign) NSInteger monthIndex;
@property (nonatomic, assign) NSInteger dayIndex;
@end

@implementation ViewController{
    NSInteger year;
    NSInteger month;
    NSInteger day;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DatePickerView *datePickerView = [[DatePickerView alloc]initWithFrame:CGRectMake(0, 100, 300, 200)];
    datePickerView.isShowTodayDate =  YES;
    datePickerView.showMode = 1;
    [self.view addSubview:datePickerView];
    
//    self.yearArray = [NSMutableArray array];
//    self.month1Array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
//    self.month2Array = [NSMutableArray array];
//    
//    self.day1Array = @[@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
//    //闰年
//    self.day2Array = @[@"31",@"29",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
//    self.day3Array = [NSMutableArray array];
//    //获得两天之前的时间
//    NSDate *date = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"yyyy"];
//    year = [[dateFormatter stringFromDate:date] integerValue];
//    for (NSInteger i = 0;i < 100; i++) {
//        [self.yearArray addObject:[NSString stringWithFormat:@"%ld",year + i]];
//    }
//    [dateFormatter setDateFormat:@"MM"];
//   month = [[dateFormatter stringFromDate:date] integerValue];
//    
//    [dateFormatter setDateFormat:@"dd"];
//    day = [[dateFormatter stringFromDate:date] integerValue];
//    for (NSInteger i = month; i < 13; i++) {
//        
//        [self.month2Array addObject:[NSString stringWithFormat:@"%ld",i]];
//    }
//    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) {
//        for (NSInteger i = day; i < [self.day2Array[month - 1] integerValue]; i++) {
//            [self.day3Array addObject:[NSString stringWithFormat:@"%ld",i]];
//            
//        }
//        
//    } else {
//        
//        for (NSInteger i = day; i < [self.day1Array[month - 1] integerValue]; i++) {
//            [self.day3Array addObject:[NSString stringWithFormat:@"%ld",i]];
//            
//        }
//        
//        
//    }
//
//    //取消
//    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    self.cancelButton.layer.borderWidth = 0.5;
//    self.cancelButton.layer.borderColor = [UIColor blueColor].CGColor;
//    [self.cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
//    //    self.cancelButton.titleLabel.text = @"取消";
//    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    self.cancelButton.titleLabel.textColor = [UIColor blackColor];
//    [self.view addSubview:self.cancelButton];
//    self.cancelButton.sd_layout
//    .bottomSpaceToView(self.view,0)
//    .leftSpaceToView(self.view,0)
//    .widthIs(155)
//    .heightIs(50);
//    
//    
//    
//    self.sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
//    self.sureButton.layer.borderWidth = 0.5;
//    self.sureButton.layer.borderColor = [UIColor blueColor].CGColor;
//    [self.sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    self.sureButton.titleLabel.textColor = [UIColor blackColor];
//    [self.view addSubview:self.sureButton];
//    self.sureButton.sd_layout
//    .bottomSpaceToView(self.view,0)
//    .leftSpaceToView(self.cancelButton,0)
//    .widthIs(155)
//    .heightIs(50);
//    
//    
//    
//    
//    
//    //年
//    //时间选择器
//    self.yearPicker = [[UIPickerView alloc]init];
//    self.yearPicker.delegate = self;
//    self.yearPicker.dataSource = self;
//    [self.view addSubview:self.yearPicker];
//    
//    self.yearPicker.sd_layout
//    .topSpaceToView(self.view,100)
//    .leftSpaceToView(self.view,45)
//    .widthIs(60)
//    .heightIs(209);
//    ;
//    //月
//    self.monthPicker = [[UIPickerView alloc]init];
//    self.monthPicker.delegate = self;
//    self.yearPicker.dataSource = self;
//    [self.view addSubview:self.monthPicker];
//    
//    self.monthPicker.sd_layout
//    .topSpaceToView(self.view,100)
//    .leftSpaceToView(self.yearPicker,20)
//    .widthIs(60)
//    .heightIs(209);
//    //日
//    self.dayPicker = [[UIPickerView alloc]init];
//    self.dayPicker.delegate = self;
//    self.dayPicker.dataSource = self;
//    [self.view addSubview:self.dayPicker];
//    
//    self.dayPicker.sd_layout
//    .topSpaceToView(self.view,100)
//    .leftSpaceToView(self.monthPicker,20)
//    .widthIs(60)
//    .heightIs(209);
    
    
}
#pragma mark - pickerView的delegate方法

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView == self.yearPicker) {
        
        self.yearIndex = row;
        [self.monthPicker reloadAllComponents];
        [self.dayPicker reloadAllComponents];
        
        
    }else if (pickerView == self.monthPicker){
        self.monthIndex = row;
    [self.dayPicker reloadAllComponents];
        
    }else{
        
        
        self.dayIndex = row;
    }
    
}
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger newYear = [self.yearArray[self.yearIndex] integerValue];
    if (pickerView == self.yearPicker) {
        
        return self.yearArray.count;
        
    }else if (pickerView == self.monthPicker){
        if (self.yearIndex == 0) {
            
            return self.month2Array.count;
        }else{
        return  self.month1Array.count;
        }
        
        
    }else{
        
        if (self.monthIndex == 0 && self.yearIndex == 0) {
            return self.day3Array.count;
        }else if (((newYear % 4 == 0) && (newYear % 100 != 0)) || (newYear % 400 == 0)){
        
            return [self.day2Array[self.monthIndex] integerValue];
        }else{
            
            return [self.day1Array[self.monthIndex] integerValue];
        
        }
        
        
    }
    
    
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 48;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return 64 ;
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSInteger newYear = [self.yearArray[self.yearIndex] integerValue];
    if (pickerView == self.yearPicker) {
        
        UILabel *rowLabel = [[UILabel alloc]init];
        rowLabel.textAlignment = NSTextAlignmentCenter;
        rowLabel.backgroundColor = [UIColor whiteColor];
        rowLabel.frame = CGRectMake(0, 0, 39,self.view.frame.size.width);
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
        
    }else if(pickerView == self.monthPicker){
        UILabel *rowLabel = [[UILabel alloc]init];
        rowLabel.textAlignment = NSTextAlignmentCenter;
        rowLabel.backgroundColor = [UIColor whiteColor];
        rowLabel.frame = CGRectMake(0, 0, 39, self.view.frame.size.width);
        rowLabel.textAlignment = NSTextAlignmentCenter;
        rowLabel.font = [UIFont systemFontOfSize:14];
        rowLabel.textColor = [UIColor blackColor];
        if (self.yearIndex == 0) {
             rowLabel.text = self.month2Array[row];
        }else{
            rowLabel.text = self.month1Array[row];
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
        rowLabel.frame = CGRectMake(0, 0, 39, self.view.frame.size.width);
        rowLabel.textAlignment = NSTextAlignmentCenter;
        rowLabel.font = [UIFont systemFontOfSize:14];
        rowLabel.textColor = [UIColor blackColor];
        
        
        if (self.monthIndex == 0 && self.yearIndex == 0) {
            
            rowLabel.text = self.day3Array[row];
        }else if (((newYear % 4 == 0) && (newYear % 100 != 0)) || (newYear % 400 == 0)){
            rowLabel.text = [NSString stringWithFormat:@"%ld",row % [self.day2Array[self.monthIndex] integerValue] + 1];
        }else{
            rowLabel.text =[NSString stringWithFormat:@"%ld",row % [self.day1Array[self.monthIndex] integerValue] + 1];
//            return [self.day1Array[self.monthIndex] integerValue];
            
        }

        [rowLabel sizeToFit];
        [pickerView.subviews[1] setBackgroundColor:[UIColor cyanColor]];
        [pickerView.subviews[2] setBackgroundColor:[UIColor cyanColor]];
        [pickerView.subviews[1] setFrame:CGRectMake(0 , 80 , 60, 2)];
        [pickerView.subviews[2] setFrame:CGRectMake(0, 130 , 60, 2)];
        
        
        return rowLabel;
        
    }
    
    
    
    
}
#pragma mark - 取消按钮点击方法
- (void)cancelAction{
    
//    [self.delegate deleteYearMonthDayPickerView:self];
}
#pragma mark - 确定按钮点击方法

- (void)sureAction{
    
//    
//    NSLog(@"%@-%@-%@",self.yearArray[self.yearIndex],self.monthArray[self.monthIndex],self.dayArray[self.dayIndex]);
//    
//    self.passValue([NSString stringWithFormat:@"%@-%@-%@",self.yearArray[self.yearIndex],self.monthArray[self.monthIndex],self.dayArray[self.dayIndex]]);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
