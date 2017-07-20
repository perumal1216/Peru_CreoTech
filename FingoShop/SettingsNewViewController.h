//
//  SettingsNewViewController.h
//  FingoShop
//
//  Created by Rambabu Mannam on 02/06/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"

@interface SettingsNewViewController : UIViewController<ServiceConnectionDelegate>
{
    ServiceConnection *seviceconn;
   
}

@end
