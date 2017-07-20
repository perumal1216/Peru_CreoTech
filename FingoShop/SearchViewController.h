//
//  SearchViewController.h
//  FingoShop
//
//  Created by Rambabu Mannam on 20/10/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"

@interface SearchViewController : UIViewController<ServiceConnectionDelegate>
{
     ServiceConnection *serviceConn;
}

@end
