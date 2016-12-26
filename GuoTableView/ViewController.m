//
//  ViewController.m
//  GuoTableView
//
//  Created by niaoren on 16/12/19.
//  Copyright © 2016年 niaoren. All rights reserved.
//

#import "ViewController.h"
#import "LeftLineView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,LeftLineViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *titleArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width-40, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    LeftLineView *lineView = [[LeftLineView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-40, 100, 40, self.view.bounds.size.height-150) indexArray:self.titleArray];
    lineView.delegate = self;
    
    [self.view addSubview:lineView];
    
}

-(void)scrollToIndexPath:(NSInteger)section{

    [UIView animateWithDuration:0.2 animations:^{
       [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] animated:NO scrollPosition:UITableViewScrollPositionTop]; 
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[UITableViewCell alloc]init];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.titleArray[section];
}

-(NSArray *)titleArray{
    if (!_titleArray){
        NSMutableArray *mutable = [NSMutableArray array];
        for (int i = 0; i<26; i++) {
            unichar ch = 65 + i;
            NSString *str = [NSString stringWithUTF8String:(char*)&ch];
            [mutable addObject:str];
        }
        _titleArray = mutable;
    }
    return _titleArray;
}

@end
