//
//  settingView.m
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "settingView.h"
#import "Tool.h"
#import "touchView.h"
#import "UMMobClick/MobClick.h"
//#import "SKSTableView.h"

@interface settingView ()

@end

@implementation settingView
@synthesize imageCropView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * Views = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49)];
    touchView * View = [[touchView alloc]initWithFrame:Views.frame];
    imageCropView.image = [UIImage imageNamed:@"pict.jpeg"];
    //View.center =self.view.center;
    imageCropView.controlColor = [UIColor cyanColor];
    [self initNavigationItems];
    [self.view addSubview:Views];
    [Views addSubview:View];
    // Do any[]; additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"ForePage"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"ForePage"];
}

-(void)initNavigationItems{
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44+20)];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"sp_unfold_red@2x"] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:navigationBar];
   
    [navigationBar pushNavigationItem:[Tool addNavigationItemRight:nil Title:@"我" bartitle:@"Photo" color:[UIColor whiteColor] barcolor:[UIColor whiteColor] target:self action:@selector(UesrImageClicked)] animated:YES];

    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 74, 100, 100)];
    
    // Do any additional setup after loading the view, typically from a nib.
    // 需求：给imageNamed方法提供功能，每次加载图片就判断下图片是否加载成功。
    // 步骤一：先搞个分类，定义一个能加载图片并且能打印的方法+ (instancetype)imageWithName:(NSString *)name;
    // 步骤二：交换imageNamed和imageWithName的实现，就能调用imageWithName，间接调用imageWithName的实现。
    
    imageView.image = [UIImage imageNamed:@"contacts_major"];
    imageView.tag =2000;
    //圆形
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled=YES;
//    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
//    [imageView addGestureRecognizer:singleTap];
//
    [self.view addSubview:imageView];
    
}


-(void)onClickImage{
    [self UesrImageClicked];
}



- (void)UesrImageClicked
{
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照", @"从相册选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}


#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    return;
                case 1: //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2: //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                return;
            } else {
               // sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;//散列显示
                sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self cropButtonClick];
   

}

-(void)cropButtonClick{

    if(image != nil){
        
        ImageCropViewController *controller = [[ImageCropViewController alloc] initWithImage:image];
        controller.delegate = self;
        controller.blurredBackground = YES;
        imageView.image = image;
        [[self navigationController] pushViewController:controller animated:YES];
    }

}

- (void)ImageCropViewController:(ImageCropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
    image = croppedImage;
    imageView.image = croppedImage;
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)ImageCropViewControllerDidCancel:(ImageCropViewController *)controller{
    imageView.image = image;
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!"
                                                        message:[NSString stringWithFormat:@"Saved with error %@", error.description]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Succes!"
                                                        message:@"Saved to camera roll"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}

- (void)saveButtonClick{
    if (image != nil){
        UIImageWriteToSavedPhotosAlbum(image,self,@selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:), nil);
    }
}


@end
