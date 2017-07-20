//
//  ChangePasswordVC.h
//  FingoShop
//
//  Created by Perumal on 13/02/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import "ViewController.h"

@interface ChangePasswordVC : UIViewController
{
    NSMutableData *receivedData;
    UIAlertController *alertController;
    ServiceConnection *seviceconn;
}
@property (weak, nonatomic) IBOutlet UITextField *txt_oldPswd;
@property (weak, nonatomic) IBOutlet UITextField *txt_newPswd;
@property (weak, nonatomic) IBOutlet UITextField *txt_confirmPswd;


@end
