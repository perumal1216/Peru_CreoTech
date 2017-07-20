//
//  ChangePasswordVC.m
//  FingoShop
//
//  Created by Perumal on 13/02/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "Constants.h"
@interface ChangePasswordVC ()

@end

@implementation ChangePasswordVC
AppDelegate *apdl_signup;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loadinpg the view.
     apdl_signup=(AppDelegate *)[[UIApplication sharedApplication] delegate];
     receivedData =[NSMutableData data];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotification) name:@"logoutNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginNotification) name:@"loginNotification" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationItem.title = @"Change Password";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changePasswordButtonAction:(id)sender {
    
    if(apdl_signup.net == 0)
    {
        
        alertController = [UIAlertController alertControllerWithTitle:apdl_signup.alertTTL message:apdl_signup.alertMSG preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        return;
    }
    ///Change Password - https://www.fingoshop.com/restconnect/customer/changepwd?email=jumper33@gmail.com&oldpassword=jumper123&newpass=jumper1234
    
   // Response - {"customerid":"649","oldpassword":"jumper123","newpassword":"jumper1234","change_status":1,"message":"Your Password has been Changed Successfully"}

    NSString *emailid = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    //NSString *sessionid=[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"];
    NSString *post=[NSString stringWithFormat:@"email=%@&oldpassword=%@&newpass=%@",emailid,_txt_oldPswd.text,_txt_newPswd.text];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/changepwd"]]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    if ([_txt_oldPswd.text length]>0 && [_txt_newPswd.text length]>0 && [_txt_confirmPswd.text length]>0)
    {
        if ([_txt_newPswd.text isEqualToString:[NSString stringWithFormat:@"%@",_txt_confirmPswd.text]]) {

                    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
                    // [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                    [SVProgressHUD showWithStatus:@"Please wait"];
                    
                    
                    NSURLConnection *conn=[NSURLConnection connectionWithRequest:request delegate:self];
                    [conn start];
                }
                else
                {
                    alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:@"Password Do not match" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    }]];
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                }
        
            }
    else{
        
        alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:@"Please enter all the required fields" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // [self closeAlertview];
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
        
        // if ([[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] objectForKey:@"status"]] isEqualToString:@"1"]
        // )
        if ([[NSString stringWithFormat:@"%@",[dictObj objectForKey:@"change_status"]] isEqualToString:@"1"])
        {
            alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Your Password has been Changed Successfully" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
               // [self.navigationController popViewControllerAnimated:YES];
                _backNavigationName = @"Home";
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
                [self.navigationController pushViewController:vc animated:YES];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
            alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Please try with another Email ID" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                // [self closeAlertview];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
        [textField resignFirstResponder];
   	return YES;
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
