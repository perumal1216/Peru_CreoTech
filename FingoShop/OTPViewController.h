//
//  OTPViewController.h
//  FingoShop
//
//  Created by Perumal on 27/04/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"
@interface OTPViewController : UIViewController
    {
        NSMutableData *receivedData;
        UIAlertController *alertController;
        ServiceConnection *seviceconn;

    }
@property (weak, nonatomic) IBOutlet UILabel *optwithmobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobile_label;
@property (weak, nonatomic) IBOutlet UITextField *otpTextField;
@property (nonatomic,strong) NSString *postString;
@property (nonatomic,strong) NSMutableDictionary *postDict;
@end
