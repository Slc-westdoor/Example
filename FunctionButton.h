//
//  FunctionButton.h
//  MVNO
//
//  Created by lisz5 on 14-3-6.
//  Copyright (c) 2014年 lishaozhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FunctionButtonDelegate <NSObject>


- (void)functionButtonClicked:(UIButton *)sender;

@end

@interface FunctionButton : UIView{
    UIButton * iconBtn ;
}

@property(assign ,nonatomic) id<FunctionButtonDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withIconImage:(NSString *)iconImage andText:(NSString *)labelText andTag:(int)tag;

- (void)setButtonEnable:(BOOL)ok;

@end
