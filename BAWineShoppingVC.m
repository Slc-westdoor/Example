//
//  BAWineShoppingVC.m
//  酒吧助手
//
//  Created by 叶星龙 on 15/5/22.
//  Copyright (c) 2015年 北京局外者科技有限公司. All rights reserved.
//

#import "BAWineShoppingVC.h"
#import "BAWineShoppingDockTavleView.h"
#import "BARightTableView.h"
#import "BADockCell.h"
#import "Header.h"
#import "BALabel.h"
#import "Tool.h"
#import "EFAnimationViewController.h"
#import "UMMobClick/MobClick.h"
@interface BAWineShoppingVC ()<DockTavleViewDelegate,RightTableViewDelegate>{
    NSInteger TotalPrice;
}

@property (nonatomic ,strong) BAWineShoppingDockTavleView *dockTavleView;

@property (nonatomic ,strong) BARightTableView *rightTableView;

@property (nonatomic ,strong) NSMutableArray *dockArray;

@property (nonatomic ,strong) NSMutableArray *offsArray;

@property (nonatomic ,weak) UILabel *totalPrice;

@property (nonatomic ,weak) BALabel *bottomLabel;

@property (nonatomic ,assign) NSInteger quantityInt;

@property (nonatomic ,strong) NSMutableDictionary *dic;

@property (nonatomic ,strong) NSMutableArray *key;

@property (nonatomic ,weak) UILabel *totalSingular;

@property (nonatomic ,weak) UIImageView *cartImage;

@end

@implementation BAWineShoppingVC
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden=YES;
    [MobClick beginLogPageView:@"SixPage"];//("PageOne"为页面名称，可自定义)
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [MobClick endLogPageView:@"SixPage"];
}

-(void)initNavigationItems
{
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44+20)];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"sp_unfold_red"] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:navigationBar];
    
    [navigationBar pushNavigationItem:[Tool addNavigationItemLeft:@"me2" Title:@"酒水超市" bartitle:nil color:[UIColor whiteColor] barcolor:[UIColor whiteColor] target:self action:@selector(ClickedLeftAcation)]animated:NO];
    
    [self.tabBarController.tabBar setHidden:NO];
    
}

-(void)ClickedLeftAcation{
    [self dismissViewControllerAnimated:YES completion:nil];
    EFAnimationViewController * efVC = [[EFAnimationViewController alloc]init];
    [self presentViewController:efVC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItems];
    
    BAWineShoppingDockTavleView *dockTavleView =[[BAWineShoppingDockTavleView alloc]initWithFrame:(CGRect){0,64,75,kWindowHeight-50}];
    dockTavleView.rowHeight=50;
    dockTavleView.dockDelegate=self;
    dockTavleView.backgroundColor=UIColorRGBA(238, 238, 238, 1);
    [dockTavleView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:dockTavleView];
    _dockTavleView =dockTavleView;
    
    BARightTableView *rightTableView =[[BARightTableView alloc]initWithFrame:(CGRect){75,64,kWindowWidth-75,kWindowHeight-50}];
    rightTableView.rowHeight=90;
    rightTableView.rightDelegate=self;
    rightTableView.backgroundColor=UIColorRGBA(238, 238, 238, 1);
    [rightTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:rightTableView];
    _rightTableView=rightTableView;
    
    
    _dockArray =[NSMutableArray array];
    for ( int i=0; i<7; i++) {
        if (i==0) {
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            
            NSMutableArray *array =[NSMutableArray array];
            
            
            
            for (int i=0; i<7; i++) {
                if (i==0) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"1.jpg",@"name":@"德国OETTINGER奥丁格大麦啤酒500ml*4罐/组",@"money":@"39",@"OriginalPrice":@"56",@"Quantity":@"0",@"ProductID":@"q",@"Discount":@"7折"} mutableCopy];
                    [array addObject:dic1];
                }
                if (i==1) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"2.jpg",@"name":@"德拉克（Durlacher） 黑啤酒 330ml*6听",@"money":@"40",@"OriginalPrice":@"67",@"Quantity":@"0",@"ProductID":@"w",@"Discount":@"6折"} mutableCopy];
                    [array addObject:dic1];
                }
                if (i==2) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"3.jpg",@"name":@"奥塔利金爵 啤酒500ml*12 匈牙利原装低度进口啤酒酒水饮品",@"money":@"109",@"OriginalPrice":@"218",@"Quantity":@"0",@"ProductID":@"e",@"Discount":@"5折"} mutableCopy];
                    [array addObject:dic1];
                }
                if (i==3) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"4.jpg",@"name":@"德国啤酒 原装进口啤酒 flensburger/弗伦斯堡啤酒 土豪金啤 5L 桶装啤酒",@"money":@"158",@"OriginalPrice":@"226",@"Quantity":@"0",@"ProductID":@"r",@"Discount":@"7折"} mutableCopy];
                    [array addObject:dic1];
                }
                if (i==4) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"5.jpg",@"name":@"青岛啤酒 经典 醇厚 啤酒500ml*12听/箱 国产 整箱",@"money":@"66",@"OriginalPrice":@"110",@"Quantity":@"0",@"ProductID":@"t",@"Discount":@"6折"} mutableCopy];
                    [array addObject:dic1];
                }
                if (i==5) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"6.jpg",@"name":@"京姿 百威罐装330ml*24 啤酒",@"money":@"140",@"OriginalPrice":@"200",@"Quantity":@"0",@"ProductID":@"y",@"Discount":@"7折"} mutableCopy];
                    [array addObject:dic1];
                }
                if (i==6) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"7.jpg",@"name":@"德国OETTINGER奥丁格自然浑浊型小麦啤酒500ml*4罐/组",@"money":@"58",@"OriginalPrice":@"129",@"Quantity":@"0",@"ProductID":@"u",@"Discount":@"4.5折"} mutableCopy];
                    [array addObject:dic1];
                }
                
                
            }
            dic =[@{@"dockName":@"啤酒",@"right":array} mutableCopy];
            [_dockArray addObject:dic];
            
        }
        if (i==1) {
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            
            NSMutableArray *array =[NSMutableArray array];
            
            
            
            for (int i=0; i<8; i++) {
                if (i==0) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"8.jpg",@"name":@"Martell马爹利名士1000ML 进口洋酒 名仕干邑白兰地1L",@"money":@"695",@"Quantity":@"0",@"ProductID":@"a"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==1) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"9.jpg",@"name":@"奥美加银龙舌兰【OLMECA TEQUILA】38% 750ml",@"money":@"108",@"Quantity":@"0",@"ProductID":@"s"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==2) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"10.jpg",@"name":@"人头马天醇XO特优香槟干邑白兰地700ml",@"money":@"1386",@"Quantity":@"0",@"ProductID":@"d"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==3) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"11.jpg",@"name":@"40°法国马爹利蓝带干邑白兰地700ml",@"money":@"1080",@"Quantity":@"0",@"ProductID":@"f"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==4) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"12.jpg",@"name":@"沙皇伏特加塞珞700ml限量版",@"money":@"598",@"Quantity":@"0",@"ProductID":@"g"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==5) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"13.jpg",@"name":@"百加得黑朗姆酒 烈酒 750ml",@"money":@"92",@"Quantity":@"0",@"ProductID":@"h"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==6) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"14.jpg",@"name":@"Seagrams Gin 750ML 40度",@"money":@"99",@"Quantity":@"0",@"ProductID":@"j"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==7) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"15.jpg",@"name":@"马爹利蓝带干邑白兰地 700ml",@"money":@"1060",@"Quantity":@"0",@"ProductID":@"k"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                
                
            }
            dic =[@{@"dockName":@"洋酒",@"right":array} mutableCopy];
            [_dockArray addObject:dic];
           
        }
        if (i==2) {
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            
            NSMutableArray *array =[NSMutableArray array];
            
            
            
            for (int i=0; i<8; i++) {
                if (i==0) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"16.jpg",@"name":@"张裕解百纳干红葡萄酒双支礼盒 750ml*2",@"money":@"158",@"Quantity":@"0",@"ProductID":@"z"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==1) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"17.jpg",@"name":@"爱之湾+兰贵人组合",@"money":@"1230",@"Quantity":@"0",@"ProductID":@"x"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==2) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"18.jpg",@"name":@"菲卡珍藏莎当妮葡萄酒750ml",@"money":@"138",@"Quantity":@"0",@"ProductID":@"c"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==3) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"19.jpg",@"name":@"拉图嘉利庄园干红葡萄酒",@"money":@"1580",@"Quantity":@"0",@"ProductID":@"v"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==4) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"20.jpg",@"name":@"报恩城堡干红葡萄酒 六支装",@"money":@"1890",@"Quantity":@"0",@"ProductID":@"b"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==5) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"21.jpg",@"name":@"豪克玛歌庄园干红葡萄酒 750ml 1支装",@"money":@"2360",@"Quantity":@"0",@"ProductID":@"h"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==6) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"22.jpg",@"name":@"白浪莎庄园干红葡萄酒 750ml",@"money":@"98",@"Quantity":@"0",@"ProductID":@"n"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==7) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"23.jpg",@"name":@"布兰多庄园干红葡萄酒 750ml 1支装",@"money":@"3690",@"Quantity":@"0",@"ProductID":@"m"} mutableCopy];
                    [array addObject:dic1]; ;
                }

              
            }
            dic =[@{@"dockName":@"红酒",@"right":array} mutableCopy];
            [_dockArray addObject:dic];
           
        }
        if (i==3) {
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            
            NSMutableArray *array =[NSMutableArray array];
            
            for (int i=0; i<8; i++) {
                if (i==0) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"24.jpg",@"name":@"白俄罗斯鸡尾酒",@"money":@"238",@"Quantity":@"0",@"ProductID":@"z"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==1) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"25.jpg",@"name":@"莫吉托",@"money":@"233",@"Quantity":@"0",@"ProductID":@"x"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==2) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"26.jpg",@"name":@"绝对柚惑",@"money":@"115",@"Quantity":@"0",@"ProductID":@"c"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==3) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"27.jpg",@"name":@"马蒂尼里",@"money":@"1580",@"Quantity":@"0",@"ProductID":@"v"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==4) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"28.jpg",@"name":@"绝对甜蜜",@"money":@"138",@"Quantity":@"0",@"ProductID":@"b"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==5) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"29.jpg",@"name":@"精致女士",@"money":@"138",@"Quantity":@"0",@"ProductID":@"h"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==6) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"30.jpg",@"name":@"绝对柠檬",@"money":@"138",@"Quantity":@"0",@"ProductID":@"n"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==7) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"31.jpg",@"name":@"绝对野趣",@"money":@"138",@"Quantity":@"0",@"ProductID":@"m"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                
                
            }
            dic =[@{@"dockName":@"特色酒",@"right":array} mutableCopy];
            [_dockArray addObject:dic];
        }
        
        if (i==4) {
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            
            NSMutableArray *array =[NSMutableArray array];
            
            for (int i=0; i<2; i++) {
                if (i==0) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"32.jpg",@"name":@"苹果、火龙果、西瓜、哈密瓜、杨桃（大）",@"money":@"89",@"Quantity":@"0",@"ProductID":@"ww"} mutableCopy];
                    [array addObject:dic1];
                }
                if(i==1)
                {
                NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                dic1=[@{@"image":@"32.jpg",@"name":@"苹果、火龙果、西瓜、哈密瓜、杨桃（小）",@"money":@"89",@"Quantity":@"0",@"ProductID":@"ww"} mutableCopy];
                [array addObject:dic1];
                }
            }
            dic =[@{@"dockName":@"果盘",@"right":array} mutableCopy];
            [_dockArray addObject:dic];
           
        }
        if (i==5) {
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            
            NSMutableArray *array =[NSMutableArray array];
            
            for (int i=0; i<2; i++) {
                if (i==0) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"32.jpg",@"name":@"瓜子（大）",@"money":@"89",@"Quantity":@"0",@"ProductID":@"ww"} mutableCopy];
                    [array addObject:dic1];
                }
                if(i==1)
                {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"32.jpg",@"name":@"瓜子（小）",@"money":@"89",@"Quantity":@"0",@"ProductID":@"ww"} mutableCopy];
                    [array addObject:dic1];
                }
            }
            dic =[@{@"dockName":@"休闲食品",@"right":array} mutableCopy];
            [_dockArray addObject:dic];
           
        }
        if (i==6) {
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            
            NSMutableArray *array =[NSMutableArray array];
            
            for (int i=0; i<2; i++) {
                NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                dic1=[@{@"image":@"32.jpg",@"name":@"大缤纷",@"money":@"56",@"Quantity":@"0",@"ProductID":@"rr"} mutableCopy];
                [array addObject:dic1];
            }
            dic =[@{@"dockName":@"软饮",@"right":array} mutableCopy];
            [_dockArray addObject:dic];
            dockTavleView.dockArray=_dockArray;
            [dockTavleView reloadData];
        
        }
        
      
    }

    _offsArray =[NSMutableArray array];
    for ( int i=0; i<[_dockArray count]; i++) {
        CGPoint point =CGPointMake(0, 0);
        [_offsArray addObject:NSStringFromCGPoint(point)];
    }
    
    UIView *bottomView =[[UIView alloc]initWithFrame:(CGRect){0,kWindowHeight-50,kWindowWidth,50}];
    bottomView.backgroundColor=UIColorRGBA(29, 29, 29, 1);
    [self.view addSubview:bottomView];
    
    BALabel *bottomLabel =[[BALabel alloc]initWithFrame:(CGRect){kWindowWidth-55-10,50/2-24/2,55,24}];
    bottomLabel.text=@"请选购";
    bottomLabel.textColor=[UIColor whiteColor];
    bottomLabel.textAlignment=NSTextAlignmentCenter;
    bottomLabel.font=Font(13);
    bottomLabel.backgroundColor=[UIColor lightGrayColor];
    bottomLabel.layer.masksToBounds=YES;
    bottomLabel.layer.cornerRadius=6;
    bottomLabel.layer.borderWidth = 1;
    bottomLabel.userInteractionEnabled=NO;
    [bottomLabel addTarget:self action:@selector(bottomLabelClick) forControlEvents:BALabelControlEventTap];
    bottomLabel.layer.borderColor = [[UIColor whiteColor] CGColor];
    [bottomView addSubview:bottomLabel];
    _bottomLabel=bottomLabel;
    
    UIImageView *cartImage =[[UIImageView alloc]initWithFrame:(CGRect){10,5,40,40}];
    cartImage.image=[UIImage imageNamed:@"Home_Cart.jpg"];
    [bottomView addSubview:cartImage];
    _cartImage=cartImage;
    _quantityInt=0;
    
    UILabel *totalPrice =[[UILabel alloc]initWithFrame:(CGRect){CGRectGetMaxX(cartImage.frame)+20,50/2-16/2,200,16}];
    
    totalPrice.text=@"￥0";
    totalPrice.textColor=[UIColor whiteColor];
    totalPrice.font=Font(16);
    [bottomView addSubview:totalPrice];
    _totalPrice=totalPrice;
    
    UILabel *totalSingular =[[UILabel alloc]initWithFrame:(CGRect){35,5,15,15}];
    totalSingular.text=@"0";
    totalSingular.hidden=YES;
    totalSingular.layer.masksToBounds=YES;
    totalSingular.layer.cornerRadius=7.5;
    totalSingular.textAlignment=NSTextAlignmentCenter;
    totalSingular.backgroundColor=[UIColor redColor];
    totalSingular.textColor=[UIColor whiteColor];
    totalSingular.font=Font(13);
    [bottomView addSubview:totalSingular];
    _totalSingular=totalSingular;
    
    _dic=[NSMutableDictionary dictionary];
    _key=[NSMutableArray array];

}


-(void)bottomLabelClick
{
    UIViewController *vc =[[UIViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)quantity:(NSInteger)quantity money:(NSInteger)money key:(NSString *)key
{
    NSInteger addend  =quantity *money;
    
    [_dic setObject:[NSString stringWithFormat:@"%ld",addend] forKey:key];
    //得到词典中所有KEY值
    NSEnumerator * enumeratorKey = [_dic keyEnumerator];
    //遍历所有KEY的值
    NSInteger total=0;
    NSInteger totalSingularInt=0;
    for (NSObject *object in enumeratorKey) {
        total+=[_dic[object] integerValue];
        if ([_dic[object] integerValue] !=0) {
            totalSingularInt +=1;
            _totalSingular.hidden=NO;
        }
    }
    if (totalSingularInt==0) {
        _totalSingular.hidden=YES;
        _bottomLabel.backgroundColor=[UIColor lightGrayColor];
        _bottomLabel.userInteractionEnabled=NO;
        _bottomLabel.text=@"请选购";
    }else{
        _bottomLabel.backgroundColor=[UIColor clearColor];
        _bottomLabel.userInteractionEnabled=YES;
        _bottomLabel.text=@"去结算";
        [_bottomLabel addTarget:self action:@selector(clicked) forControlEvents:BALabelControlEventTap];
    }
    _totalSingular.text=[NSString stringWithFormat:@"%ld",totalSingularInt];
    _totalPrice.text=[NSString stringWithFormat:@"￥%ld",total];
    TotalPrice = total;
}

-(void)clicked{
    NSLog(@"共%i种商品,总计价%li元",[_totalSingular.text intValue],(long)TotalPrice);
    
}

-(void)dockClickindexPathRow:(NSMutableArray *)array index:(NSIndexPath *)index indeXPath:(NSIndexPath *)indexPath
{
    NSLog(@"erwerw");
    [_rightTableView setContentOffset:_rightTableView.contentOffset animated:NO];
    _offsArray[index.row] =NSStringFromCGPoint(_rightTableView.contentOffset);
    _rightTableView.rightArray=array;
    [_rightTableView reloadData];
    CGPoint point=CGPointFromString([_offsArray objectAtIndex:indexPath.row]);
    [_rightTableView setContentOffset:point];
//    NSLog(@"%@",row);
}

-(void)cartImageClick
{
    
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com