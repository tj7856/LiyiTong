//
//  InvitationContentTableViewCell.h
//  LiyiTong
//
//  Created by zhangtijie on 16/9/20.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostsContent;
@interface InvitationContentTableViewCell : UITableViewCell
@property(nonatomic,strong)NSArray* items;

@property (nonatomic, copy) void (^goButtonClickedOperation)(PostsContent *item);
@property (nonatomic, copy) void (^zanButtonClickedOperation)(PostsContent *item);

@end
