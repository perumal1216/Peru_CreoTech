//
//  ForgotpwdViewController.h
//  MedicineApp
//
//  Created by vamsi vishwanath on 23/03/16.
//  Copyright © 2016 ADMIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"

@interface ForgotpwdViewController : UIViewController<NSURLConnectionDataDelegate,NSURLConnectionDelegate,ServiceConnectionDelegate>
{
   
    ServiceConnection *seviceconn;
    
}

@end
