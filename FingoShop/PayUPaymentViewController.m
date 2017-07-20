//
//  PayUPaymentViewController.m
//  FingoShop
//
//  Created by kushal mandala on 25/08/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import "PayUPaymentViewController.h"



@interface PayUPaymentViewController ()
{
    BOOL _isVerifyAPIBtnTapped, _isStartBtnTapped;

}

@property (strong, nonatomic) UISwitch *switchForSalt;
@property (strong, nonatomic) UISwitch *switchForOneTap;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTransactionID;
@property (weak, nonatomic) IBOutlet UIScrollView *startScreenScrollView;
@property (weak, nonatomic) IBOutlet UITextField *textFieldKey;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAmount;
@property (weak, nonatomic) IBOutlet UITextField *textFieldProductInfo;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSURL;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFURL;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEnvironment;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOfferKey;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF3;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF4;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF5;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserCredential;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSalt;



@end

@implementation PayUPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self clickedBtnStart:nil];
    

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    
    //    [self.tbladdress reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
