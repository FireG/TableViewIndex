//
//  LeftLineView.m
//  GuoTableView
//
//  Created by niaoren on 16/12/19.
//  Copyright © 2016年 niaoren. All rights reserved.
//

#import "LeftLineView.h"






#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface LeftLineView()

@property(nonatomic,strong)NSArray *listArray;
@property(nonatomic,strong)UILabel *bigLable;
@property(nonatomic,assign)CGFloat lableHeight;


@end

@implementation LeftLineView


-(void)start:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSMutableArray *mutableArr = [NSMutableArray array];
    
    UILabel *minLable = [[UILabel alloc]init];
    minLable.frame = CGRectZero;
    
    for (int i = 0; i<self.listArray.count; i++) {
        
        UILabel *label = (UILabel *)[self viewWithTag:10086+i];
        CGFloat margin = fabs( label.frame.origin.y - point.y);
        
        if (margin<=80){
            
            [UIView animateWithDuration:0.2 animations:^{
                label.center = CGPointMake(self.bounds.size.width/2 - sqrt(80*80 - margin*margin), i*label.bounds.size.height+self.lableHeight/2);
                [mutableArr addObject:label];
                minLable.textColor = [UIColor blackColor];
                self.bigLable.alpha = 1;
           }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                label.center = CGPointMake(self.bounds.size.width/2, i*label.bounds.size.height + self.lableHeight/2);
                label.font = [UIFont systemFontOfSize:12];
                label.textColor = [UIColor orangeColor];
            }];
            }
    }
    
    for (UILabel *label in mutableArr) {
        if (fabs(minLable.center.x)<fabs(label.center.x)){
            minLable = label;
            _bigLable.text = label.text;
            _bigLable.alpha = 1;
            
            CGFloat tag = minLable.tag-10086;
            [self.delegate scrollToIndexPath:tag];
        }
    }
}

-(void)end:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for(int i = 0; i<self.listArray.count ;i++){
        UILabel *label = (UILabel*)[self viewWithTag:10086+i];
        [UIView animateWithDuration:0.2 animations:^{
            label.center = CGPointMake(self.bounds.size.width/2, i*label.bounds.size.height + self.lableHeight/2);
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor orangeColor];
            self.bigLable.alpha = 0;
            
        }];
    }

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self start:touches withEvent:event];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self start:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self end:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self end:touches withEvent:event];
}

-(void)abdcLable{
    CGFloat lh = self.bounds.size.height/self.listArray.count;
    self.lableHeight = lh;
    for (NSString *str in self.listArray) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, [self.listArray indexOfObject:str]*lh, 40, lh)];
        lable.tag = 10086 + [self.listArray indexOfObject:str];
        lable.textColor = [UIColor orangeColor];
        lable.font = [UIFont systemFontOfSize:12];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = str;
        [self addSubview:lable];
    }
    
}

-(instancetype)initWithFrame:(CGRect)frame indexArray:(NSArray*)array{
    if (self = [super initWithFrame:frame]){
        self.listArray = array;
        self.bigLable.alpha = 0;
        [self addSubview:self.bigLable];
        [self abdcLable];
    }
    return self;
}

-(UILabel *)bigLable{
    if (!_bigLable){
        _bigLable = [[UILabel alloc]initWithFrame:CGRectMake(-WIDTH/2+30, 100, 60, 60)];
        _bigLable.textColor = [UIColor whiteColor];
        _bigLable.backgroundColor = [UIColor orangeColor];
        _bigLable.font = [UIFont systemFontOfSize:20];
        _bigLable.textAlignment = NSTextAlignmentCenter;
    }
    return _bigLable;
}


@end
