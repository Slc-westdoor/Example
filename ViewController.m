//
//  ViewController.m
//  MyADDressBook
//
//  Created by Slc on 15/8/28.
//  Copyright (c) 2015年 Slc. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "DetailViewController.h"
#import "FMDatabase.h"

@interface ViewController ()
{
    FMDatabase *db;
    UIImageView * imgview;
}
@end

@implementation ViewController


@synthesize name, email, tel, recordID, sectionNumber,imge;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor grayColor];
    addressBookTemp = [NSMutableArray array];
    self.tableView.frame=CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height-30);
   [self getinfo];
   // [self sourceDB];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sourceDB{
    
    for (int i = 0; i<4; i++) {
        UIButton *bt =[[UIButton alloc]initWithFrame:CGRectMake(30, 70 + 53*i, 80, 50)];
        bt.tag = i;
        [self.view addSubview:bt];
        if (bt.tag == 0) {
            [bt setTitle:@"insert" forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(insert:) forControlEvents:UIControlEventTouchUpInside];
        }else if(bt.tag == 1){
            [bt setTitle:@"delete" forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        }else if(bt.tag == 2){
            [bt setTitle:@"update" forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(update:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [bt setTitle:@"select" forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
//    －打开／关闭资料库
//    使用资料库的第一件事，就是建立一个资料库。要注意的是，在iOS环境下，只有document directory 是可以进行读写的。在写程式时用的那个Resource资料夹底下的东西都是read-only。因此，建立的资料库要放在document 资料夹下。方法如下：
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSString *documentDirectory = [paths objectAtIndex:0];

    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];

    db = [FMDatabase databaseWithPath:dbPath] ;

    if (![db open]) {
   
        NSLog(@"Could not open db.");
     
        return ;
    
    }
    
//    建立table
//    如果是新建的资料库档，一开始是没有table的。建立table的方式很简单：
    //创建表
    BOOL create =  [db executeUpdate:@"create table if not exists t_health(id integer primary key  autoincrement, name text,phone text)"];
    
    if (create) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
    
}

- (void)insert:(UIButton *)sender {
    
    BOOL insert = [db executeUpdate:@"insert into t_health (name,phone) values(?,?)",@"jac3b",@"138000000000"];
    if (insert) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败");
    }
}

- (void)delete:(UIButton *)sender {
    BOOL delete = [db executeUpdate:@"delete from t_health where name like ?",@"jacob"];
    if (delete) {
        NSLog(@"删除数据成功");
    }else{
        NSLog(@"删除数据失败");
    }
}

- (void)update:(UIButton *)sender {
    BOOL update = [db executeUpdate:@"update t_health set name = ?  where phone = ?",@"jacob111",@"138000000000"];
    if (update) {
        NSLog(@"更新数据成功");
    }else{
        NSLog(@"更新数据失败");
    }
    
}

- (void)select:(UIButton *)sender {
    FMResultSet *set = [db executeQuery:@"select * from t_health "];
    while ([set next]) {
        NSString *name =  [set stringForColumn:@"name"];
        NSString *phone = [set stringForColumn:@"phone"];
        NSLog(@"name : %@ phone: %@",name,phone);
    }
    
}

-(void)getinfo{
    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        
    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){
            dispatch_semaphore_signal(sema);
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        //dispatch_release(sema);
        
    }

    else{
        addressBooks = ABAddressBookCreate();
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
     
        //新建一个addressBook model类
        ViewController *addressBook = [[ViewController alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
//        if(ABPersonHasImageData(person)){
//            NSData *photoData = CFBridgingRelease(ABPersonHasImageData(person));
            //NSString * imgStr = [[NSString alloc] initWithData:photoData  encoding:NSUTF8StringEncoding];
//            if(photoData){
        
//            }
//        }
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
      
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
        addressBook.recordID = (int)ABRecordGetRecordID(person);;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                NSLog(@"(__bridge NSString*)value:%@",(__bridge NSString*)value);
                switch (j) {
                    case 0: {// Phone number
                        addressBook.tel = (__bridge NSString*)value;
                        break;
                    }
                    case 1: {// Email
                        addressBook.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [addressBookTemp addObject:addressBook];
        //[self.tableView reloadData];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
}
//显示在table中

//行数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//列数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [addressBookTemp count];
}

//cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"ContactCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
        [imgview setImage:[UIImage imageNamed:@"BtnClose"]];
        [cell.imageView addSubview:imgview];
    }
    
    ViewController *book = [addressBookTemp objectAtIndex:indexPath.row];
    
    if (book.name && book.tel) {
        cell.textLabel.text = book.name;
        
        cell.detailTextLabel.text = book.tel;
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // DetailViewController * detailVC =[[DetailViewController alloc]init];
    //detailVC.labName
   // [self presentViewController:detailVC animated:YES completion:nil];
     UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",cell.detailTextLabel.text];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
