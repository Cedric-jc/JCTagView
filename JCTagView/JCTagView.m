//
//  JCTagView.m
//  JCTagView
//
//  Created by Cedric on 16/6/20.
//  Copyright © 2016年 cedric. All rights reserved.
//

#import "JCTagView.h"


@interface JCTagView ()

@end

@implementation JCTagView

- (instancetype)initWithFrame:(CGRect)frame Name:(NSString *)name
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addTextLayer:name];
        [self addGesture];
    }
    return self;
}

//为TagView添加绘制代码
- (void)addTextLayer:(NSString *)name{
    
    CATextLayer * textLayer = [CATextLayer layer];
    textLayer.string = name;
    CGSize tagSize = [name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    
    textLayer.bounds = CGRectMake(0, 0, tagSize.width, tagSize.height);
    textLayer.position = self.center;
    [self.layer addSublayer:textLayer];
}

- (void)addGesture{
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheTagView:)];
    [self addGestureRecognizer:self.tap];
}

- (void)tapTheTagView:(UITapGestureRecognizer *)tap{
    NSLog(@"点击了视图");
    self.selected = self.selected?0:1;
}


@end


@interface JCTagCollectionView (){

    float _edge_h;
    float _edge_w;
}

@property (nonatomic, strong) NSMutableArray *lengths;
@property (nonatomic, assign) float tagHeight;


@end

@implementation JCTagCollectionView

- (void)drawTagView{

    _edge_h = 20;
    _edge_w = 20;
    int floor = 0;
    float lengthNow = 0;
    
    //添加TagView到TagCollectionView上
    for(int index = 0 ; index < self.dataSource.count; index++){
        
        if (lengthNow > [UIScreen mainScreen].bounds.size.width) {
            floor = floor + 1;
            lengthNow = 0;
        }
        JCTagView * tagview = [[JCTagView alloc] initWithFrame:CGRectMake(_edge_h + (floor + _edge_h) * floor, lengthNow , [self.lengths[index] floatValue], self.tagHeight) Name:self.dataSource[index]];
        [self addSubview:tagview];
        lengthNow = [self.lengths[index] floatValue] + lengthNow + _edge_w;
    }
    
}

- (void)calculateTagView{

    for (NSString *tagName in self.dataSource) {
        CGSize tagSize = [tagName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        [self.lengths addObject:[NSString stringWithFormat:@"%f",tagSize.width]];
        self.tagHeight = tagSize.height;
    }
}

@end