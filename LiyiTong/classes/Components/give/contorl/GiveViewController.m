//
//  GiveViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/7/27.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "GiveViewController.h"
#import "TOPTableViewCell.h"
#import "TOPModel.h"
@interface GiveViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataList;
    NSMutableArray *modelList;
}
@end

@implementation GiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor cyanColor];
    
    
    dataList=@[
                @{@"title":@"五粮液黄金酒黄金贵宾酒",@"hotIndex":@(3.5),@"reason":@"本网站不向未成年人售酒！适度饮酒，为了您和您的家人请您不要酒后驾车!",@"image":@"URL",@"price":@"128",@"personNum":@"58"}
               ,@{@"title":@"五粮液黄金酒黄金贵宾酒",@"hotIndex":@(3.5),@"reason":@"本网站不向未成年人售酒！适度饮酒，为了您和您的家人请您不要酒后驾车!",@"image":@"URL",@"price":@"128",@"personNum":@"58"}
               ,@{@"title":@"五粮液黄金酒黄金贵宾酒",@"hotIndex":@(3.5),@"reason":@"本网站不向未成年人售酒！适度饮酒，为了您和您的家人请您不要酒后驾车!",@"image":@"URL",@"price":@"128",@"personNum":@"58"}
               ,@{@"title":@"五粮液黄金酒黄金贵宾酒",@"hotIndex":@(3.5),@"reason":@"本网站不向未成年人售酒！适度饮酒，为了您和您的家人请您不要酒后驾车!",@"image":@"URL",@"price":@"128",@"personNum":@"58"}
               ,@{@"title":@"五粮液黄金酒黄金贵宾酒",@"hotIndex":@(3.5),@"reason":@"本网站不向未成年人售酒！适度饮酒，为了您和您的家人请您不要酒后驾车!",@"image":@"URL",@"price":@"128",@"personNum":@"58"}
               ,@{@"title":@"五粮液黄金酒黄金贵宾酒",@"hotIndex":@(3.5),@"reason":@"本网站不向未成年人售酒！适度饮酒，为了您和您的家人请您不要酒后驾车!",@"image":@"URL",@"price":@"128",@"personNum":@"58"}
                ,@{@"title":@"五粮液黄金酒黄金贵宾酒",@"hotIndex":@(3.5),@"reason":@"本网站不向未成年人售酒！适度饮酒，为了您和您的家人请您不要酒后驾车!",@"image":@"URL",@"price":@"128",@"personNum":@"58"}
                ,@{@"title":@"五粮液黄金酒黄金贵宾酒",@"hotIndex":@(3.5),@"reason":@"本网站不向未成年人售酒！适度饮酒，为了您和您的家人请您不要酒后驾车!",@"image":@"URL",@"price":@"128",@"personNum":@"58"}
                ,@{@"title":@"五粮液黄金酒黄金贵宾酒",@"hotIndex":@(3.5),@"reason":@"本网站不向未成年人售酒！适度饮酒，为了您和您的家人请您不要酒后驾车!",@"image":@"URL",@"price":@"128",@"personNum":@"58"}
                ,@{@"title":@"五粮液黄金酒黄金贵宾酒",@"hotIndex":@(3.5),@"reason":@"本网站不向未成年人售酒！适度饮酒，为了您和您的家人请您不要酒后驾车!",@"image":@"URL",@"price":@"128",@"personNum":@"58"}
                ];
    modelList=[NSMutableArray array];
    for (NSDictionary *dic in dataList) {
        [modelList addObject:[TOPModel modelWithDic:dic]];
    }
    NSLog(@"mmmmm%lu %@",dataList.count,modelList[3]);
    
    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    scrollview.backgroundColor=Color(238, 238, 238);
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.contentSize=CGSizeMake(0, (12+730*10)*WidthScale+64);
    self.view=scrollview;
    
    UITableView *tabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 12*WidthScale, ScreenWidth, 730*10*WidthScale) style:UITableViewStylePlain];
    tabview.backgroundColor=Color(238, 238, 238);
    tabview.scrollEnabled=NO;
    
    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tabview.tableHeaderView=[self addHeaderView];
    [scrollview addSubview:tabview];
    tabview.delegate=self;
    tabview.dataSource=self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 730*WidthScale;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    TOPTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[TOPTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    TOPModel *model=modelList[indexPath.row];
    cell.TopNum.text=[NSString stringWithFormat:@"NO.%ld",(long)indexPath.row+1];
    cell.view1Title.text=model.view1Title;
    cell.hotIndex=model.hotIndex;
    cell.reason.text=model.reason;
    cell.imageview.image=[UIImage imageNamed:@"热门psd_11"];
    cell.price.text=model.price;
    cell.personNum.text=[NSString stringWithFormat:@"%@人已送",model.personNum];
    return cell;
}
//点击选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"TOP%ld",(long)indexPath.row);
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
