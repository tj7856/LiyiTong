//
//  ConnectionViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/7/27.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#define UIBounds [[UIScreen mainScreen] bounds]


#import "ConnectionViewController.h"
#import <SDAutoLayout.h>
#import "HeaderView.h"
#import "ChineseToPinyin.h"
#import "ConnectionTableViewCell.h"
#import "addPersonViewController.h"

@interface ConnectionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *backScroll;
    UIImageView *headImg;
    UIView *jieri;
    UITableView                 *_tableView;
    NSArray                     *_oldCityList;
    NSMutableDictionary         *_newCityDic;
    NSMutableArray              *_allKeysArray;
    int now;//现在
    int zhongqiujie;//中秋节
    int more;//剩余
    UILabel *ZQLabel;
    NSTimer *myTimer;
    NSTimer *leftBirthdayTimer;
    int leftBirdayMore;
    NSTimer *leftMemorialDayTimer;
    int leftMemorialDayMore;
    NSTimer *rightBirthdayTimer;
    int rightBirdayMore;
    NSTimer *rightMemorialDayTimer;
    int rightMemorialDayMore;
    
}
@property (nonatomic,strong)UIButton *leftTure;//对号
@property (nonatomic,strong)UILabel *leftName;//名字
@property (nonatomic,strong)UIImageView *leftBirthday;//生日
@property (nonatomic,strong)UIImageView *leftEngagement;//约会
@property (nonatomic,strong)UILabel *leftbirthdayTimer;//生日倒计时
@property (nonatomic,strong)UILabel *leftmemorialDayTimer;//纪念日倒计时

@property (nonatomic,strong)UIButton *rightTure;//对号
@property (nonatomic,strong)UILabel *rightName;//名字
@property (nonatomic,strong)UIImageView *rightBirthday;//生日
@property (nonatomic,strong)UIImageView *rightEngagement;//约会
@property (nonatomic,strong)UILabel *rightbirthdayTimer;//生日倒计时
@property (nonatomic,strong)UILabel *rightmemorialDayTimer;//纪念日倒计时
@end

@implementation ConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"人脉";
    
    
    //初始化一个无序杂乱的城市列表数组
    _oldCityList = @[@"阿伟",@"阿姨",@"阿三",@"蔡芯",@"成龙",@"陈鑫",@"陈丹",@"成名",@"芳仔",@"房祖名",@"方大同",@"芳芳",@"范伟",@"郭靖",@"郭美美",@"过儿",@"过山车",@"何仙姑",@"和珅",@"郝歌",@"好人",@"妈妈",@"沈冰",@"婶婶",@"涛涛",@"淘宝",@"套娃",@"小二",@"夏紫薇",@"许巍",@"许晴",@"周恩来",@"周杰伦",@"张柏芝",@"张大仙"];
    
    //初始化数据源字典
    _newCityDic = [[NSMutableDictionary alloc]init];
    
    _allKeysArray = [[NSMutableArray alloc]init];
    
    
    [self prepareCityListDatasourceWithArray:_oldCityList andToDictionary:_newCityDic];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [addButton setImage:[UIImage imageNamed:@"tianjia"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = addItem;
    
    backScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backScroll.contentSize=CGSizeMake(0, 338*WidthScale+10+80*WidthScale+[_newCityDic allKeys].count*20+_oldCityList.count*53+64);
    backScroll.backgroundColor=Color(238, 238, 238);
    backScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:backScroll];
    NSDate *nowDate=[NSDate date];
    now=(int)nowDate.timeIntervalSince1970;//初始化现在的时间，多次用到
    NSLog(@"%d",now);
    [self headView];
    [self zhongqiuTimer];
    [self address];
}
-(void)headView{
    headImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 6, ScreenWidth, 338*WidthScale)];
    headImg.image=[UIImage imageNamed:@"人脉-节日提醒_02"];
    [backScroll addSubview:headImg];
    headImg.userInteractionEnabled=YES;
    UIImageView *leftImage=[[UIImageView alloc]init];
    leftImage.image=[UIImage imageNamed:@"laopo"];
    leftImage.layer.borderWidth=1;
    leftImage.layer.borderColor=[UIColor whiteColor].CGColor;
    leftImage.layer.cornerRadius=70*WidthScale;
    leftImage.clipsToBounds=YES;
    [headImg addSubview:leftImage];
    leftImage.sd_layout.leftSpaceToView(headImg,26*WidthScale).topSpaceToView(headImg,40*WidthScale).heightIs(140*WidthScale).widthIs(140*WidthScale);
    
    self.leftTure=[[UIButton alloc]init];
    self.leftTure.layer.borderWidth=1;
    self.leftTure.layer.borderColor=[UIColor whiteColor].CGColor;
    self.leftTure.layer.cornerRadius=20*WidthScale;
    self.leftTure.clipsToBounds=YES;
    [self.leftTure setImage:[UIImage imageNamed:@"a_30"] forState:UIControlStateNormal];
    [self.leftTure setImage:[UIImage imageNamed:@"a_27"] forState:UIControlStateSelected];
//    self.leftTure.userInteractionEnabled=YES;
    [headImg addSubview:self.leftTure];
    [self.leftTure addTarget:self action:@selector(leftTure:) forControlEvents:UIControlEventTouchUpInside];
    self.leftTure.sd_layout.leftSpaceToView(headImg,117*WidthScale).topSpaceToView(headImg,40*WidthScale).heightIs(40*WidthScale).widthIs(40*WidthScale);
    
    self.leftName=[[UILabel alloc]init];
    self.leftName.frame=CGRectMake(172*WidthScale, 46*WidthScale, 50, 30*WidthScale);
    [headImg addSubview:self.leftName];
    self.leftName.text=@"帅哥老爸";
    self.leftName.font=[UIFont boldSystemFontOfSize:15];
    self.leftName.textColor=[UIColor whiteColor];
    [self.leftName sizeToFit];
    
    self.leftBirthday=[[UIImageView alloc]init];
    self.leftBirthday.image=[UIImage imageNamed:@"shengritrue"];
    [headImg addSubview:self.leftBirthday];
    self.leftBirthday.sd_layout.leftSpaceToView(self.leftName,8).bottomEqualToView(self.leftName).widthIs(30*WidthScale).heightIs(30*WidthScale);
    self.leftEngagement=[[UIImageView alloc]init];
    self.leftEngagement.image=[UIImage imageNamed:@"yuehui"];
    [headImg addSubview:self.leftEngagement];
    self.leftEngagement.sd_layout.leftSpaceToView(self.leftBirthday,5).bottomEqualToView(self.leftName).widthIs(30*WidthScale).heightIs(30*WidthScale);
    
    self.leftbirthdayTimer=[[UILabel alloc]init];
    [headImg addSubview:self.leftbirthdayTimer];
    self.leftbirthdayTimer.sd_layout.leftEqualToView(self.leftName).topSpaceToView(self.leftName,26*WidthScale).widthIs(90).heightIs(14);
    int birthday=[self future:@"20160815000000"];
    leftBirdayMore=birthday-now;
    leftBirthdayTimer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(leftBirthdaydaojishi) userInfo:nil repeats:YES];
    
    self.leftmemorialDayTimer=[[UILabel alloc]init];
    [headImg addSubview:self.leftmemorialDayTimer];
    self.leftmemorialDayTimer.sd_layout.leftEqualToView(self.leftName).bottomEqualToView(leftImage).widthIs(135).heightIs(14);
    int leftmemorialDay=[self future:@"20160821000000"];
    leftMemorialDayMore=leftmemorialDay-now;
    leftMemorialDayTimer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(leftMemorialDaydaojishi) userInfo:nil repeats:YES];
    
//    [myTimer setFireDate:[NSDate distantFuture]];
    
    UIImageView *rightImage=[[UIImageView alloc]init];
    rightImage.image=[UIImage imageNamed:@"laopo"];
    rightImage.layer.borderWidth=1;
    rightImage.layer.borderColor=[UIColor whiteColor].CGColor;
    rightImage.layer.cornerRadius=70*WidthScale;
    rightImage.clipsToBounds=YES;
    [headImg addSubview:rightImage];
    rightImage.sd_layout.rightSpaceToView(headImg,152*WidthScale).topSpaceToView(headImg,40*WidthScale).heightIs(140*WidthScale).widthIs(140*WidthScale);
    
    self.rightTure=[[UIButton alloc]init];
    self.rightTure.layer.borderWidth=1;
    self.rightTure.layer.borderColor=[UIColor whiteColor].CGColor;
    self.rightTure.layer.cornerRadius=20*WidthScale;
    self.rightTure.clipsToBounds=YES;
    [self.rightTure setImage:[UIImage imageNamed:@"a_30"] forState:UIControlStateNormal];
    [self.rightTure setImage:[UIImage imageNamed:@"a_27"] forState:UIControlStateSelected];
    //    self.leftTure.userInteractionEnabled=YES;
    [headImg addSubview:self.rightTure];
    [self.rightTure addTarget:self action:@selector(rightTure:) forControlEvents:UIControlEventTouchUpInside];
    self.rightTure.sd_layout.rightSpaceToView(headImg,150*WidthScale).topSpaceToView(headImg,40*WidthScale).heightIs(40*WidthScale).widthIs(40*WidthScale);
    
    self.rightName=[[UILabel alloc]init];
    self.rightName.frame=CGRectMake(ScreenWidth-140*WidthScale, 46*WidthScale, 50, 30*WidthScale);
    [headImg addSubview:self.rightName];
    self.rightName.text=@"老婆";
    self.rightName.font=[UIFont boldSystemFontOfSize:15];
    self.rightName.textColor=[UIColor whiteColor];
    [self.rightName sizeToFit];
    
    self.rightBirthday=[[UIImageView alloc]init];
    self.rightBirthday.image=[UIImage imageNamed:@"shengritrue"];
    [headImg addSubview:self.rightBirthday];
    self.rightBirthday.sd_layout.leftSpaceToView(self.rightName,8).bottomEqualToView(self.rightName).widthIs(30*WidthScale).heightIs(30*WidthScale);
    self.rightEngagement=[[UIImageView alloc]init];
    self.rightEngagement.image=[UIImage imageNamed:@"yuehui"];
    [headImg addSubview:self.rightEngagement];
    self.rightEngagement.sd_layout.leftSpaceToView(self.rightBirthday,5).bottomEqualToView(self.rightName).widthIs(30*WidthScale).heightIs(30*WidthScale);
    
    self.rightbirthdayTimer=[[UILabel alloc]init];
    [headImg addSubview:self.rightbirthdayTimer];
    self.rightbirthdayTimer.sd_layout.leftEqualToView(self.rightName).topSpaceToView(self.rightName,26*WidthScale).widthIs(90).heightIs(14);
    int rightbirthday=[self future:@"20160815000000"];
    rightBirdayMore=rightbirthday-now;
    rightBirthdayTimer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(rightBirthdaydaojishi) userInfo:nil repeats:YES];
    
    self.rightmemorialDayTimer=[[UILabel alloc]init];
    [headImg addSubview:self.rightmemorialDayTimer];
    self.rightmemorialDayTimer.sd_layout.leftEqualToView(self.rightName).bottomEqualToView(rightImage).widthIs(135).heightIs(14);
    int rightmemorialDay=[self future:@"20160821000000"];
    rightMemorialDayMore=rightmemorialDay-now;
    rightMemorialDayTimer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(rightMemorialDaydaojishi) userInfo:nil repeats:YES];
}
-(void)leftTure:(UIButton *)sender{
    sender.selected=!sender.selected;
    NSLog(@"sssss");
}
-(void)rightTure:(UIButton *)sender{
    sender.selected=!sender.selected;
    NSLog(@"sssss");
}
-(void)leftBirthdaydaojishi{
    leftBirdayMore--;
    int day=leftBirdayMore/(60*60*24);
    int dayddd=leftBirdayMore%(60*60*24);
    NSString *daystr=[NSString stringWithFormat:@"%d",day];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天后生日",daystr]];
    //%d
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(255, 145, 0) range:NSMakeRange(0,daystr.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(0,daystr.length)];
    //天后生日
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(153, 153, 153) range:NSMakeRange(daystr.length,4)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(daystr.length,4)];
    self.leftbirthdayTimer.attributedText=str1;
    if (day==0) {
        if (dayddd!=0) {
            self.leftbirthdayTimer.text=@"明天生日";
        }else{
            
            self.leftbirthdayTimer.text=@"今天生日";
        }
        self.leftbirthdayTimer.font=[UIFont systemFontOfSize:13];
        self.leftbirthdayTimer.textColor=Color(153, 153, 153);
    }
    if (day<0) {
        self.leftbirthdayTimer.text=@"生日已过";
        self.leftbirthdayTimer.font=[UIFont systemFontOfSize:13];
        self.leftbirthdayTimer.textColor=Color(153, 153, 153);
    }
    
}
-(void)leftMemorialDaydaojishi{
    leftMemorialDayMore--;
    int day=leftMemorialDayMore/(60*60*24);
    int dayddd=leftMemorialDayMore%(60*60*24);
    NSString *daystr=[NSString stringWithFormat:@"%d",day];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天后离休周年纪念日",daystr]];
    //%d
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(255, 145, 0) range:NSMakeRange(0,daystr.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(0,daystr.length)];
    //天后离休周年纪念日
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(153, 153, 153) range:NSMakeRange(daystr.length,9)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(daystr.length,9)];
    self.leftmemorialDayTimer.attributedText=str1;
    if (day==0) {
        if (dayddd!=0) {
            self.leftmemorialDayTimer.text=@"明天离休周年纪念日";
        }else{
            
            self.leftmemorialDayTimer.text=@"今天离休周年纪念日";
        }
        self.leftmemorialDayTimer.font=[UIFont systemFontOfSize:13];
        self.leftmemorialDayTimer.textColor=Color(153, 153, 153);
    }
    if (day<0) {
        self.leftmemorialDayTimer.text=@"离休周年纪念日已过";
        self.leftmemorialDayTimer.font=[UIFont systemFontOfSize:13];
        self.leftmemorialDayTimer.textColor=Color(153, 153, 153);
    }

}
-(void)rightBirthdaydaojishi{
    rightBirdayMore--;
    int day=rightBirdayMore/(60*60*24);
    int dayddd=rightBirdayMore%(60*60*24);
    NSString *daystr=[NSString stringWithFormat:@"%d",day];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天后生日",daystr]];
    //%d
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(255, 145, 0) range:NSMakeRange(0,daystr.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(0,daystr.length)];
    //天后生日
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(153, 153, 153) range:NSMakeRange(daystr.length,4)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(daystr.length,4)];
    self.rightbirthdayTimer.attributedText=str1;
    if (day==0) {
        if (dayddd!=0) {
            self.rightbirthdayTimer.text=@"明天生日";
        }else{
            
            self.rightbirthdayTimer.text=@"今天生日";
        }
        self.rightbirthdayTimer.font=[UIFont systemFontOfSize:13];
        self.rightbirthdayTimer.textColor=Color(153, 153, 153);
    }
    if (day<0) {
        self.rightbirthdayTimer.text=@"生日已过";
        self.rightbirthdayTimer.font=[UIFont systemFontOfSize:13];
        self.rightbirthdayTimer.textColor=Color(153, 153, 153);
    }
    
}
-(void)rightMemorialDaydaojishi{
    rightMemorialDayMore--;
    int day=rightMemorialDayMore/(60*60*24);
    int dayddd=rightMemorialDayMore%(60*60*24);
    NSString *daystr=[NSString stringWithFormat:@"%d",day];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天后结婚纪念日",daystr]];
    //%d
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(255, 145, 0) range:NSMakeRange(0,daystr.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(0,daystr.length)];
    //天后结婚纪念日
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(153, 153, 153) range:NSMakeRange(daystr.length,7)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(daystr.length,7)];
    self.rightmemorialDayTimer.attributedText=str1;
    if (day==0) {
        if (dayddd!=0) {
            self.rightmemorialDayTimer.text=@"明天结婚纪念日";
        }else{
            
            self.rightmemorialDayTimer.text=@"今天结婚纪念日";
        }
        self.rightmemorialDayTimer.font=[UIFont systemFontOfSize:13];
        self.rightmemorialDayTimer.textColor=Color(153, 153, 153);
    }
    if (day<0) {
        self.rightmemorialDayTimer.text=@"结婚纪念日已过";
        self.rightmemorialDayTimer.font=[UIFont systemFontOfSize:13];
        self.rightmemorialDayTimer.textColor=Color(153, 153, 153);
    }
    
}

#pragma mark---中秋倒计时---
-(void)zhongqiuTimer{
    jieri=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headImg.frame)+10, ScreenWidth, 80*WidthScale)];
    jieri.backgroundColor=[UIColor whiteColor];
    [backScroll addSubview:jieri];
    ZQLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80*WidthScale)];
    ZQLabel.textAlignment=NSTextAlignmentCenter;
    [jieri addSubview:ZQLabel];
    
    
    zhongqiujie=[self future:@"20160915000000"];
    more=zhongqiujie-now;
    myTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(start) userInfo:nil repeats:YES];
    
}
-(void)start{
    more--;
    
    int day=more/(60*60*24);
    NSString *daystr=[NSString stringWithFormat:@"%d",day];
//    NSLog(@"相隔%d天",day);
    int daySY=((int)more)%(60*60*24);
    
    int h=daySY/(60*60);
    NSString *hstr=[NSString stringWithFormat:@"%d",h];
//    NSLog(@"相隔%d小时",h);
    int remaintimeInterval = ((int)daySY)%(60*60);
    
    int s = remaintimeInterval/60;
    NSString *sstr=[NSString stringWithFormat:@"%d",s];
//    NSLog(@"相隔%d分",s);
    
    int m = remaintimeInterval%60;
    NSString *mstr=[NSString stringWithFormat:@"%d",m];
//    NSLog(@"相隔%d秒",m );
    
//    NSLog(@"剩余%d天%d小时%d分%d秒",day,h,s,m );
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"距中秋节还有%@天%@小时%@分%@秒",daystr,hstr,sstr,mstr]];
    //距离中秋节
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(118, 119, 120) range:NSMakeRange(0,6)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,6)];
    //%d
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(255, 145, 0) range:NSMakeRange(6,daystr.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(6,daystr.length)];
    //天
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(118, 119, 120) range:NSMakeRange(6+daystr.length,1)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(6+daystr.length,1)];
    //%d
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(255, 145, 0) range:NSMakeRange(6+daystr.length+1,hstr.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(6+daystr.length+1,hstr.length)];
    //小时
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(118, 119, 120) range:NSMakeRange(6+daystr.length+1+hstr.length,2)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(6+daystr.length+1+hstr.length,2)];
    //%d
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(255, 145, 0) range:NSMakeRange(6+daystr.length+1+hstr.length+2,sstr.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(6+daystr.length+1+hstr.length+2,sstr.length)];
    //分
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(118, 119, 120) range:NSMakeRange(6+daystr.length+1+hstr.length+2+sstr.length,1)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(6+daystr.length+1+hstr.length+2+sstr.length,1)];
    //%d
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(255, 145, 0) range:NSMakeRange(6+daystr.length+1+hstr.length+2+sstr.length+1,mstr.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(6+daystr.length+1+hstr.length+2+sstr.length+1,mstr.length)];
    //秒
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(118, 119, 120) range:NSMakeRange(6+daystr.length+1+hstr.length+2+sstr.length+1+mstr.length,1)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(6+daystr.length+1+hstr.length+2+sstr.length+1+mstr.length,1)];
    
    ZQLabel.attributedText=str1;
    
    if (day==0&&h==0&&s==0&&m==0) {
        [myTimer setFireDate:[NSDate distantFuture]];
    }
}
-(void)address{
    


    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(jieri.frame), UIBounds.size.width, [_newCityDic allKeys].count*20+_oldCityList.count*53+64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled=NO;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [backScroll addSubview:_tableView];
//    _tableView.rowHeight = 148*WidthScale;
}


#pragma mark-排序城市
- (void)prepareCityListDatasourceWithArray:(NSArray *)array andToDictionary:(NSMutableDictionary *)dic
{
    for (NSString *city in array) {
        
        NSString *cityPinyin = [ChineseToPinyin pinyinFromChiniseString:city];
        
        NSString *firstLetter = [cityPinyin substringWithRange:NSMakeRange(0, 1)];
        
        if (![dic objectForKey:firstLetter]) {
            NSMutableArray *arr = [NSMutableArray array];
            [dic setObject:arr forKey:firstLetter];
            
        }
        if ([[dic objectForKey:firstLetter] containsObject:city]) {
            return;
        }
        [[dic objectForKey:firstLetter]addObject:city];
    }
    
    [_allKeysArray addObjectsFromArray:[[dic allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    [_tableView reloadData];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 148*WidthScale;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[_newCityDic allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *cityArray = [_newCityDic objectForKey:[_allKeysArray objectAtIndex:section]];
    return cityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConnectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    if (!cell) {
        
        cell = [[ConnectionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityCell"];
    }
    
    NSArray *cityArray = [_newCityDic objectForKey:[_allKeysArray objectAtIndex:indexPath.section]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userHeader.image=[UIImage imageNamed:@"laopo"];
    cell.userName.text=[cityArray objectAtIndex:indexPath.row];
    [cell.userName sizeToFit];
    
    NSString *jieristr1=@"20";
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"距离她的生日还有%@天",jieristr1]];
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(118, 119, 120) range:NSMakeRange(0,8)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0,8)];
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(255, 145, 0) range:NSMakeRange(8,jieristr1.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(8,jieristr1.length)];
    [str1 addAttribute:NSForegroundColorAttributeName value:Color(118, 119, 120) range:NSMakeRange(8+jieristr1.length,1)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(8+jieristr1.length,1)];
    cell.jieri1.attributedText=str1;
    [cell.jieri1 sizeToFit];
    NSString *jieristr2=@"40";
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"距离你们的结婚纪念日还有%@天",jieristr2]];
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(118, 119, 120) range:NSMakeRange(0,12)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0,12)];
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(255, 145, 0) range:NSMakeRange(12,jieristr1.length)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(12,jieristr1.length)];
    [str2 addAttribute:NSForegroundColorAttributeName value:Color(118, 119, 120) range:NSMakeRange(12+jieristr1.length,1)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(12+jieristr1.length,1)];
    cell.jieri2.attributedText=str2;
    [cell.jieri2 sizeToFit];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(10, 146*WidthScale, ScreenWidth-20, 1)];
    line.backgroundColor=Color(238, 238, 238);
    [cell.contentView addSubview:line];
    if (indexPath.row==cityArray.count-1) {
        line.backgroundColor=[UIColor whiteColor];
    }
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (_allKeysArray.count>0) {
        
        HeaderView *headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 20)];
        [headerView setTitleString:[_allKeysArray objectAtIndex:section]];
        
        return headerView;
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (_allKeysArray.count>0) {
        return 20;
    }
    
    return 0;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    
//    if (_allKeysArray.count>0) {
//        
//        return _allKeysArray;
//    }
//    return nil;
//}

-(void)addItemClick{
    addPersonViewController *add=[[addPersonViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}

-(int)future:(NSString *)future{
//    NSString *timeStr = @"20160915000000";
    NSString *timeStr = future;
    NSDateFormatter *formatterzq = [[NSDateFormatter alloc] init];	[formatterzq setDateFormat:@"YYYYMMddHHmmss"]; // 设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSDate *zhongqiu  = [formatterzq dateFromString:timeStr]; //将字符串按formatter转成nsdate
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[zhongqiu timeIntervalSince1970]];
    int thefuture=[timeSp intValue];
    NSLog(@"中秋节%@",timeSp);
    return thefuture;
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
