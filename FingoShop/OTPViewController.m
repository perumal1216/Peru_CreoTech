//
//  OTPViewController.m
//  FingoShop
//
//  Created by Perumal on 27/04/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import "OTPViewController.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "Constants.h"

@interface OTPViewController ()
{
    NSString  *serviceType ;
}
@end

@implementation OTPViewController
@synthesize postString,postDict;
//AppDelegate *apdl_signup;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  apdl_signup=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    receivedData =[NSMutableData data];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.optwithmobileLabel.hidden = YES;
    self.mobile_label.text = [NSString stringWithFormat:@"%@",[postDict objectForKey:@"mobile"]];
    self.optwithmobileLabel.text = [NSString stringWithFormat:@"OTP resent to %@",[postDict objectForKey:@"mobile"]];
    //@"OTP resent to"
}
    -(void)viewWillAppear:(BOOL)animated
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 150, 20)];
        lbl.textColor=[UIColor whiteColor];
        lbl.text=@"FingoShop";
        lbl.textAlignment = NSTextAlignmentLeft;
        [view addSubview:lbl];
        self.navigationItem.titleView = view;
       // self.navigationItem.title = @"OTP Screen";
        self.navigationItem.hidesBackButton = YES;
        
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)resendButtonAction:(id)sender {
    
    serviceType = @"resendOTP";
    
  //  https://www.fingoshop.com/restconnect/customer/resendotp/?mobile=
    
    NSString *post = [NSString stringWithFormat:@"mobile=%@",[postDict objectForKey:@"mobile"]];
    
   NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/resendotp"]]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    // [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"Please wait"];
    
    
    NSURLConnection *conn=[NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
    
}

- (IBAction)changeMobileButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendOTPButtonAction:(id)sender {
     serviceType = @"sendOTP";
    
  /*  if(apdl_signup.net == 0)
    {
        
        alertController = [UIAlertController alertControllerWithTitle:apdl_signup.alertTTL message:apdl_signup.alertMSG preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        return;
    }
*/
    //https://www.fingoshop.com/restconnect/customer/verify?otp=&mobile=&fname=&lname=&email=&password=

    NSString *post=[NSString stringWithFormat:@"otp=%@&email=%@&password=%@&mobile=%@&fname=%@&lname=%@",_otpTextField.text,[postDict objectForKey:@"email"],[postDict objectForKey:@"password"],[postDict objectForKey:@"mobile"],[postDict objectForKey:@"fname"],[postDict objectForKey:@"lname"]];
    
    
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/verify"]]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    if ([self.otpTextField.text length]>0)
    {
        
            [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
            // [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showWithStatus:@"Please wait"];
            
            
            NSURLConnection *conn=[NSURLConnection connectionWithRequest:request delegate:self];
            [conn start];
        }
        else
        {
            alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:@"Please enter OTP" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
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
        [SVProgressHUD dismiss];
        
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
            if ([serviceType isEqualToString:@"sendOTP"]) {
                
                
                if ([[NSString stringWithFormat:@"%@",[dictObj objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[NSString stringWithFormat:@"%@",[dictObj objectForKey:@"message"]] preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        // [self.navigationController popViewControllerAnimated:YES];
                        _backNavigationName = @"SendOTP";
                        _backNavigationName1 = @"SendOTP";
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
                        [self.navigationController pushViewController:vc animated:YES];
                    }]];
                    
                [self presentViewController:alertController animated:YES completion:nil];
                    
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
            else{
                
                
                
                if ([[NSString stringWithFormat:@"%@",[dictObj objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    self.optwithmobileLabel.hidden = false;
                    alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[NSString stringWithFormat:@"%@",[dictObj objectForKey:@"message"]] preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                     
                    }]];
                    
                    
                    
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
