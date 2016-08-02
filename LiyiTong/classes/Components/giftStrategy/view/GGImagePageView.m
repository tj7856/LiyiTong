//
//  GGImagePageView.m
//  轮播图test
//
//  Created by GG on 16/5/22.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "GGImagePageView.h"



#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface GGImagePageView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;

//选中某个图片的block
@property (nonatomic,weak)SelectedImageViewBlcok block;

//是否正在拖动
@property (nonatomic,assign) BOOL isDraging;

//换页定时器
@property (nonatomic,weak) NSTimer *timer;

//当前显示的图片的下标
@property (nonatomic,assign) int currentIndex;

//分页试图
@property (nonatomic,strong) UIPageControl *pageControl;

//轮播图的高度
@property (nonatomic,assign) float scrollViewHeight;

//显示图片的三个imageView试图
@property (nonatomic,strong) UIImageView *leftImageView, *midleImageView, *rightImageView;

@end

@implementation GGImagePageView

- (instancetype)initWithFrame:(CGRect)frame withSelectImageBlock:(SelectedImageViewBlcok)block
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _block = block;
        
        self.scrollViewHeight = frame.size.height;
        
        
        
    }
    return self;
}

#pragma mark lazy laod
- (void)setImageAarray:(NSArray *)imageAarray{
    
    _imageAarray = imageAarray;
    
    self.scrollView.delegate = self;
    
    [self setScrollow];
    
    [self setImageViews];
    
    if (self.showPageControl == YES) {
        
        [self setPageControl];
    }
    
    if (self.isTimer == YES) {
        
        self.timer =  [NSTimer scheduledTimerWithTimeInterval:kTimeInteral target:self selector:@selector(timeOver) userInfo:nil repeats:YES ];
        
        
    }
    
}


#pragma mark layout UI

- (void)setImageViews{
    
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.scrollViewHeight)];
    
    self.midleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, self.scrollViewHeight)];
    
    self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, self.scrollViewHeight)];
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    if (self.imageAarray.count != 0) {
        
        self.leftImageView.image = [UIImage imageNamed:self.imageAarray.lastObject];
        self.leftImageView.contentMode=UIViewContentModeScaleAspectFill;
        self.midleImageView.image = [UIImage imageNamed:self.imageAarray.firstObject];
        self.midleImageView.contentMode=UIViewContentModeScaleAspectFill;
        self.rightImageView.image = [UIImage imageNamed:self.imageAarray[1]];
        self.rightImageView.contentMode=UIViewContentModeScaleAspectFill;
    }
    
    [self.scrollView addSubview:self.leftImageView];
    
    [self.scrollView addSubview:self.midleImageView];
    
    [self.scrollView addSubview:self.rightImageView];
    
}


- (void)setScrollow{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.scrollViewHeight)];
    
    self.scrollView.backgroundColor = [UIColor redColor];
    
    self.scrollView.delegate = self;
    
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*self.imageAarray.count, self.scrollViewHeight);
    
    self.scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    
    self.scrollView.pagingEnabled = YES;
    
    [self addSubview:self.scrollView];
}


- (void)setPageControl{
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.scrollViewHeight-20, kScreenWidth, 20)];
    
    _pageControl.numberOfPages = self.imageAarray.count;
    
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.392 green:0.902 blue:0.725 alpha:1.000];
    
    _pageControl.userInteractionEnabled = NO;
    
    [self addSubview:_pageControl];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScrollow)];
    
    [self.scrollView addGestureRecognizer:tapGesture];
    
    
}


#pragma mark private method


- (void)tapScrollow{
    
    _block((int)self.pageControl.currentPage);
    
}


- (void)startTimer{
    
    self.isDraging = NO;
    
    self.timer.fireDate = [NSDate distantPast];
    
    
}


- (void)timeOver{
    
    
    if (self.isDraging == NO) {
        
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth*2, 0) animated:YES];
        
    }else{
        
        
        
        self.timer.fireDate = [NSDate distantFuture];
        
        
        
        
        
        
    }
    
}


#pragma  mark scrollview delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    self.isDraging = YES;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self performSelector:@selector(startTimer) withObject:nil afterDelay:kNoResponse];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    CGFloat offset = scrollView.contentOffset.x;
    
    if (self.imageAarray.count != 0) {
        
        
        if (offset>=2*kScreenWidth) {
            scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
            
            self.currentIndex++;
            
            if (self.currentIndex == self.imageAarray.count-1) {
                
                self.midleImageView.image = [UIImage imageNamed:self.imageAarray[self.currentIndex]];
                
                self.leftImageView.image = [UIImage imageNamed:self.imageAarray[self.currentIndex-1]];
                
                self.rightImageView.image = [UIImage imageNamed:self.imageAarray.firstObject];
                
                
                self.pageControl.currentPage = self.imageAarray.count-1;
                
                self.currentIndex=-1;
                
            }else if(self.currentIndex == 0){
                
                self.midleImageView.image = [UIImage imageNamed:self.imageAarray.firstObject];
                
                self.leftImageView.image = [UIImage imageNamed:self.imageAarray.lastObject];
                self.rightImageView.image = [UIImage imageNamed:self.imageAarray[1]];
                
                self.pageControl.currentPage = 0;
                
            }else if(self.currentIndex == self.imageAarray.count){
                
                
                self.leftImageView.image = [UIImage imageNamed:self.imageAarray.lastObject];
                
                self.midleImageView.image = [UIImage imageNamed:self.imageAarray.firstObject];
                
                self.rightImageView.image = [UIImage imageNamed:self.imageAarray[0]];
                
                self.pageControl.currentPage = 0;
                self.currentIndex = 0;
                
                
                
            }else {
                
                self.midleImageView.image = [UIImage imageNamed:self.imageAarray[self.currentIndex]];
                
                self.leftImageView.image = [UIImage imageNamed:self.imageAarray[self.currentIndex-1]];
                self.rightImageView.image = [UIImage imageNamed:self.imageAarray[self.currentIndex+1]];
                
                
                self.pageControl.currentPage = self.currentIndex;
            }
            
            
            
        }
        
        
        
        
        if (offset<=0) {
            
            self.scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
            
            self.currentIndex--;
            
            if (self.currentIndex == -1) {
                
                self.currentIndex = (int)self.imageAarray.count-1;
                
                self.leftImageView.image = [UIImage imageNamed:self.imageAarray[self.currentIndex-1]];
                
                self.midleImageView.image = [UIImage imageNamed:self.imageAarray.lastObject];
                
                self.rightImageView.image = [UIImage imageNamed:self.imageAarray.firstObject];
                
                self.pageControl.currentPage = self.currentIndex;
                
                
                
                
            }else if(self.currentIndex == 0){
                
                
                self.midleImageView.image = [UIImage imageNamed:self.imageAarray.firstObject];
                
                self.leftImageView.image = [UIImage imageNamed:self.imageAarray.lastObject];
                self.rightImageView.image = [UIImage imageNamed:self.imageAarray[1]];
                
                self.pageControl.currentPage = 0;
                
                
                
            }else if(self.currentIndex == -2){
                
                self.currentIndex = (int)self.imageAarray.count-2;
                
                self.leftImageView.image = [UIImage imageNamed:self.imageAarray[self.imageAarray.count-1]];
                
                self.midleImageView.image = [UIImage imageNamed:self.imageAarray[self.currentIndex]];
                
                self.rightImageView.image = [UIImage imageNamed:self.imageAarray.lastObject];
                
                self.pageControl.currentPage = self.currentIndex;
                
                
            }else{
                
                self.midleImageView.image = [UIImage imageNamed:self.imageAarray[self.currentIndex]];
                
                self.leftImageView.image = [UIImage imageNamed:self.imageAarray[self.currentIndex-1]];
                self.rightImageView.image = [UIImage imageNamed:self.imageAarray[self.currentIndex+1]];
                
                
                self.pageControl.currentPage = self.currentIndex;
            }
            
        }
        
    }
    
}





@end
