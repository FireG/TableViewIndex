//
//  LeftLineView.h
//  GuoTableView
//
//  Created by niaoren on 16/12/19.
//  Copyright © 2016年 niaoren. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LeftLineViewDelegate <NSObject>

-(void)scrollToIndexPath:(NSInteger)section;

@end

@interface LeftLineView : UIView

-(instancetype)initWithFrame:(CGRect)frame indexArray:(NSArray*)array;

@property(nonatomic,weak) id<LeftLineViewDelegate>delegate;

@end
