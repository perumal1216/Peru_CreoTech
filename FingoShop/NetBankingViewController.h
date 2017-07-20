//
//  NetBankingViewController.h
//  FingoShop
//
//  Created by kushal mandala on 26/08/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayU_iOS_CoreSDK.h"
#import "PayUUIConstants.h"
#import "PayUUIPaymentUIWebViewController.h"


@interface NetBankingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSString *selectedBank;
}
@property (nonatomic, strong) PayUModelPaymentRelatedDetail *paymentRelatedDetail;
@property (strong,nonatomic) PayUModelPaymentParams *paymentParam;

@property (weak, nonatomic) IBOutlet UITextField *paymentTypeForNetBanking;
@property (weak, nonatomic) IBOutlet UITextField *bankCodeForNetBanking;
@property (weak, nonatomic) IBOutlet UITableView *tableViewNetBanking;

- (IBAction)PayByNetBanking:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *insideView1;
@property (nonatomic, strong) PayUCreateRequest *createRequest;

- (IBAction)checkVAS:(id)sender;

@end
