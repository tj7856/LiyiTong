//
//  ALinSelectedView.m
//  MiaowShow
//
//  Created by ALin on 16/6/14.
//  Copyright © 2016年 ALin. All rights reserved.
//

#import "SelectedView.h"
#import <SDAutoLayout.h>

// 首页的选择器的宽度
#define Home_Seleted_Item_W  60
#define DefaultMargin       10


@interface SelectedView()
@property (nonatomic, weak)UIView *underLine;
@property (nonatomic, strong)UIButton *selectedBtn;
@property (nonatomic, weak)UIButton *hotBtn;
@end

@implementation SelectedView



- (UIView *)underLine
{
    if (!_underLine) {
        UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(DefaultMargin*7, self.height-4, Home_Seleted_Item_W , 2)];
        underLine.backgroundColor = [UIColor colorWithRed:11/255.0 green:230/255.0 blue:196/255.0 alpha:1];
        [self addSubview:underLine];
        
        _underLine = underLine;
    }
    return _underLine;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIButton *hotBtn = [self createBtn:@"推荐" tag:HomeTypegift];
    UIButton *newBtn = [self createBtn:@"关注" tag:HomeTypeguess];
//    UIButton *careBtn = [self createBtn:@"热门" tag:HomeTypegive];
    [self addSubview:hotBtn];
    [self addSubview:newBtn];
//    [self addSubview:careBtn];
    _hotBtn = hotBtn;
    
    newBtn.sd_layout.centerYEqualToView(self).widthIs(Home_Seleted_Item_W).rightSpaceToView(self,DefaultMargin*7).heightIs(30);
    hotBtn.sd_layout.centerYEqualToView(self).widthIs(Home_Seleted_Item_W).leftSpaceToView(self,DefaultMargin*7).heightIs(30);
    
//    [newBtn mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.center.equalTo(self);
////        make.width.equalTo(@(Home_Seleted_Item_W));
//        make.right.equalTo(@(-DefaultMargin*7 ));
//                make.centerY.equalTo(self);
//                make.width.equalTo(@(Home_Seleted_Item_W));
//    }];
//    
//    [hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@(DefaultMargin*7 ));
//        make.centerY.equalTo(self);
//        make.width.equalTo(@(Home_Seleted_Item_W));
//    }];
    
//    [careBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(@(-DefaultMargin*4 ));
//        make.centerY.equalTo(self);
//        make.width.equalTo(@(Home_Seleted_Item_W));
//    }];
    
   //  强制更新一次
    [self layoutIfNeeded];
    // 默认选中最热
    [self click:hotBtn];
    // 监听点击"去看最热主播"
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toSeeWorld) name:kNotifyToseeBigWorld object:nil];
}

//- (void)toSeeWorld
//{
//    [self click:_hotBtn];
//}

- (UIButton *)createBtn:(NSString *)title tag:(HomeType)tag
{
    UIButton *btn = [[UIButton alloc] init];
//    btn.titleLabel.font = [UIFont systemFontOfSize:19];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:11/255.0 green:230/255.0 blue:196/255.0 alpha:1] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:UIControlStateHighlighted];
    btn.titleLabel.adjustsFontSizeToFitWidth =YES;
 
    btn.tag = tag;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)setSelectedType:(HomeType)selectedType
{
    _selectedType = selectedType;
    self.selectedBtn.selected = NO;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.tag == selectedType) {
            self.selectedBtn = (UIButton *)view;
            ((UIButton *)view).selected = YES;
        }
    }
    
}

// 点击事件
- (void)click:(UIButton *)btn
{
//    btn.selected = !btn.selected;
    if(self.selectedBtn!=btn)
    {
//    self.selectedBtn.selected = NO;
//    btn.selected = YES;
//    self.selectedBtn = btn;
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        self.underLine.x = btn.x ;
////        self.underLine.x += 10;
////        self.underLine.width = btn.titleLabel .width;
//    }];
    
    if (self.selectedBlock) {
        self.selectedBlock(btn.tag);
    }
    }
}
@end
