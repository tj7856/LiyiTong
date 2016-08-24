//
//  confrimOrderViewController.h
//  LiyiTong
//
//  Created by zhangtijie on 16/8/3.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBackBlock) (UIViewController *controller);

@interface confrimOrderViewController : UITableViewController
@property(nonatomic,copy)ClickBackBlock block;

-(void)rightButtonAction;

@end
