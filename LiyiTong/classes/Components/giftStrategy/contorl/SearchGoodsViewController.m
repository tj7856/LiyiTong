//
//  SearchGoodsViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/9/28.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "SearchGoodsViewController.h"
#import "WebSearchViewController.h"

@interface SearchGoodsViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *backBTN;

@end

@implementation SearchGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.backView.layer.cornerRadius =15 ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)WebClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            WebSearchViewController *webS =[[WebSearchViewController alloc]init];
            webS.URL =@"http://m.taobao.com";
            [self presentViewController:webS animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}
- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
