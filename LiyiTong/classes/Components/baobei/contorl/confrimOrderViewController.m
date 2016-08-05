//
//  confrimOrderViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/8/3.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "confrimOrderViewController.h"
#import "Order.h"

@interface confrimOrderViewController ()
//@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *jiage;
@property (weak, nonatomic) IBOutlet UILabel *shuliang;
@property (weak, nonatomic) IBOutlet UILabel *renshu;
@property (weak, nonatomic) IBOutlet UILabel *fenshu;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIButton *showJiage;
@property (weak, nonatomic) IBOutlet UILabel *youHfangshi;
@property (weak, nonatomic) IBOutlet UISwitch *swith;
@property (weak, nonatomic) IBOutlet UILabel *liPlinge;
@property (weak, nonatomic) IBOutlet UILabel *yunfei;
@property (weak, nonatomic) IBOutlet UILabel *zongjia;
@property (weak, nonatomic) IBOutlet UILabel *jianjia;


@property (nonatomic,strong)Order *order;

@end

@implementation confrimOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.order.fenshu =self.order.renshu=1;
    self.order.KouEdian = 60;
    self.order.yunfei = 0;
 
}

-(Order *)order
{
    if (!_order) {
        _order = [[Order alloc]init];
    }
    return _order;
}
- (IBAction)switch:(UISwitch *)sender {
    self.order.KouEdian = sender.isOn?60:0;
    [self updataOrder];
}
- (IBAction)huanci:(id)sender {
}
- (IBAction)tijiao:(id)sender {
}
- (IBAction)JiajianAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            self.order.renshu=self.order.renshu>1?self.order.renshu -1:self.order.renshu;
            break;
        case 2:
            self.order.renshu=self.order.renshu>=1?self.order.renshu +1:self.order.renshu;
            break;
        case 3:
            self.order.fenshu=self.order.fenshu>1?self.order.fenshu -1:self.order.fenshu;
            break;
        case 4:
            self.order.fenshu=self.order.fenshu>=1?self.order.fenshu +1:self.order.fenshu;
            break;
            
        default:
            break;
    }
    [self updataOrder];
    
}

-(void)updataOrder
{
    self.order.lipingJinE = 139*self.order.renshu*self.order.fenshu;
    self.order.yunfei = 0;
    self.order.Edian = self.swith.isOn;
   self.order.jianjia = self.order.KouEdian = self.swith.isOn == YES?self.order.KouEdian:0;
    self.order.zongjia = self.order.lipingJinE - self.order.yunfei - self.order.KouEdian;
    [self updataUI];
}

-(void)updataUI
{
    
    self.shuliang.text = [NSString stringWithFormat:@"X%ld", self.order.renshu*self.order.fenshu];
    self.renshu.text = [NSString stringWithFormat:@"%ld", self.order.renshu];
    self.fenshu.text = [NSString stringWithFormat:@"%ld", self.order.fenshu];
    self.liPlinge.text =[NSString stringWithFormat:@"%.02f", self.order.lipingJinE];
    self.yunfei.text = [NSString stringWithFormat:@"%.02f", self.order.yunfei];
    self.zongjia.text = [NSString stringWithFormat:@"%.02f", self.order.zongjia];
    self.jianjia.text =[NSString stringWithFormat:@"已减去%.02f", self.order.jianjia];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
