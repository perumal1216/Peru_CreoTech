//
//  ProductDetailVC.h
//  FingoShop
//
//  Created by nag nagarjuna on 03/07/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"



@interface ProductDetailVC : UIViewController<ServiceConnectionDelegate,UIGestureRecognizerDelegate>
{
    ServiceConnection *serviceconn;
    NSString *ServiceType;

}
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property(nonatomic,retain)NSMutableDictionary *productDetailsDict;
@property(nonatomic,retain)NSMutableDictionary *productDetailsDict1;
@end
