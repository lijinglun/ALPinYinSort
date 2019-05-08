//
//  ALPinYinSortSectionView.m
//  ALPinYinSort
//
//  Created by admin on 2019/5/8.
//  Copyright © 2019年 AL. All rights reserved.
//

#import "ALPinYinSortSectionView.h"
@interface ALPinYinSortSectionView ()
@property(nonatomic,copy)void(^selectedBlock)(NSInteger selectedIndex);
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,strong)UILabel * lastLabel;
@end


@implementation ALPinYinSortSectionView

-(instancetype)initWithFrame:(CGRect)frame
                    titleArr:(NSArray *)titleArr
               selectedBlock:(void (^)(NSInteger))selectedBlock
{
    self=[super initWithFrame:frame];
    if (self) {
        _selectedBlock=selectedBlock;
        _width=(self.frame.size.height-64)/titleArr.count;
        __weak typeof(self)weakSelf = self;
        [titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UILabel *letter = [[UILabel alloc]initWithFrame:CGRectMake(0,weakSelf.width*idx, self.frame.size.width, weakSelf.width)];
            letter.text = obj;
            letter.tag=300+idx;
            letter.font = [UIFont systemFontOfSize:17];
            [self addSubview:letter];
        }];
    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    
    _lastLabel.textColor=[UIColor grayColor];
    _lastLabel=(UILabel*)[self viewWithTag:300+point.y/_width];
    _lastLabel.textColor=[UIColor blueColor];
    
    _selectedBlock(point.y/_width);
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    if (point.x*point.y<0 || point.y>self.frame.size.height || point.x>self.frame.size.width) {
        return;
    }
    
    _lastLabel.textColor=[UIColor grayColor];
    _lastLabel=(UILabel*)[self viewWithTag:300+point.y/_width];
    _lastLabel.textColor=[UIColor blueColor];
    
    _selectedBlock(point.y/_width);
}

-(void)dealloc
{
    _selectedBlock=nil;
}

@end
