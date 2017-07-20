//
//  AddToCartViewController.h
//  FingoShop
//
//  Created by fis on 07/07/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"


@interface AddToCartViewController : UIViewController<UITableViewDataSource,ServiceConnectionDelegate>
{
    ServiceConnection *serviceconn;
    NSString *ServiceType;
    

}
@end
