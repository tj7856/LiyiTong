//
//  addPersonViewController.m
//  LiyiTong
//
//  Created by 耿远风 on 16/8/12.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "addPersonViewController.h"
#import <SDAutoLayout.h>
#import "YFAlert.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "NSDate+Helper.h"
#import "popAlertView.h"
@interface addPersonViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,YFPopViewDelegate>
{
    UIScrollView *backScroll;
    UIImageView *header;
    UIView *informationview;
    UIButton *photo;
    UIImagePickerController *_imagePickerController;
    UIButton *chooseTimer;
    NSArray *alertArray;
    UIButton *alertTimer;
    popAlertView *popView;
    NSArray *moreArray;
    UIView *blackView;//手势黑色背景
    UIView *whiteView;
    UIDatePicker *timePicker;
}
@property (nonatomic,strong)UIView *navview;
@end

@implementation addPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    backScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backScroll.contentSize=CGSizeMake(0, ScreenWidth);
    backScroll.backgroundColor=Color(238, 238, 238);
    backScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:backScroll];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
    alertArray=@[@"生日当天",@"前1天",@"前3天",@"前5天",@"前7天",@"前15天",@"前30天",@"不提醒"];
    moreArray=@[@"关系",@"分组",@"手机",@"微信",@"QQ"];
    [self navView];
    [self userHeader];
    [self view2];
    [self view3];
}
-(void)userHeader{
    header=[[UIImageView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, 608*WidthScale)];
    header.image=[UIImage imageNamed:@"bg_01"];
    header.backgroundColor=[UIColor blueColor];
    header.userInteractionEnabled=YES;
    [backScroll addSubview:header];
    
    photo=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 216*WidthScale, 216*WidthScale)];
    photo.center=header.center;
    [photo setImage:[UIImage imageNamed:@"填写资料-选填_03"] forState:UIControlStateNormal];
    [photo addTarget:self action:@selector(AlertThree:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:photo];
    UILabel *label=[[UILabel alloc]init];
    label.text=@"填写Ta的资料";
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    [header addSubview:label];
    label.sd_layout.leftSpaceToView(header,210*WidthScale).rightSpaceToView(header,210*WidthScale).topSpaceToView(photo,10).heightIs(20);
    
}
//自定义导航栏
-(void)navView{
    _navview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navview.backgroundColor=[UIColor clearColor];
//    self.navview.alpha=0.3;
    [self.view addSubview:_navview];
    //自定义返回按钮
    UIButton *backButton = [[UIButton alloc]init];
    backButton.frame=CGRectMake(10, 25, 25, 25);
    //设置UIButton的图像
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    [_navview addSubview:backButton];
    
    UIButton *endButton=[[UIButton alloc]init];
    [endButton setImage:[UIImage imageNamed:@"dd_03"] forState:UIControlStateNormal];
    endButton.frame=CGRectMake(ScreenWidth-35, 25, 25, 25);
    [_navview addSubview:endButton];

    
}

-(void)view2{
    informationview=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(header.frame), ScreenWidth, 464*WidthScale)];
    informationview.backgroundColor=Color(204, 204, 204);
    [backScroll addSubview:informationview];
    NSArray *titleAry=@[@"姓名:",@"性别:",@"生日:",@"提醒:"];
    for (int i=0; i<4; i++) {
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 116*WidthScale*i, ScreenWidth, 114*WidthScale)];
        view1.backgroundColor=[UIColor whiteColor];
        [informationview addSubview:view1];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 116*WidthScale*i, 120*WidthScale, 114*WidthScale)];
        label.text=titleAry[i];
        label.textAlignment=NSTextAlignmentLeft;
        label.tag=30+i;
        [informationview addSubview:label];
    }
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(226*WidthScale, 38*WidthScale, 200, 42*WidthScale)];
    textField.placeholder=@"请输入姓名";
    [informationview addSubview:textField];
    
    UIButton *menBtn=[[UIButton alloc]init];
    [menBtn setImage:[UIImage imageNamed:@"du"] forState:UIControlStateNormal];
    [menBtn setImage:[UIImage imageNamed:@"duiTa_03"] forState:UIControlStateSelected];
    [informationview addSubview:menBtn];
    menBtn.sd_layout.topSpaceToView(textField,80*WidthScale).leftSpaceToView(informationview,228*WidthScale).widthIs(30*WidthScale).heightIs(30*WidthScale);
    UILabel *menLabel=[[UILabel alloc]init];
    menLabel.text=@"男";
    menLabel.textAlignment=NSTextAlignmentLeft;
    [informationview addSubview:menLabel];
    menLabel.sd_layout.leftSpaceToView(menBtn,2).topSpaceToView(textField,78*WidthScale).widthIs(50).heightIs(36*WidthScale);
    
    UIButton *womenBtn=[[UIButton alloc]init];
    [womenBtn setImage:[UIImage imageNamed:@"dui"] forState:UIControlStateNormal];
    [womenBtn setImage:[UIImage imageNamed:@"duiTa_03"] forState:UIControlStateSelected];
    [informationview addSubview:womenBtn];
    womenBtn.sd_layout.leftSpaceToView(menBtn,224*WidthScale).topEqualToView(menBtn).widthIs(30*WidthScale).heightIs(30*WidthScale);
    UILabel *womenLabel=[[UILabel alloc]init];
    womenLabel.text=@"女";
    womenLabel.textAlignment=NSTextAlignmentLeft;
    [informationview addSubview:womenLabel];
    womenLabel.sd_layout.leftSpaceToView(womenBtn,2).topSpaceToView(textField,78*WidthScale).widthIs(50).heightIs(36*WidthScale);
    UILabel *label2=[self.view viewWithTag:31];
    UIView *viewback=[[UIView alloc]init];
    viewback.backgroundColor=Color(238, 238, 238);
    [informationview addSubview:viewback];
    viewback.sd_layout.leftSpaceToView(informationview,180*WidthScale).rightSpaceToView(informationview,0).topSpaceToView(label2,1).heightIs(116*WidthScale-1);
    
    chooseTimer=[[UIButton alloc]init];
    [chooseTimer setTitle:@"1995年9月5号" forState:UIControlStateNormal];
    [chooseTimer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    chooseTimer.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [informationview addSubview:chooseTimer];
    chooseTimer.sd_layout.leftEqualToView(menBtn).rightSpaceToView(informationview,270*WidthScale).topSpaceToView(label2,1).heightIs(116*WidthScale-1);
    [chooseTimer addTarget:self action:@selector(chooseTimer:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label3=[self.view viewWithTag:32];
    alertTimer=[[UIButton alloc]init];
    [alertTimer setTitle:@"前1天" forState:UIControlStateNormal];
    [alertTimer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    alertTimer.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [informationview addSubview:alertTimer];
    alertTimer.sd_layout.leftEqualToView(menBtn).rightSpaceToView(informationview,170).topSpaceToView(label3,1).heightIs(116*WidthScale-1);
    [alertTimer addTarget:self action:@selector(alertTimer:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)view3{
    UIView *backMore=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(informationview.frame), ScreenWidth, 170*WidthScale)];
    backMore.backgroundColor=[UIColor clearColor];
    [backScroll addSubview:backMore];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth-15, 52*WidthScale)];
    label.text=@"选填:填写后,我们将更精准地为您推荐Ta喜欢的礼物";
    label.textColor=Color(170, 170, 170);
    label.textAlignment=NSTextAlignmentLeft;
    label.adjustsFontSizeToFitWidth=YES;
    [backMore addSubview:label];
   
    UIView *line1=[[UIView alloc]init];
    line1.backgroundColor=Color(204, 204, 204);
    [backMore addSubview:line1];
    line1.sd_layout.leftSpaceToView(backMore,0).topSpaceToView(label,0).widthIs(ScreenWidth).heightIs(1);
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor whiteColor];
    [backMore addSubview:view];
    view.sd_layout.leftSpaceToView(backMore,0).topSpaceToView(line1,0).widthIs(ScreenWidth).heightIs(116*WidthScale);
    UIView *line2=[[UIView alloc]init];
    line2.backgroundColor=Color(204, 204, 204);
    [backMore addSubview:line2];
    line2.sd_layout.leftSpaceToView(backMore,0).topSpaceToView(view,0).widthIs(ScreenWidth).heightIs(1);
    
    UILabel *addlabel=[[UILabel alloc]init];
    addlabel.textAlignment=NSTextAlignmentLeft;
    addlabel.textColor=[UIColor blackColor];
    addlabel.text=@"添加更多资料:";
    [backMore addSubview:addlabel];
    addlabel.sd_layout.leftSpaceToView(backMore,15).topSpaceToView(line1,0).bottomSpaceToView(line2,0).widthIs(150);
    UIImageView *chooseImage=[[UIImageView alloc]init];
    chooseImage.image=[UIImage imageNamed:@"choose"];
    [view addSubview:chooseImage];
    chooseImage.sd_layout.rightSpaceToView(view,8).topSpaceToView(view,20*WidthScale).widthIs(76*WidthScale).heightIs(76*WidthScale);
    UIButton *button=[[UIButton alloc]initWithFrame:view.bounds];
    [button addTarget:self action:@selector(addMore) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    popView = [[popAlertView alloc] initWithSuperView:button items:moreArray];
    popView.delegate = self;

}
-(void)addMore{
    [popView showPopView];
}
- (void)chooseButton:(NSString *)title
{
    NSLog(@"%@",title);
    
}

-(void)alertTimer:(UIButton *)sendr{
    UIPickerView *pickview=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    pickview.delegate=self;
    pickview.dataSource=self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择\n\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        
    }];
    [alertController.view addSubview:pickview];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}
-(void)chooseTimer:(UIButton *)sender{
    blackView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
    blackView.backgroundColor=[UIColor blackColor];
    blackView.alpha=0.3;
    [self.view addSubview:blackView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionOfTap:)];
    [blackView addGestureRecognizer:tap];
    
    whiteView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 225)];
    whiteView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:whiteView];
    timePicker = [[UIDatePicker alloc]init];
    timePicker.datePickerMode = UIDatePickerModeDate;
    
    timePicker.frame = CGRectMake(0, 25, ScreenWidth, 200);
    [whiteView addSubview:timePicker];
    UIButton *quxiao=[UIButton buttonWithType:UIButtonTypeCustom];
    quxiao.layer.borderWidth=1;
    quxiao.layer.borderColor=Color(0, 240, 200).CGColor;
    quxiao.layer.cornerRadius=5;
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao setTitleColor:Color(0, 240, 200) forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(quxiao:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:quxiao];
    quxiao.sd_layout.topSpaceToView(whiteView,5).leftSpaceToView(whiteView,5).widthIs(50).heightIs(20);
    UIButton *queren=[UIButton buttonWithType:UIButtonTypeCustom];
    queren.layer.borderWidth=1;
    queren.layer.borderColor=Color(0, 240, 200).CGColor;
    queren.layer.cornerRadius=5;
    [queren setTitle:@"确认" forState:UIControlStateNormal];
    [queren setTitleColor:Color(0, 240, 200) forState:UIControlStateNormal];
    [queren addTarget:self action:@selector(queren:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:queren];
    queren.sd_layout.topSpaceToView(whiteView,5).rightSpaceToView(whiteView,5).widthIs(50).heightIs(20);
    [UIView animateWithDuration:0.3 animations:^{
        blackView.y=0;
        whiteView.y=ScreenHeight-225;
    }];
}
-(void)actionOfTap:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.3 animations:^{
        blackView.y=ScreenHeight;
        whiteView.y=ScreenHeight;
        NSDate *date = timePicker.date;
        [chooseTimer setTitle:[date stringWithFormat:@"yyyy年MM月dd"] forState:UIControlStateNormal];
    }];
}
-(void)queren:(UIButton *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        blackView.y=ScreenHeight;
        whiteView.y=ScreenHeight;
        NSDate *date = timePicker.date;
        [chooseTimer setTitle:[date stringWithFormat:@"yyyy年MM月dd"] forState:UIControlStateNormal];
    }];
}
-(void)quxiao:(UIButton *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        blackView.y=ScreenHeight;
        whiteView.y=ScreenHeight;
    }];
}
-(void)AlertThree:(UIButton *)sender{
    
    YFAlert *yfAlert = [[YFAlert alloc] initWithTitle:@"提示" message:@"拍照"];
    
    [yfAlert addBtnAlertTitle:@"相机" action:^{
        [self camera];
        NSLog(@"相机");
        
    }];
    
    [yfAlert addBtnAlertTitle:@"相册" action:^{
        [self photo];
        NSLog(@"相册");
        
    }];
    
    [yfAlert addBtnAlertTitle:@"取消" action:^{
        
        NSLog(@"取消");
        
    }];
    
    [yfAlert showAlertWithSender:self];
    
    
}
//相册
- (void)photo
{
    /**
     
     UIImagePickerControllerSourceTypePhotoLibrary ,//来自图库
     UIImagePickerControllerSourceTypeCamera ,//来自相机
     UIImagePickerControllerSourceTypeSavedPhotosAlbum //来自相册
     */
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}
//相机
- (void)camera
{
    //判断是否可以打开相机，模拟器此功能无法使用
    if (![UIImagePickerController isSourceTypeAvailable:
          
          UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    imagePicker.allowsEditing = YES;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        //如果是拍摄的照片
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //保存在相册
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        [photo setImage:image forState:UIControlStateNormal];
        photo.layer.cornerRadius=photo.height/2;
        photo.clipsToBounds=YES;
        
    }
    else if ([mediaType isEqualToString:@"public.movie"])
    {
        //获取视图的url
        NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
        //播放视频
        NSLog(@"%@",url);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return alertArray.count;
    
}
#pragma mark - 该方法返回的NSString将作为UIPickerView中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return alertArray[row];
}
#pragma mark - 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
    [alertTimer setTitle:alertArray[rowOne] forState:UIControlStateNormal];
}

-(void)backItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]; //状态栏设置为透明
    self.navigationController.navigationBar.hidden=NO;
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
