//
//  InformationViewController.m
//  HotelBooking
//
//  Created by SkoopView on 20/05/16.
//  Copyright © 2016 Kushal Mandala. All rights reserved.
//

#import "InformationViewController.h"
#import "SVProgressHUD.h"
#define ACCEPTABLE_CHARECTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
@interface InformationViewController ()
{
    CGRect actualSize1;
}
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnAddClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtfldAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtfldZipCode;
@property (weak, nonatomic) IBOutlet UITextField *txtfldMobileNo;
@property (weak, nonatomic) IBOutlet UITextField *txtfldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtfldLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtfldState;
@property (weak, nonatomic) IBOutlet UITextField *txtfldCity;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@end

@implementation InformationViewController
@synthesize type,addressDict;
- (void)viewDidLoad {
    [super viewDidLoad];
    actualSize1=self.view.frame;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeybord:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    
}

-(void)viewWillAppear:(BOOL)animated {
    if ([type isEqualToString:@"Edit"]) {
        self.txtfldFirstName.text = [addressDict objectForKey:@"firstname"];
        self.txtfldLastName.text = [addressDict objectForKey:@"lastname"];
        self.txtfldState.text = [addressDict objectForKey:@"region"];
        self.txtfldCity.text = [addressDict objectForKey:@"city"];
        self.txtfldAddress.text = [addressDict objectForKey:@"street"];
        self.txtfldZipCode.text = [addressDict objectForKey:@"postcode"];
        self.txtfldMobileNo.text = [addressDict objectForKey:@"telephone"];
        
        [_btnAdd setTitle:@"Update" forState:UIControlStateNormal];
        
    }
    else {
        self.txtfldFirstName.text = @"";
        self.txtfldLastName.text = @"";
        self.txtfldState.text = @"";
        self.txtfldCity.text = @"";
        self.txtfldAddress.text = @"";
        self.txtfldZipCode.text = @"";
        self.txtfldMobileNo.text = @"";
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Textfiled Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField)
        [textField resignFirstResponder];
    self.view.frame=actualSize1;
   	return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    actualSize1=self.view.frame;
    if (textField==self.txtfldAddress) {
        CGRect frame=self.view.frame;
        frame.origin.y=-20;
        self.view.frame=frame;
        
    }
    else if (textField==self.txtfldZipCode)
    {
        CGRect frame=self.view.frame;
        frame.origin.y=-65;
        self.view.frame=frame;
    }
    else if (textField==self.txtfldMobileNo)
    {
        CGRect frame=self.view.frame;
        frame.origin.y=-105;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == self.txtfldFirstName ||textField == self.txtfldLastName || textField == self.txtfldCity) {
        NSCharacterSet *acceptedInput = [NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS];
        if ([string isEqualToString:@""] || [string isEqualToString:@" "])
        {
            return YES;
        }
        
       else if (!([[string componentsSeparatedByCharactersInSet:acceptedInput] count] > 1)){
            NSLog(@"not allowed");
           
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:@"Not allowed any special characters and numeric numbers" preferredStyle:UIAlertControllerStyleAlert];
           
           UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
           [alertController addAction:ok];
           
           [self presentViewController:alertController animated:YES completion:nil];
            return NO;
        }
        else{
            return YES;
        }
    }
    else if (textField == self.txtfldZipCode)
     {
         NSInteger oldLength = [textField.text length];
         NSInteger newLength = oldLength + [string length] - range.length;
         if(newLength >= 7){
             return NO;
         }
         else{
             return YES;
         }
         
     }
    
     else if (textField == self.txtfldMobileNo)
     {
         
         NSInteger oldLength = [textField.text length];
         NSInteger newLength = oldLength + [string length] - range.length;
         if(newLength >= 11){
             return NO;
         }
         else{
             return YES;
         }
     }
     else{
          return YES;
     }
    
    

    
    
}

#pragma mark - Button Actions


- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnAddClicked:(id)sender
{
    if ([_txtfldFirstName.text length]>0 &&
        [_txtfldLastName.text length]>0 &&
        [_txtfldState.text length]>0 &&
        [_txtfldCity.text length]>0 &&
        [_txtfldAddress.text length]>0 &&
        [_txtfldZipCode.text length]>0 &&
        [_txtfldMobileNo.text length]>0 ) {
        
        if ([_txtfldZipCode.text length] == 6) {
            
            
            [self callCashOnDeliveryAvailability:_txtfldZipCode.text];
            

            
            
        }
        else{
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[NSString stringWithFormat:@"Please Enter Valid Zipcode"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *alertAcion)
            {
                
                [_txtfldZipCode becomeFirstResponder];
            }];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            

        }
 
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:@"Please enter data in all fields" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}


-(void)callCashOnDeliveryAvailability :(NSString *)pinCode
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"CashOnDelivery";
    
    [serviceconn cashOnDeliveyAvailability:pinCode];
}


-(void)callAddAddressService
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    

    
    NSString * poststr = [[NSString alloc]initWithFormat:@"firstname=%@&lastname=%@&street=%@&city=%@&country_id=IN&region=%@&postcode=%@&telephone=%@",_txtfldFirstName.text,_txtfldLastName.text,_txtfldAddress.text,_txtfldCity.text,_txtfldState.text,_txtfldZipCode.text,_txtfldMobileNo.text];
    
    NSLog(@"post string is : %@",poststr);
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
   ServiceType=@"addAddress";
    [serviceconn AddAddress:poststr];

    
}


-(void)callUpdateAddressService
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress

    NSString * poststr = [[NSString alloc]initWithFormat:@"firstname=%@&lastname=%@&street=%@&city=%@&country_id=IN&region=%@&postcode=%@&telephone=%@",_txtfldFirstName.text,_txtfldLastName.text,_txtfldAddress.text,_txtfldCity.text,_txtfldState.text,_txtfldZipCode.text,_txtfldMobileNo.text];
    
    NSLog(@"post string is : %@",poststr);
    [[NSUserDefaults standardUserDefaults] setObject:[addressDict objectForKey:@"entity_id"] forKey:@"entity_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
   
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"updateAddress";
    [serviceconn UpdateAddress:poststr];

}

-(void) validationHandlerMethod
{
    if ( [_txtfldMobileNo.text length] == 10) {
        
        if ([type isEqualToString:@"Edit"]) {
            [self callUpdateAddressService];
            
        }
        else {
            [self callAddAddressService];
        }
    }
    else{
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[NSString stringWithFormat:@"Please Enter Valid MobileNumber"] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *alertAcion)
                             {
                                 [_txtfldMobileNo becomeFirstResponder];
                                 
                             }];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}



#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    
     if([ServiceType isEqualToString:@"CashOnDelivery"])
    {
//
    
        NSString *message =[jsonDict objectForKey:@"message"];
        
        message = [message stringByReplacingOccurrencesOfString:@"<br/>"
                                                     withString:@"  "];
        
        
        if  ([message isEqualToString:@"We do not deliver to this location."])
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            NSLog(@"%@",jsonDict);
            
           
        }
        else{
            
            
            [self validationHandlerMethod];
            
        }
        
       
        
         [SVProgressHUD dismiss];
        
        
        
        
    }
    
     else{
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction*alertaction){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
         
         [SVProgressHUD dismiss];
    
     }
    
    
   
    
   
    
   
    
}


- (void)errorMessage:(NSString *)errMsg
{
    [SVProgressHUD dismiss];
}


@end
