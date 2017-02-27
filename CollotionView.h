//
//  CollotionView.h
//  EXAMPLE
//
//  Created by Slc on 16/4/5.
//  Copyright © 2016年 slc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertisingColumn.h"//头部滚动的，不需要可以去掉

@interface CollotionView : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>{
    AdvertisingColumn *_headerView;
}

@end
