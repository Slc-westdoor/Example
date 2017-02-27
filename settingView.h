//
//  settingView.h
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCropView.h"
#import "UIImage+image.h"

@interface settingView : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ImageCropViewControllerDelegate>{
    
    ImageCropView* imageCropView;
    UIImage* image;
    UIImageView *imageView;
}

@property (nonatomic, strong) IBOutlet ImageCropView* imageCropView;

@end
