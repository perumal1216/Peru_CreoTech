//
//  ChoicePaymentViewController.h
//  FingoShop
//
//  Created by SkoopView on 16/08/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"
#import "PayU_iOS_CoreSDK.h"


@interface ChoicePaymentViewController : UIViewController<UITableViewDataSource,ServiceConnectionDelegate,UITextFieldDelegate>
{
    ServiceConnection *serviceconn;
    NSMutableData *receivedData;
    UIAlertController *alertController;
  
}
@property(strong,nonatomic)NSMutableDictionary *shippingInfo;
- (IBAction)startPayment:(id)sender;
@property (nonatomic, strong) PayUModelPaymentRelatedDetail *paymentRelatedDetailone;
@property(strong,nonatomic)NSString *productInfo;




@end
