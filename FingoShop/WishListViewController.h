//
//  WishListViewController.h
//  FingoShop
//
//  Created by Rambabu Mannam on 25/04/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"

@interface WishListViewController : UIViewController<ServiceConnectionDelegate>
{
      BOOL isPageRefreshing;
    NSUInteger page;
    UIRefreshControl *refreshControl;
    ServiceConnection *serviceConn;
     NSMutableData *receivedData;
     NSString *serviceType;
}
@property(nonatomic,strong) NSMutableDictionary *selectedWishListItemDict;

@end
