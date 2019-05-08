//
//  ALPinYinSortViewController.m
//  ALPinYinSort
//
//  Created by admin on 2019/5/7.
//  Copyright © 2019年 AL. All rights reserved.
//

#import "ALPinYinSortViewController.h"
#import "ALPinYinSortSectionView.h"
@implementation ALPinYinSortModel

@end
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ALPinYinSortViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSMutableArray *dataArr;/**<  分类后的数组*/
@property (nonatomic , strong)NSMutableArray *letterArr;/**<  字母数组*/
@property (nonatomic , strong)ALPinYinSortSectionView *sortSectionView;
@end

@implementation ALPinYinSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[self tableView]];
    [self dataInit];
#warning 两种方式显示右侧字母栏 1：84行代码显示自定义View 2：118-122打开系统方式
    // Do any additional setup after loading the view.
}
#pragma mark dataInit
- (void)dataInit{
    _dataArr = [NSMutableArray array];
    _letterArr = [NSMutableArray array];
    _letterArr = [[[UILocalizedIndexedCollation currentCollation] sectionTitles] mutableCopy];
    NSArray *nameArr = @[
                 @{@"name":@"李二狗",@"nameId":@"1"},
                 @{@"name":@"王麻子",@"nameId":@"2"},
                 @{@"name":@"刘能",@"nameId":@"3"},
                 @{@"name":@"赵四",@"nameId":@"4"},
                 @{@"name":@"快乐亚索",@"nameId":@"5"},
                 @{@"name":@"张三",@"nameId":@"6"},
                 @{@"name":@"奈德.史塔克",@"nameId":@"7"},
                 @{@"name":@"绿巨人",@"nameId":@"8"},
                 @{@"name":@"惊奇队长",@"nameId":@"9"},
                 @{@"name":@"火男",@"nameId":@"10"},
                 @{@"name":@"妮蔻",@"nameId":@"11"},
                 @{@"name":@"龙龟",@"nameId":@"12"},
                 @{@"name":@"寒冰",@"nameId":@"13"},
                 @{@"name":@"赵信",@"nameId":@"14"},
                 @{@"name":@"蛮子",@"nameId":@"15"},
                 @{@"name":@"德玛西亚皇子",@"nameId":@"16"},
                 @{@"name":@"EZ",@"nameId":@"17"},
                 @{@"name":@"@小老鼠",@"nameId":@"18"},
                 @{@"name":@"维恩",@"nameId":@"19"},
                 @{@"name":@"卡莎",@"nameId":@"20"},
                 @{@"name":@"炮娘",@"nameId":@"21"},
                 @{@"name":@"莫甘娜",@"nameId":@"22"}];
    
    NSMutableArray *sortArr = [NSMutableArray array];
    
    for (NSDictionary *dict in nameArr) {
         ALPinYinSortModel *model = [[ALPinYinSortModel alloc]init];
        model.name = dict[@"name"];
        model.nameId = dict[@"nameId"];
        [sortArr addObject:model];
    }
    ALPinYinSortModel *model = [[ALPinYinSortModel alloc]init];
    sortArr = [[self returnLLocalizedIndexedCollationArray:sortArr someObject:model andaction:@selector(name)] mutableCopy];
    NSMutableArray *deleteArray = [NSMutableArray array];
    NSInteger num = 0;
    for (NSMutableArray*array in sortArr) {
        if (array.count>0) {
            [_dataArr addObject:array];
        }else{
            [deleteArray addObject:[_letterArr objectAtIndex:num]];
        }
        num++;
    }
    [_letterArr removeObjectsInArray:deleteArray];
   
    [self.view addSubview:[self sortSectionView]];
    [_tableView reloadData];

}
#pragma mark 网络请求

#pragma mark 创建UI
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
- (ALPinYinSortSectionView *)sortSectionView{
    if (!_sortSectionView) {
        __weak typeof(self)weakSelf = self;
        _sortSectionView = [[ALPinYinSortSectionView alloc]initWithFrame:CGRectMake(ScreenWidth-30, 180, 30, ScreenHeight-360) titleArr:_letterArr selectedBlock:^(NSInteger selectedIndex) {
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:selectedIndex] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }];
    }
    return _sortSectionView;
}
#pragma mark 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if ([_dataArr[section] count]>0) {
        return 25;
    }
    return 0;
}
//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//
//    return _letterArr;
//
//}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if ([[_dataArr objectAtIndex:section] count]>0) {
        return [_letterArr objectAtIndex:section];
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArr[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NomralCell"];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NomralCell"];
    }

    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    ALPinYinSortModel *model = _dataArr[indexPath.section][indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}
#pragma mark 点击事件

//对一个数组 进行首字母的分类
//personArry  是对象的数组 你要分类的数据   someObject 数组里面的对象类型  action 对象进行分类的属性
-(NSArray*)returnLLocalizedIndexedCollationArray:(NSArray*)personArray someObject:(id)someObject andaction:(SEL)action{
    
    UILocalizedIndexedCollation *collation =[UILocalizedIndexedCollation currentCollation];
    //得出collation索引的数量，这里是27个（26个字母和1个#）
    
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
    
    //初始化一个数组newSectionsArray用来存放最终的数据，我们最终要得到的数据模型应该形如@[@[以A开头的数据数组], @[以B开头的数据数组], @[以C开头的数据数组], ... @[以#(其它)开头的数据数组]]
    
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    //初始化27个空数组加入newSectionsArray
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    
    //将每个人按name分到某个section下
    for (someObject  in personArray) {
        //         　　获取name属性的值所在的位置，比如"林丹"，首字母是L，在A~Z中排第11（第一位是0），sectionNumber就为11
        NSInteger sectionNumber = [collation sectionForObject:someObject collationStringSelector:action];
        //         　　把name为“林丹”的p加入newSectionsArray中的第11个数组中去
        NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
        [sectionNames addObject:someObject];
    }
    
    //对每个section中的数组按照name属性排序
    for (int index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *personArrayForSection = newSectionsArray[index];
        NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:action];
        
        newSectionsArray[index] = [sortedPersonArrayForSection mutableCopy];
    }
    return newSectionsArray;
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
