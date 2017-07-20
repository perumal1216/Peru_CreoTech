//
//  PaymentViewController.m
//  HotelBooking
//
//  Created by SkoopView on 09/06/16.
//  Copyright © 2016 Kushal Mandala. All rights reserved.
//

#import "PaymentViewController.h"
#import "CardCell.h"
#import "SVProgressHUD.h"
#import "PayUUIPaymentUIWebViewController.h"
#import "PayUUIConstants.h"
#import "iOSDefaultActivityIndicator.h"

@interface PaymentViewController ()
{
    CGRect actualSize1;
    
}
@property (weak, nonatomic) IBOutlet UITextField *txtfldCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtfldCardName;
@property (weak, nonatomic) IBOutlet UITextField *txtfldExpiryDate1;
@property (weak, nonatomic) IBOutlet UITextField *txtfldExpiryDate2;
@property (weak, nonatomic) IBOutlet UITextField *txtfldCVV;
@property (weak, nonatomic) IBOutlet UIView *expireView;
@property (weak, nonatomic) IBOutlet UIView *cvvView;
@property (weak, nonatomic) IBOutlet UILabel *lblCreditCardLine;
@property (weak, nonatomic) IBOutlet UILabel *lblNetBankingLine;
@property (weak, nonatomic) IBOutlet UILabel *lblPayableLine;
@property (weak, nonatomic) IBOutlet UIButton *btnCreditCard;
@property (weak, nonatomic) IBOutlet UIButton *btnNetBanking;
@property (weak, nonatomic) IBOutlet UIButton *btnPayableAtHome;
@property (weak, nonatomic) IBOutlet UIView *netBankingView;
@property (weak, nonatomic) IBOutlet UIView *creditCardView;
@property (weak, nonatomic) IBOutlet UIView *payableAtHomeView;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPay;
- (IBAction)btnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblGrandTotal;


- (IBAction)btnCreditCardClicked:(id)sender;
- (IBAction)btnNetBankingClicked:(id)sender;
- (IBAction)btnPayableAtHomeClicked:(id)sender;


@property (nonatomic, strong) PayUCreateRequest *createRequest;
@property (nonatomic, strong) PayUValidations *validations;
@property (strong, nonatomic) PayUWebServiceResponse *webServiceResponse;
@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;



@end

@implementation PaymentViewController
@synthesize totalPay;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTotalPay.text = [NSString stringWithFormat:@"₹ %@",self.paymentParam.amount];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [self registerForKeyboardNotifications];

    actualSize1=self.view.frame;
    
    self.txtfldCardNumber.layer.borderColor=[[UIColor colorWithRed:213/255.0f green:181/255.0f blue:81/255.0f alpha:1]CGColor];
    self.txtfldCardNumber.layer.borderWidth= 1.0f;
    
    self.txtfldCardName.layer.borderColor=[[UIColor colorWithRed:213/255.0f green:181/255.0f blue:81/255.0f alpha:1]CGColor];
    self.txtfldCardName.layer.borderWidth= 1.0f;
    
    self.expireView.layer.borderColor=[[UIColor colorWithRed:213/255.0f green:181/255.0f blue:81/255.0f alpha:1]CGColor];
    self.expireView.layer.borderWidth= 1.0f;
//    self.expireView.backgroundColor=[UIColor clearColor];
    
    self.cvvView.layer.borderColor=[[UIColor colorWithRed:213/255.0f green:181/255.0f blue:81/255.0f alpha:1]CGColor];
    self.cvvView.layer.borderWidth= 1.0f;
//    self.cvvView.backgroundColor=[UIColor clearColor];
    
    self.lblCreditCardLine.hidden=NO;
    self.lblNetBankingLine.hidden=YES;
    self.lblPayableLine.hidden=YES;
    
    [self.btnCreditCard setTitleColor:[UIColor colorWithRed:42/255.0f green:112/255.0f blue:122/255.0f alpha:1] forState:UIControlStateNormal];
    self.netBankingView.hidden=YES;
    self.payableAtHomeView.hidden=YES;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeybord:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];

}

#pragma mark UITableView Delegate Methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cardCell"];
    if (cell==nil) {
        cell=[[CardCell alloc]initWithFrame:CGRectZero];
    }
    
    
    return cell;
}


#pragma mark - UITextField Delegate Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.txtfldCardNumber)
    {
        if ([string isEqualToString:@""])
        {
//            NSLog(@"Backspace");
            return YES;
        }
        NSString* newText;
        
        newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
         NSUInteger newLength = [textField.text length] + [string length] - range.length;
        
        if (newLength == 4 || newLength == 9 || newLength == 14)
        {
            newText=[newText stringByAppendingString:@"-"];
            textField.text=newText;
            return NO;
        }
        return (newLength > 19) ? NO : YES;
    }
    
    else if (textField == self.txtfldCVV)
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 3) ? NO : YES;
    }
    
   else if (textField == self.txtfldExpiryDate1)
    {
        NSString* newText;
        
        newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if([newText intValue] > 12)
        {
            return NO;
        }
       
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 2) ? NO : YES;
    }
    
    else if (textField == self.txtfldExpiryDate2)
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 4) ? NO : YES;
    }
    

    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField)
        [textField resignFirstResponder];
    self.view.frame=actualSize1;
   	return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    textField.textAlignment = UIControlContentVerticalAlignmentCenter | UIControlContentHorizontalAlignmentCenter;
    actualSize1=self.view.frame;
    if (textField==self.txtfldCardNumber||textField==self.txtfldCardName) {
        CGRect frame=self.view.frame;
        frame.origin.y=-35;
        self.view.frame=frame;
        
    }
    else if (textField==self.txtfldCVV ||textField==self.txtfldExpiryDate1 ||textField==self.txtfldExpiryDate2)
    {
        CGRect frame=self.view.frame;
        frame.origin.y=-85;
        self.view.frame=frame;
    }
    
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame=actualSize1;
    [textField resignFirstResponder];
}
- (void)hideKeybord:(UITapGestureRecognizer *)singleTap {
    
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)btnBackClicked:(id)sender
{
//[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnCreditCardClicked:(id)sender
{
    self.lblCreditCardLine.hidden=NO;
    self.lblNetBankingLine.hidden=YES;
    self.lblPayableLine.hidden=YES;
    
    [self.btnCreditCard setTitleColor:[UIColor colorWithRed:42/255.0f green:112/255.0f blue:122/255.0f alpha:1] forState:UIControlStateNormal];
    [self.btnNetBanking setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnPayableAtHome setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.creditCardView.hidden=NO;
    self.netBankingView.hidden=YES;
    self.payableAtHomeView.hidden=YES;
}

- (IBAction)btnNetBankingClicked:(id)sender
{
    self.lblCreditCardLine.hidden=YES;
    self.lblNetBankingLine.hidden=NO;
    self.lblPayableLine.hidden=YES;
    
    [self.btnNetBanking setTitleColor:[UIColor colorWithRed:42/255.0f green:112/255.0f blue:122/255.0f alpha:1] forState:UIControlStateNormal];
    [self.btnCreditCard setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnPayableAtHome setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.creditCardView.hidden=YES;
    self.netBankingView.hidden=NO;
    self.payableAtHomeView.hidden=YES;
}

- (IBAction)btnPayableAtHomeClicked:(id)sender
{
    self.lblCreditCardLine.hidden=YES;
    self.lblNetBankingLine.hidden=YES;
    self.lblPayableLine.hidden=NO;
    
    [self.btnPayableAtHome setTitleColor:[UIColor colorWithRed:42/255.0f green:112/255.0f blue:122/255.0f alpha:1] forState:UIControlStateNormal];
    [self.btnNetBanking setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnCreditCard setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.creditCardView.hidden=YES;
    self.netBankingView.hidden=YES;
    self.payableAtHomeView.hidden=NO;

}



-(void)callPaymentService:(NSMutableDictionary *)loginDict
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress

    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
   // [serviceconn performLogin:loginDict];
}



#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    
    [SVProgressHUD dismiss];
    
}


- (void)errorMessage:(NSString *)errMsg
{
    [SVProgressHUD dismiss];
}




// Pay u Methods


-(void)dismissKeyboard {
    [self.txtfldCardNumber resignFirstResponder];
    [self.txtfldCVV resignFirstResponder];
    [self.txtfldCardName resignFirstResponder];
    [self.txtfldExpiryDate1 resignFirstResponder];
    [self.txtfldExpiryDate2 resignFirstResponder];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    
//    self.txtfldCardNumber.text = @"5123456789012346";
//    self.txtfldExpiryDate1.text = @"05";
//    self.txtfldExpiryDate2.text = @"2017";
//    self.txtfldCardName.text = @"name";
//    self.txtfldCVV.text = @"123";
    
//    self.txtfldCardNumber.text = @"6069890001361772";
//    self.txtfldExpiryDate1.text = @"12";
//    self.txtfldExpiryDate2.text = @"2019";
//    self.txtfldCardName.text = @"Umang";
//    self.txtfldCVV.text = @"123";
}

- (IBAction)payByCCDC:(id)sender {
    
    self.paymentParam.expYear = _txtfldExpiryDate2.text;
    self.paymentParam.expMonth = _txtfldExpiryDate1.text;
    self.paymentParam.nameOnCard = _txtfldCardName.text;
    NSString *str = _txtfldCardNumber.text;
    str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.paymentParam.cardNumber = str;
    self.paymentParam.CVV = _txtfldCVV.text;
    
//    self.paymentParam.saveStoreCard = self.textFieldSaveStoreCard.text;
//    self.paymentParam.storeCardName = self.textFieldstoreCardName.text;
    self.createRequest = [PayUCreateRequest new];
    [self.createRequest createRequestWithPaymentParam:self.paymentParam forPaymentType:PAYMENT_PG_CCDC withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
        if (error == nil) {
            PayUUIPaymentUIWebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_UIWEBVIEW];
            webView.paymentRequest = request;
            [self.navigationController pushViewController:webView animated:true];
        }
        else{
            NSLog(@"URL request from createRequestWithPostParam: %@",request);
            NSLog(@"PostParam from createRequestWithPostParam:%@",postParam);
            NSLog(@"Error from createRequestWithPostParam:%@",error);
            [[[UIAlertView alloc] initWithTitle:@"ERROR" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            
        }
    }];
}

- (IBAction)checkCardBrand:(id)sender {
    self.validations = [PayUValidations new];
    //self.textFieldCardBrandName.text = [self.validations getIssuerOfCardNumber:self.textFieldCardNumber.text];
}
- (IBAction)checkOffer:(id)sender {
    self.defaultActivityIndicator = [[iOSDefaultActivityIndicator alloc]init];
    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    self.view.userInteractionEnabled = NO;
    self.webServiceResponse = [PayUWebServiceResponse new];
    self.paymentParam.cardNumber = self.txtfldCardNumber.text;
    [self.webServiceResponse getOfferStatus:self.paymentParam withCompletionBlock:^(PayUModelOfferStatus *offerStatus, NSString *errorMessage, id extraParam) {
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        //
        if (errorMessage == nil) {
            NSString *fullMessage = [NSString stringWithFormat:@"Discount =%@ & Msg = %@",offerStatus.discount,offerStatus.msg];
            PAYUALERT(@"Discount", fullMessage);
        }
        else{
            PAYUALERT(@"Error", errorMessage);
        }
    }];
}

- (IBAction)checkVAS:(id)sender {
    PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
    
    [respo getVASStatusForCardBinOrBankCode:self.txtfldCardNumber.text withCompletionBlock:^(id ResponseMessage, NSString *errorMessage, id extraParam) {
        //
        if (errorMessage == nil) {
            //
            if (ResponseMessage == nil) {
                PAYUALERT(@"Yeahh", @"Good to Go");
            }
            else{
                NSString * responseMessage = [NSString new];
                responseMessage = (NSString *) ResponseMessage;
                PAYUALERT(@"Down Time Message", responseMessage);
            }
        }
        else{
            PAYUALERT(@"Error", errorMessage);
        }
    }];
}


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}


// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.startScreenScrollView.contentInset = contentInsets;
    self.startScreenScrollView.scrollIndicatorInsets = contentInsets;

    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    //    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
    //        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
    //        [self.startScreenScrollView setContentOffset:scrollPoint animated:YES];
    //    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.startScreenScrollView.contentInset = contentInsets;
    self.startScreenScrollView.scrollIndicatorInsets = contentInsets;
}



@end
