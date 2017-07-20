//
//  SignupViewController.h
//  MedicineApp
//
//  Created by vamsi vishwanath on 23/03/16.
//  Copyright © 2016 ADMIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"
#import "AppDelegate.h"
@interface SignupViewController : UIViewController<ServiceConnectionDelegate>
{
    NSMutableData *receivedData;
    UIAlertController *alertController;
    ServiceConnection *seviceconn;
    AppDelegate *apdl_signup;

}
@property(strong,nonatomic) NSMutableDictionary *loginUserDataDict;

@end
