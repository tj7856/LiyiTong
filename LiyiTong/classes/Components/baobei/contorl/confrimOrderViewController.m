//
//  confrimOrderViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/8/3.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "confrimOrderViewController.h"
#import "Order.h"
#import "zhifuModeViewController.h"

@interface confrimOrderViewController ()<UIActionSheetDelegate>
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
    
    [self setup];
}

-(void)setup
{
    self.title =@"确认订单";
//    self.navigationItem.titleView = nil;
    self.order.fenshu =self.order.renshu=1;
    self.order.KouEdian = 60;
    self.order.yunfei = 0;
    
//    self.navigationItem.leftBarButtonItem=
//    [self itemWithTarget:self action:@selector(rightButtonAction) Title:@""];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_9x16"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];

}
-(void)leftBarButtonItemClick
{
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"陛下真的要放弃提交订单吗？" delegate:self cancelButtonTitle:@"待朕想想" destructiveButtonTitle:@"朕去意已决" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
}


//-(void)rightButtonAction
//{
////    NSLog(@"hahhah");
//}

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
- (IBAction)duihao:(UIButton*)sender {
    sender.selected = !sender.selected;
}
- (IBAction)huanci:(id)sender {
}
- (IBAction)tijiao:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([zhifuModeViewController class]) bundle:nil];
    zhifuModeViewController * zhifu = [storyboard instantiateInitialViewController];
    zhifu.pricen =self.zongjia.text ;
    [self.navigationController pushViewController:zhifu animated:YES];
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

#pragma Mark actionSheetDelegate

//-(void)actionSheetCancel:(UIActionSheet *)actionSheet
//{
//    NSLog(@"Cancel");
//}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (buttonIndex == 1) {
//        NSLog(@"Cancel1");
    }
}

//-(void)acti

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
