//
//  zhifuModeViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/8/12.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "zhifuModeViewController.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
//#import "RespForWeChatViewController.h"
#import "Constant.h"

@interface zhifuModeViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *pricenLabel;
@property(nonatomic,weak)UIButton* selectedBTN;
@end

@implementation zhifuModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    // Do any additional setup after loading the view.
}

-(void)setup{
    self.pricenLabel.text = self.pricen;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_9x16"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
}
-(void)leftBarButtonItemClick
{
    [[[UIAlertView alloc] initWithTitle:@"确认要离开收银台？" message:@"下单后24小时内未支付成功，订单将被取消。请尽快完成支付" delegate:self cancelButtonTitle:@"继续支付" otherButtonTitles:@"确认离开", nil] show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)zhifuModelSelect:(UIButton *)sender {
    self.selectedBTN.selected=NO;
    sender.selected = YES;
    self.selectedBTN = sender;
    
}
- (IBAction)lijizhifu:(id)sender {
    switch (self.selectedBTN.tag) {
        case 1:
            
            break;
        case 2:
            [self bizPay];
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
}

#pragma Mark UIAltviewDategate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }else if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (void)bizPay {
    NSString *res = [WXApiRequestHandler jumpToBizPay];
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];
        
    }
    
}


@end
