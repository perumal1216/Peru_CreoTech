//
//  LoginViewController.h
//  FingoShop
//
//  Created by Rambabu Mannam on 19/04/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "ServiceConnection.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,GIDSignInUIDelegate,GIDSignInDelegate,ServiceConnectionDelegate>
{
    UIAlertController *alertController;
    NSMutableData *receivedData;
    ServiceConnection *serviceconn;


}
@end
