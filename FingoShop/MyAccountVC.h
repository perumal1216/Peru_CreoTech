//
//  MyAccountVC.h
//  FingoShop
//
//  Created by Perumal on 01/05/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"

@interface MyAccountVC : UIViewController<ServiceConnectionDelegate>
{
    ServiceConnection *seviceconn;
}
@property (weak, nonatomic) IBOutlet UITextField *first_nameTF;
@property (weak, nonatomic) IBOutlet UITextField *last_nameTF;
@property (weak, nonatomic) IBOutlet UITextField *email_TF;
@property (weak, nonatomic) IBOutlet UITextField *mobile_TF;

@end
