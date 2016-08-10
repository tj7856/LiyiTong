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

@interface ConnectionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *backScroll;
    UIImageView *headImg;
    UIView *jieri;
    UITableView                 *_tableView;
    NSArray                     *_oldCityList;
    NSMutableDictionary         *_newCityDic;
    NSMutableArray              *_allKeysArray;
}
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
    
    
    backScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backScroll.contentSize=CGSizeMake(0, 338*WidthScale+10+80*WidthScale+[_newCityDic allKeys].count*20+_oldCityList.count*53+64);
    backScroll.backgroundColor=Color(238, 238, 238);
    backScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:backScroll];
    [self headView];
    [self zhongqiuTimer];
    [self address];
}
-(void)headView{
    headImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 6, ScreenWidth, 338*WidthScale)];
    headImg.image=[UIImage imageNamed:@"人脉-节日提醒_02"];
    [backScroll addSubview:headImg];
    
    UIImageView *leftImage=[[UIImageView alloc]init];
    leftImage.image=[UIImage imageNamed:@"laopo"];
    leftImage.layer.borderWidth=1;
    leftImage.layer.borderColor=[UIColor whiteColor].CGColor;
    leftImage.layer.cornerRadius=70*WidthScale;
    leftImage.clipsToBounds=YES;
    [headImg addSubview:leftImage];
    leftImage.sd_layout.leftSpaceToView(headImg,26*WidthScale).topSpaceToView(headImg,40*WidthScale).heightIs(140*WidthScale).widthIs(140*WidthScale);
    
    UIImageView *rightImage=[[UIImageView alloc]init];
    rightImage.image=[UIImage imageNamed:@"laopo"];
    rightImage.layer.borderWidth=1;
    rightImage.layer.borderColor=[UIColor whiteColor].CGColor;
    rightImage.layer.cornerRadius=70*WidthScale;
    rightImage.clipsToBounds=YES;
    [headImg addSubview:rightImage];
    rightImage.sd_layout.rightSpaceToView(headImg,26*WidthScale).topSpaceToView(headImg,40*WidthScale).heightIs(140*WidthScale).widthIs(140*WidthScale);
    
    
}
-(void)zhongqiuTimer{
    jieri=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headImg.frame)+10, ScreenWidth, 80*WidthScale)];
    jieri.backgroundColor=[UIColor whiteColor];
    [backScroll addSubview:jieri];
    
}
-(void)address{
    


    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(jieri.frame), UIBounds.size.width, [_newCityDic allKeys].count*20+_oldCityList.count*53+64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled=NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [backScroll addSubview:_tableView];
    _tableView.rowHeight = 53;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityCell"];
    }
    
    NSArray *cityArray = [_newCityDic objectForKey:[_allKeysArray objectAtIndex:indexPath.section]];
    
    cell.textLabel.text = [cityArray objectAtIndex:indexPath.row];
    
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
