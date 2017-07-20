//
//  ShippingMethodViewController.h
//  FingoShop
//
//  Created by Rambabu Mannam on 01/06/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"

@interface ShippingMethodViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ServiceConnectionDelegate>
{
    ServiceConnection *serviceconn;
    NSString *ServiceType;

    
}

@end
