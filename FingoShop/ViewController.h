//
//  ViewController.h
//  Kart
//
//  Created by SkoopView on 13/06/16.
//  Copyright © 2016 SkoopView. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"
#import "KIImagePager.h"


@interface ViewController : UIViewController<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,ServiceConnectionDelegate,UIGestureRecognizerDelegate,UISearchControllerDelegate>
{
    ServiceConnection *serviceconn;

}



@end

