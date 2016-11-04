//
//  DatePickerView.h
//  UI_12DatePickerView
//
//  Created by 郑小燕 on 16/11/3.
//  Copyright © 2016年 郑小燕. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TimeShowMode){
    /**
     * 只显示今天之前的时间
     */
    ShowTimeBeforeToday = 0,
    /**
     * 显示今天之后的时间
     */
    ShowTimeAfterToday,
    /**
     * 不限制时间
     */
    ShowAllTime,
    
};
@interface DatePickerView : UIView


/**
 * 是否显示今天的日期 YES 显示 NO 不显示
 */
@property (nonatomic, assign) BOOL isShowTodayDate;
/**
 * 模式
 */
@property (nonatomic, assign) NSInteger showMode;

@end
