//
//  OrdersListViewController.h
//  FingoShop
//
//  Created by kushal mandala on 27/08/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"

@interface OrdersListViewController : UIViewController<ServiceConnectionDelegate>
{
    ServiceConnection *seviceconn;
    
}

@property(strong,nonatomic)NSDictionary *jsonDict;

@end
