//
//  PublishViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/9/26.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "PublishViewController.h"
#import <SDAutoLayout.h>
//#import "YZInputView.h"
#import "LGPhoto.h"
#import "SearchGoodsViewController.h"
@interface PublishViewController ()<UITextViewDelegate,LGPhotoPickerViewControllerDelegate>
//@property(nonatomic,weak)YZInputView *input;
@property(nonatomic,weak)UITextView *tv;
@property(nonatomic,weak)UIView *bottemView;
@property(nonatomic,weak)UIScrollView *scrollV;
@property(nonatomic,weak)UIView *layoutView;
@property(nonatomic,strong)NSMutableArray *layoutViewArry;
@end

@implementation PublishViewController

-(NSMutableArray *)layoutViewArry
{
    if (!_layoutViewArry) {
        _layoutViewArry = [NSMutableArray array];
    }
    return _layoutViewArry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title =@"发帖";
    [self setupNavgate];
    [self setupBootm];
    
//    UITextField *t = [[UITextField alloc]init];
//    
//    [self.view addSubview:t];
//    t.layer.borderWidth = 1;
//    t.layer.cornerRadius = 5;
//    t.layer.borderColor = [UIColor lightGrayColor].CGColor;
//t.sd_layout.topSpaceToView(self.view,100).leftSpaceToView(self.view,10).rightSpaceToView(self.view,10).heightIs(36);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    UIScrollView *scrollV = [[UIScrollView alloc]init];
    self.scrollV = scrollV;
    scrollV.backgroundColor =[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [self.view  addSubview:scrollV];
    scrollV.delegate = self;
//    scrollV.backgroundColor = [UIColor redColor];
    scrollV.sd_layout.topSpaceToView(self.view,64).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.bottemView,0);
//    UIView *contentView = [[UIView alloc]init];
//    contentView.backgroundColor = [UIColor blueColor];
//    [scrollV addSubview:contentView];
////    scrollV.contentSize = CGSizeMake(375, 1000);
//    contentView.sd_layout.topSpaceToView(scrollV,0).leftSpaceToView(scrollV,0).rightSpaceToView(scrollV,0).bottomSpaceToView(scrollV,0).widthRatioToView(scrollV,1.0f).heightIs(1000);
//    [scrollV setupAutoContentSizeWithBottomView:contentView bottomMargin:10];

    UITextField *title = [[UITextField alloc]init];
    title.placeholder = @"标题";
    title.font = [UIFont systemFontOfSize:20];
    title.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.scrollV addSubview:title];
    title.sd_layout.leftSpaceToView(self.scrollV,10).rightSpaceToView(self.scrollV,100).topSpaceToView(self.scrollV,10).heightIs(22);
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:168/255.0 green:168/255.0 blue:168/255.0 alpha:1];
    [scrollV addSubview:line];
    line.sd_layout.heightIs(1).leftSpaceToView(scrollV,6).rightSpaceToView(scrollV,6).topSpaceToView(title,15);
    
    UITextView *tv =  [[UITextView alloc]init];
    tv.backgroundColor = [UIColor clearColor];
    tv.font = [UIFont systemFontOfSize:16];
    tv.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    self.tv = tv;
    tv.delegate = self;
    [self.scrollV addSubview:tv];
    tv.scrollEnabled = NO;
//    tv.scrollsToTop = NO;
    tv.showsHorizontalScrollIndicator = NO;
//    tv.enablesReturnKeyAutomatically = YES;
    self.automaticallyAdjustsScrollViewInsets = false;
//    tv.automa automaticallyAdjustsScrollViewInsets = false;
    tv.layer.borderWidth = 1;
    tv.layer.cornerRadius = 5;
    tv.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
//    tv.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidBeginEditingNotification object:self];
    tv.font =[UIFont systemFontOfSize:16];
     tv.sd_layout.topSpaceToView(line,20).leftSpaceToView(self.scrollV,10).rightSpaceToView(self.scrollV,10).heightIs(32);
    [self.layoutViewArry addObject:tv];
    self.layoutView = tv;
    [scrollV setupAutoContentSizeWithBottomView:tv bottomMargin:10];

}

-(void)setupNavgate
{
    UIButton *quxiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60*WidthScale, 30*WidthScale)];
    quxiaoBtn.titleLabel.font=[UIFont systemFontOfSize:30*WidthScale];
    [quxiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
    [quxiaoBtn setTitleColor:Color(170, 170, 170) forState:UIControlStateSelected];
    [quxiaoBtn setTitleColor:Color(11, 231, 196) forState:UIControlStateNormal];
    
    UIButton *fabuBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60*WidthScale, 30*WidthScale)];
    fabuBtn.titleLabel.font=[UIFont systemFontOfSize:30*WidthScale];
    [fabuBtn setTitle:@"发布" forState:UIControlStateNormal];
    [fabuBtn setTitleColor:Color(170, 170, 170) forState:UIControlStateNormal];
    [fabuBtn setTitleColor:Color(11, 231, 196) forState:UIControlStateSelected];
    //    [fabuBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem1=[[UIBarButtonItem alloc]initWithCustomView:fabuBtn];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc]initWithCustomView:quxiaoBtn];
    self.navigationItem.rightBarButtonItems=@[rightItem1,rightItem2];
    
   
}

-(void)setupBootm
{
    UIView *bottemView = [[UIView alloc]init];
    self.bottemView =bottemView;
//    bottemView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-166*WidthScale, ScreenWidth, 166*WidthScale)];
    bottemView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bottemView];
    bottemView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0).heightIs(166*WidthScale);
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    line1.backgroundColor=[UIColor colorWithRed:0.765 green:0.769 blue:0.773 alpha:1.000];
    [bottemView addSubview:line1];
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0, 70*WidthScale, ScreenWidth, 1)];
    line2.backgroundColor=[UIColor colorWithRed:0.765 green:0.769 blue:0.773 alpha:1.000];
    [bottemView addSubview:line2];
    
    UIImageView *leftimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_06"]];
    [bottemView addSubview:leftimage];
    leftimage.sd_layout.leftSpaceToView(bottemView,18*WidthScale).topSpaceToView(bottemView,20*WidthScale).widthIs(35*WidthScale).heightIs(35*WidthScale);
    UILabel *label1=[[UILabel alloc]init];
    label1.text=@"请选择话题";
    label1.font=[UIFont systemFontOfSize:34*WidthScale];
    label1.textColor=Color(170, 170, 170);
    [bottemView addSubview:label1];
    label1.sd_layout.leftSpaceToView(leftimage,5).topEqualToView(leftimage).widthIs(170*WidthScale).heightIs(34*WidthScale);
    
    UIImageView *chooseImg=[[UIImageView alloc]init];
    chooseImg.image=[UIImage imageNamed:@"fatieico_03"];
    [bottemView addSubview:chooseImg];
    chooseImg.sd_layout.rightSpaceToView(bottemView,10).topEqualToView(label1).widthIs(35*WidthScale).heightIs(35*WidthScale);
    
    
    UILabel *label2=[[UILabel alloc]init];
    label2.text=@"( 必选 )";
    label2.font=[UIFont systemFontOfSize:30*WidthScale];
    label2.textColor=Color(11, 231, 196);
    label2.textAlignment=NSTextAlignmentRight;
    [bottemView addSubview:label2];
    label2.sd_layout.rightSpaceToView(chooseImg,3).topEqualToView(chooseImg).widthIs(100).heightIs(30*WidthScale);
    UIImageView *biaotiImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_11"]];
    [bottemView addSubview:biaotiImg];
    biaotiImg.sd_layout.leftSpaceToView(bottemView,60*WidthScale).topSpaceToView(line2,28*WidthScale).widthIs(35*WidthScale).heightIs(35*WidthScale);
    UILabel *biaotiLabel=[[UILabel alloc]init];
    biaotiLabel.text=@"小标题";
    biaotiLabel.font=[UIFont systemFontOfSize:32*WidthScale];
    biaotiLabel.textColor=Color(170, 170, 170);
    [bottemView addSubview:biaotiLabel];
    biaotiLabel.sd_layout.leftSpaceToView(biaotiImg,0).topEqualToView(biaotiImg).widthIs(32*3*WidthScale).heightIs(32*WidthScale);
    UIButton *biaotiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [bottemView addSubview:biaotiBtn];
    biaotiBtn.sd_layout.leftEqualToView(biaotiImg).topEqualToView(biaotiImg).rightEqualToView(biaotiLabel).bottomEqualToView(biaotiImg);
    [biaotiBtn addTarget:self action:@selector(biaotiBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *tupianImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_13"]];
    [bottemView addSubview:tupianImg];
    tupianImg.sd_layout.leftSpaceToView(biaotiBtn,126*WidthScale).topEqualToView(biaotiBtn).widthIs(35*WidthScale).heightIs(35*WidthScale);
    UILabel *tupianLabel=[[UILabel alloc]init];
    tupianLabel.text=@"图片";
    tupianLabel.font=[UIFont systemFontOfSize:32*WidthScale];
    tupianLabel.textColor=Color(170, 170, 170);
    [bottemView addSubview:tupianLabel];
    tupianLabel.sd_layout.leftSpaceToView(tupianImg,0).topEqualToView(tupianImg).widthIs(64*WidthScale).heightIs(32*WidthScale);
    UIButton *tupianBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [bottemView addSubview:tupianBtn];
    tupianBtn.sd_layout.leftEqualToView(tupianImg).topEqualToView(tupianImg).rightEqualToView(tupianLabel).bottomEqualToView(tupianImg);
    [tupianBtn addTarget:self action:@selector(addSomePhotos) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *liwuImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_15"]];
    [bottemView addSubview:liwuImg];
    liwuImg.sd_layout.leftSpaceToView(tupianBtn,146*WidthScale).topEqualToView(tupianBtn).widthIs(35*WidthScale).heightIs(35*WidthScale);
    UILabel *liwuLabel=[[UILabel alloc]init];
    liwuLabel.text=@"礼物";
    liwuLabel.font=[UIFont systemFontOfSize:32*WidthScale];
    liwuLabel.textColor=Color(170, 170, 170);
    [bottemView addSubview:liwuLabel];
    liwuLabel.sd_layout.leftSpaceToView(liwuImg,0).topEqualToView(liwuImg).widthIs(64*WidthScale).heightIs(32*WidthScale);
    UIButton *liwuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [bottemView addSubview:liwuBtn];
    liwuBtn.sd_layout.leftEqualToView(liwuImg).topEqualToView(liwuImg).rightEqualToView(liwuLabel).bottomEqualToView(liwuImg);
    [liwuBtn addTarget:self action:@selector(liwuBtn:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    [self.tv resignFirstResponder];
    [self.view endEditing:YES];
    self.layoutView = self.layoutViewArry.lastObject;
//    self.input.text = nil;
//    self.input.hidden = YES;
}
-(void)textDidChange
{
    NSLog(@"textChange");
}

/**
 *  初始化相册选择器
 */
- (void)presentPhotoPickerViewControllerWithStyle:(LGShowImageType)style {
    LGPhotoPickerViewController *pickerVc = [[LGPhotoPickerViewController alloc] initWithShowType:style];
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.maxCount = 9;   // 最多能选9张图片
    pickerVc.delegate = self;
//    self.showType = style;
    [pickerVc showPickerVc:self];
}

-(void)biaotiBtn:(UIButton *)sender
{
    NSUInteger index1 = [self.layoutViewArry indexOfObject:self.layoutView];
    UIView *view;
    if (index1 ==self.layoutViewArry.count -1) {
        view = nil;
    }
    else
    {
        view = self.layoutViewArry[index1+1];
    }

    
    UIView *title = [[UIView alloc]init];
    title.backgroundColor = [UIColor whiteColor];
        title.layer.borderColor = [UIColor lightGrayColor].CGColor;;
        title.layer.borderWidth = 1;
    [self.scrollV addSubview:title];
    if (view) {
        [self.layoutViewArry insertObject:title atIndex:index1+1];
    }
    else
    {
        [self.layoutViewArry addObject:title];
    }
    title.sd_layout.leftSpaceToView(self.scrollV,10).rightSpaceToView(self.scrollV,10).topSpaceToView(self.layoutView,10).heightIs(34);
    UIView *zhuzi =[[UIView alloc]init];
    zhuzi.backgroundColor = [UIColor colorWithRed:12/255.0 green:230/255.0 blue:196/255.0 alpha:1];
    [title addSubview:zhuzi];
    zhuzi.sd_layout.widthIs(4).heightRatioToView(title,1.0f).leftSpaceToView(title,2).topSpaceToView(title,0);
    
    UIButton *delete =[UIButton buttonWithType:(UIButtonTypeCustom)];
    [delete setImage:[UIImage imageNamed:@"xxx_03"] forState:(UIControlStateNormal)];
    [title addSubview:delete];
    [delete addTarget:self action:@selector(delete:) forControlEvents:(UIControlEventTouchUpInside)];
    delete.sd_layout.rightSpaceToView(title,0).topSpaceToView(title,0).bottomSpaceToView(title,0).widthIs(23);
    
    UITextField *smallTitle = [[UITextField alloc]init];
//    smallTitle.layer.borderColor = [UIColor blackColor].CGColor;
//    smallTitle.layer.borderWidth = 1;
    [title addSubview:smallTitle];
    smallTitle.sd_layout.leftSpaceToView(zhuzi,4).rightSpaceToView(delete,0).topSpaceToView(title,0).bottomSpaceToView(title,0);
//    [smallTitle becomeFirstResponder];
    
    UITextView *tv =  [[UITextView alloc]init];
    tv.delegate = self;
    [self.scrollV addSubview:tv];
    if (view) {
        [self.layoutViewArry insertObject:tv atIndex:index1+2];
    }
    else
    {
        [self.layoutViewArry addObject:tv];
    }
    tv.backgroundColor = [UIColor clearColor];
    tv.font = [UIFont systemFontOfSize:16];
    tv.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    tv.scrollEnabled = NO;
    
    tv.showsHorizontalScrollIndicator = NO;
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    tv.layer.borderWidth = 1;
    tv.layer.cornerRadius = 5;
    tv.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    tv.font =[UIFont systemFontOfSize:16];
    tv.sd_layout.topSpaceToView(title,10).leftSpaceToView(self.scrollV,10).rightSpaceToView(self.scrollV,10).heightIs(32);
    self.layoutView =tv;
    
    if (view) {
        view.sd_layout.topSpaceToView(self.layoutView,10);
        [self.scrollV updateLayout];
        [self.scrollV setupAutoContentSizeWithBottomView:self.layoutViewArry.lastObject bottomMargin:10];
    }
    else
    {
        [self.scrollV setupAutoContentSizeWithBottomView:self.layoutViewArry.lastObject bottomMargin:10];
    }

}

-(void)addSomePhotos
{
    [self presentPhotoPickerViewControllerWithStyle:LGShowImageTypeImagePicker];
}

-(void)liwuBtn:(UIButton *)sender
{
    SearchGoodsViewController *search = [[SearchGoodsViewController alloc]init];
    [self presentViewController:search animated:YES completion:nil];
}

-(void)delete:(UIButton *)sender
{
   NSUInteger index= [self.layoutViewArry indexOfObject:sender.superview];
    UIView *preView = (UIView *)(self.layoutViewArry[index-1]);
    UIView *nextView = (UIView *)(self.layoutViewArry[index+1]);
    if ([nextView isKindOfClass:[UITextView class]]) {
        if ([((UITextView *)nextView).text isEqualToString:@""]) {
            if (index==self.layoutViewArry.count -2) {
                nextView =nil;
            }
            else
            {
            nextView = (UIView *)(self.layoutViewArry[index+2]);
          

            }
            [((UIView *)(self.layoutViewArry[index+1])) removeFromSuperview];
            [self.layoutViewArry removeObjectAtIndex:index+1];
        }
    }
    if (nextView) {
        nextView.sd_layout.topSpaceToView(preView,10);
        [nextView updateLayout];
    }
    else
    {
        self.layoutView = preView;
         [self.scrollV setupAutoContentSizeWithBottomView:self.layoutView bottomMargin:10];
    }
    
    
    
    [self.layoutViewArry removeObjectAtIndex:index];
    [sender.superview removeFromSuperview];
}

#pragma mark - LGPhotoPickerViewControllerDelegate

- (void)pickerViewControllerDoneAsstes:(NSArray *)assets isOriginal:(BOOL)original{
    
     //assets的元素是LGPhotoAssets对象，获取image方法如下:
     NSMutableArray *thumbImageArray = [NSMutableArray array];
     NSMutableArray *originImage = [NSMutableArray array];
//     NSMutableArray *fullResolutionImage = [NSMutableArray array];
     NSUInteger index1 = [self.layoutViewArry indexOfObject:self.layoutView];
    UIView *view;
    if (index1 ==self.layoutViewArry.count -1) {
        view = nil;
    }
    else
    {
         view = self.layoutViewArry[index1+1];
    }
   
     for (LGPhotoAssets *photo in assets) {
     //缩略图
     [thumbImageArray addObject:photo.thumbImage];
     //原图
     [originImage addObject:photo.originImage];
         NSLog(@"--%@",[self.layoutView class]);
         NSUInteger index = [self.layoutViewArry indexOfObject:self.layoutView];
         UIImageView *imgv = [[UIImageView alloc]init];
         imgv.image = photo.originImage;
         imgv.contentMode = UIViewContentModeScaleToFill;
//         self.layoutView =imgv;
        
         [self.scrollV addSubview:imgv];
         if (view) {
             [self.layoutViewArry insertObject:imgv atIndex:index+1];
         }
         else
         {
             [self.layoutViewArry addObject:imgv];
         }
         
//         

       CGFloat h = (ScreenWidth-20)*(photo.originImage.size.height/2)/(photo.originImage.size.width/2);
         imgv.sd_layout.widthIs(ScreenWidth-20).leftSpaceToView(self.scrollV,10).heightIs(h).topSpaceToView(self.layoutView,10);
         imgv.userInteractionEnabled =YES;
         UIButton *delete =[UIButton buttonWithType:(UIButtonTypeCustom)];
         [delete setImage:[UIImage imageNamed:@"xxx_03"] forState:(UIControlStateNormal)];
         [imgv addSubview:delete];
         [delete addTarget:self action:@selector(delete:) forControlEvents:(UIControlEventTouchUpInside)];
         delete.sd_layout.rightSpaceToView(imgv,0).topSpaceToView(imgv,0).heightIs(23).widthIs(23);
//          NSUInteger index2 = [self.layoutViewArry indexOfObject:self.layoutView];
         UITextView *tv =  [[UITextView alloc]init];
         tv.delegate = self;
         [self.scrollV addSubview:tv];
         if (view) {
             [self.layoutViewArry insertObject:tv atIndex:index+2];
         }
         else
         {
             [self.layoutViewArry addObject:tv];
         }
//         [self.layoutViewArry insertObject:tv atIndex:index2];
         
//         [self.layoutViewArry addObject:tv];
         tv.scrollEnabled = NO;
   
         tv.showsHorizontalScrollIndicator = NO;
         
         self.automaticallyAdjustsScrollViewInsets = false;
      
         tv.layer.borderWidth = 1;
         tv.layer.cornerRadius = 5;
         tv.layer.borderColor = [UIColor lightGrayColor].CGColor;
       
         tv.font =[UIFont systemFontOfSize:16];
         tv.sd_layout.topSpaceToView(imgv,10).leftSpaceToView(self.scrollV,10).rightSpaceToView(self.scrollV,10).heightIs(32);
         self.layoutView =tv;
         
         
         
//     //全屏图
//     [fullResolutionImage addObject:fullResolutionImage];
     }
    if (view) {
        view.sd_layout.topSpaceToView(self.layoutView,10);
         [self.scrollV updateLayout];
        [self.scrollV setupAutoContentSizeWithBottomView:self.layoutViewArry.lastObject bottomMargin:10];
    }
    else
    {
        [self.scrollV setupAutoContentSizeWithBottomView:self.layoutView bottomMargin:10];
    }
    
    
    
//    NSInteger num = (long)assets.count;
//    NSString *isOriginal = original? @"YES":@"NO";
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发送图片" message:[NSString stringWithFormat:@"您选择了%ld张图片\n是否原图：%@",(long)num,isOriginal] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alertView show];
}
- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    self.layoutView = textView;
}
// 键盘弹出会调用
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 获取键盘frame
    CGRect endFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 获取键盘弹出时长
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    // 修改底部视图距离底部的间距
    CGFloat f = endFrame.origin.y != screenH?endFrame.size.height:0;

    self.bottemView.sd_layout.bottomSpaceToView(self.view,f);
    
    //    NSLog(@"f=%f",f);
    // 约束动画
    [UIView animateWithDuration:duration animations:^{
        //        [self.view layoutIfNeeded];
        [self.bottemView updateLayout];
    }];
}

-(void)textViewDidChange:(UITextView *)textView{
    //博客园-FlyElephant
//    static CGFloat maxHeight =60.0f;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    
    textView.sd_layout.heightIs(size.height);
    [textView updateLayout];

}
-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

@end
