//
//  PaymentViewController.h
//  HotelBooking
//
//  Created by SkoopView on 09/06/16.
//  Copyright © 2016 Kushal Mandala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"
#import "PayU_iOS_CoreSDK.h"


@interface PaymentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ServiceConnectionDelegate>
{
    ServiceConnection *serviceconn;

}

@property (strong,nonatomic) PayUModelPaymentParams *paymentParam;
- (IBAction)payByCCDC:(id)sender;
- (IBAction)checkCardBrand:(id)sender;
- (IBAction)checkVAS:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *startScreenScrollView;
@property (strong,nonatomic) NSString *totalPay;


@end
