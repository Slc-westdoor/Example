//
//  DetailViewController.m
//  MyADDressBook
//
//  Created by Slc on 15/8/30.
//  Copyright (c) 2015年 Slc. All rights reserved.
//

#import "DetailViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface DetailViewController ()
{

    NSMutableArray *addressBookTemp;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    addressBookTemp = [NSMutableArray array];
    [self init_View];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)init_View{
    CGFloat WITH =self.view.frame.size.width;
   // CGFloat HIGHT = self.view.frame.size.height;
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 80, 80)];
    self.labName = [[UILabel alloc]initWithFrame:CGRectMake(90, 30, WITH-45, 45)];
    self.labName.text=@"name";
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.labName];
    for (int i =0; i<4; i++) {
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 100+i*30, WITH-20, 30)];
        lab.tag =100+i;
        [self getLabel:lab];
    }
    
}

-(void)getLabel:(UILabel *)lab{
    switch (lab.tag) {
        case 100:
            self.labModel = lab;
            self.labModel.text=@"model";
            [self.view addSubview:self.labModel];
            break;
        case 101:
             self.labIPhone = lab;
            self.labIPhone.text=@"labIPhone";
            [self.view addSubview:self.labIPhone];
            break;
        case 102:
             self.labWorkEmail = lab;
            self.labWorkEmail.text=@"labWorkEmail";
            [self.view addSubview:self.labWorkEmail];
            break;
        case 103:
             self.labHomeEmail = lab;
            self.labHomeEmail.text=@"labHomeEmail";
            [self.view addSubview:self.labHomeEmail];
            break;
            
        default:
            break;
    }
}


-(void)getInfo{
    
    ABRecordID personID = [self.personIDAsNumber intValue];
    CFErrorRef error =NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, personID);
    
    //邮箱
    ABMultiValueRef emails =ABRecordCopyValue(person,kABPersonEmailProperty);
    NSArray *emailArr = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(emails));
    for (int  index =0; index < [emailArr count]; index ++) {
        NSString * email = [emailArr objectAtIndex:index];
        NSString *emailLabel = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(emails, index));
        
        if([emailLabel isEqualToString:(NSString *)kABWorkLabel]){
            [self.labWorkEmail setText:email];
        }else if([emailLabel isEqualToString:(NSString *)kABHomeLabel]){
            [self.labHomeEmail setText:email];
        }else{
            NSLog(@"%@ : %@",@"其它email",email);
        }
    }
    CFRelease(emails);
    
    //电话
    ABMultiValueRef phones =ABRecordCopyValue(person,kABPersonPhoneProperty);
    NSArray *phoneNumbers = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phones));
    for (int  index =0; index < [phoneNumbers count]; index ++) {
        NSString * phoneNumber = [phoneNumbers objectAtIndex:index];
        NSString *phoneNumberLabel = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, index));
        
        if([phoneNumberLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel]){
            [self.labModel setText:phoneNumber];
        }else if([phoneNumberLabel isEqualToString:(NSString *)kABPersonPhoneIPhoneLabel]){
            [self.labIPhone setText:phoneNumber];
        }else{
            NSLog(@"%@ : %@",@"其它电话",phoneNumber);
        }
    }
    CFRelease(phones);
    
    //图片
    if(ABPersonHasImageData(person)){
        NSData *photoData = CFBridgingRelease(ABPersonCopyImageData(person));
        if(photoData){
            [self.imageView setImage:[UIImage imageWithData:photoData]];
        }
    }
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
