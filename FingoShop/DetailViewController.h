//
//  DetailViewController.h
//  FingoShop
//
//  Created by fis on 26/06/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"

@interface DetailViewController : UIViewController<ServiceConnectionDelegate>
{
    ServiceConnection *serviceConn;

        BOOL isPageRefreshing;
        NSUInteger page;
        UIRefreshControl *refreshControl;
        NSMutableData *receivedData;
    NSString *serviceType;
    
    NSString *screenVal;
        

}
@property(nonatomic,strong) NSString *navigationFlag;
@end
