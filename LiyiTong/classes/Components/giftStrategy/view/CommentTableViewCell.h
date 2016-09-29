//
//  CommentTableViewCell.h
//  LiyiTong
//
//  Created by zhangtijie on 16/9/22.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Response;
@interface CommentTableViewCell : UITableViewCell

@property(nonatomic,)Response* Rep;

@property (nonatomic, copy) void (^LabelClickedOperation)(Response *item,NSUInteger index,UITableViewCell *cell);

//-(void)setRep:(Response *)Rep WithIndex:(NSInteger)index;
@end
