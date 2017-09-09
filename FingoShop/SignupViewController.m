//
//  SignupViewController.m
//  MedicineApp
//
//  Created by vamsi vishwanath on 23/03/16.
//  Copyright © 2016 ADMIN. All rights reserved.
//

#import "SignupViewController.h"
#import "SVProgressHUD.h"
#import "OTPViewController.h"
#import "Constants.h"
#import "FingoShopTags.pch"

@interface SignupViewController ()
- (IBAction)btnSignupClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txt_lastname;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)btnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txt_Telephone;

@end

@implementation SignupViewController

@synthesize loginUserDataDict;
- (void)viewDidLoad {
    [super viewDidLoad];
    apdl_signup=(AppDelegate *)[[UIApplication sharedApplication] delegate];
   
    receivedData =[NSMutableData data];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    if ([_WSServiceType isEqualToString:@"social"]) {
        _txtName.text = [loginUserDataDict objectForKey:@"username"];
        _txtEmail.text = [loginUserDataDict objectForKey:@"useremail"];
    }
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myLoginDictionaryData:)  name:@"LoginDictionary" object:nil];
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(doneButtonPressed)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    self.txt_Telephone.inputAccessoryView = keyboardToolbar;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setHidesBarsOnTap:NO];
}

//- (void)myLoginDictionaryData:(NSDictionary *)sourceDictionary{
//
//}

-(void)doneButtonPressed
{
    [self.view endEditing:YES];
}

- (IBAction)btnSignupClicked:(id)sender {
    //[self performSegueWithIdentifier:@"UserAcc" sender:self];
    
    
    //[self SignUp_Service];
    
//    
    if(apdl_signup.net == 0)
    {
        
        alertController = [UIAlertController alertControllerWithTitle:apdl_signup.alertTTL message:apdl_signup.alertMSG preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        return;
    }
    
    
  /*  NSString *sessionid=[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"];
    NSString *post=[NSString stringWithFormat:@"firstname=%@&lastname=%@&email=%@&password=%@&Sid=%@&telephone=%@",_txtName.text,_txt_lastname.text,_txtEmail.text,_txtPassword.text,sessionid,_txt_Telephone.text];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/register"]]];
    // New API calls
    
    // NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/apicustomer/register"]]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    */
    
    //  New API call
    
    
    NSDictionary *post_dict = @{@"firstname":_txtName.text,@"lastname":_txt_lastname.text,@"email":_txtEmail.text,@"password":_txtPassword.text,@"mobile":_txt_Telephone.text};
    NSURL *main_url = [NSURL URLWithString:@"https://www.fingoshop.com/restconnect/apicustomer/register"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:main_url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    NSError *error;
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:post_dict options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    
    if ([_txtName.text length]>0 && [_txt_lastname.text length]>0 && [_txtEmail.text length]>0 && [_txtPassword.text length]>0 && [_txt_Telephone.text length]>0)
    {
        if ([self validateEmail:_txtEmail.text]) {
            
            
            if ([_txtPassword.text length]>7)
            {
                if ([self validatePhone:_txt_Telephone.text])
                {
                    [APPDELEGATE showCustomLoader:self];
                    NSURLConnection *conn=[NSURLConnection connectionWithRequest:request delegate:self];
                    [conn start];
                    
                }
                else
                {
                    alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:@"Please enter valid phone number" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    }]];
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                

                
            }
            else
            {
                alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:@"Password shold be minimum 8 characters" preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
        else{
            alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:@"Please enter valid Email ID" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //[self closeAlertview];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
    }
    else
    {
        alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:@"Please enter all the details" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // [self closeAlertview];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
    
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField)
        [textField resignFirstResponder];
   	return YES;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
    NSLog(@"%@",response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
    NSLog(@"getting data");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    [SVProgressHUD dismiss];
    [APPDELEGATE removeCustomLoader:self];
    NSError *error;
    NSMutableDictionary *dictObj = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"%@",dictObj);
   // NSLog(@"Val = %@",[array objectAtIndex:0]);
    if (error!=nil)
    {
        NSLog(@"JSON Parsing Error %@",[error localizedDescription]);
    }
    else
    {

       // if ([[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] objectForKey:@"status"]] isEqualToString:@"1"]
           // )
        if (![[NSString stringWithFormat:@"%@",[dictObj objectForKey:@"code"]] isEqualToString:@"-1"])
        {
          
            /*alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[NSString stringWithFormat:@"%@",[dictObj objectForKey:@"message"]] preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.navigationController popViewControllerAnimated:YES];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
             */
            
            NSString *post=[NSString stringWithFormat:@"email=%@&password=%@&mobile=%@&fname=%@&lname=%@",_txtEmail.text,_txtPassword.text,_txt_Telephone.text,_txtName.text,_txt_lastname.text];
            
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            
             [dict setObject:[NSString stringWithFormat:@"%@",_txtEmail.text]forKey:@"email"];
             [dict setObject:[NSString stringWithFormat:@"%@",_txtPassword.text]forKey:@"password"];
             [dict setObject:[NSString stringWithFormat:@"%@",_txt_Telephone.text]forKey:@"mobile"];
             [dict setObject:[NSString stringWithFormat:@"%@",_txtName.text]forKey:@"fname"];
             [dict setObject:[NSString stringWithFormat:@"%@",_txt_lastname.text]forKey:@"lname"];
            
           /* OTPViewController *otpVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"OTPViewController"];
            otpVC.postString = post;
            otpVC.postDict = dict;
            
            [self.navigationController pushViewController:otpVC animated:YES];
            
            */
            _backNavigationName = @"SendOTP";
            _backNavigationName1 = @"SendOTP";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self.navigationController pushViewController:vc animated:YES];

        }
        else
        {
            alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[NSString stringWithFormat:@"%@",[dictObj objectForKey:@"message"]] preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                // [self closeAlertview];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
}
}


-(BOOL) validateEmail:(NSString*) emailString
{
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
   // NSLog(@"%li", regExMatches);
    if (regExMatches == 0) {
        return NO;
    }
    else{
        return YES;
    }
}

- (BOOL)validatePhone:(NSString *)phoneNumber
{
    
    NSString *numberRegEx = @"[0-9]{10}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    if ([numberTest evaluateWithObject:phoneNumber] == YES)
    return TRUE;
    else
    return FALSE;
}


- (IBAction)btnBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)alreadyaMemberLoginAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)callSignupService:(NSMutableDictionary *)signupDict
{
    //[SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    [APPDELEGATE showCustomLoader:self];
    seviceconn = [[ServiceConnection alloc]init];
    seviceconn.delegate = self;
    [seviceconn performSignup:signupDict];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
   if (textField == self.txt_Telephone)
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

#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    
    [APPDELEGATE removeCustomLoader:self];
    
}


- (void)errorMessage:(NSString *)errMsg
{
    [APPDELEGATE removeCustomLoader:self];
}



@end
