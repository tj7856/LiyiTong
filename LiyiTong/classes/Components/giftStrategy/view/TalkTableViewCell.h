//
//  TalkTableViewCell.h
//  LiyiTong
//
//  Created by zhangtijie on 16/9/10.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickzanBlock) ();
@interface TalkTableViewCell : UITableViewCell

@property(nonatomic,copy)ClickzanBlock zanBlock;

@end
