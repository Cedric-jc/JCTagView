//
//  JCTagView.h
//  JCTagView
//
//  Created by Cedric on 16/6/20.
//  Copyright © 2016年 cedric. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCTagViewDelegate <NSObject>


@end

@interface JCTagModel : NSObject

@property (nonatomic, copy)   NSString *tagName;
@property (nonatomic, assign) BOOL      isSelected;

@end

@interface JCTagView : UIView

@property (nonatomic , strong) UITapGestureRecognizer * tap;
@property (nonatomic , assign) BOOL selected;
- (instancetype)initWithFrame:(CGRect )frame Name:(NSString *)name;

@end

@interface JCTagCollectionView : UIView

@property(nonatomic , strong) NSMutableArray *dataSource;
@property(nonatomic , weak)id<JCTagViewDelegate> delegate;

@end
