
//
//  ForgotpwdViewController.m
//  MedicineApp
//
//  Created by vamsi vishwanath on 23/03/16.
//  Copyright © 2016 ADMIN. All rights reserved.
//

#import "ForgotpwdViewController.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"

@interface ForgotpwdViewController ()
{
   
        NSMutableData *receivedData;
        UIAlertController *alertController;
   
}
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnResetClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@end

@implementation ForgotpwdViewController
AppDelegate *apdl_Forgot;

- (void)viewDidLoad {
    [super viewDidLoad];
    apdl_Forgot=(AppDelegate *)[[UIApplication sharedApplication] delegate];

    receivedData=[NSMutableData data];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.txtEmail.text = @"angelsadda786@gmail.com";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)btnBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)btnResetClicked:(id)sender {
    
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress

    
    if ([_txtEmail.text length]>0)
    {
        if ([self validateEmail:_txtEmail.text])
        {
            if(apdl_Forgot.net == 0)
            {
                [SVProgressHUD dismiss];
                alertController = [UIAlertController alertControllerWithTitle:apdl_Forgot.alertTTL message:apdl_Forgot.alertMSG preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                     [self.navigationController popViewControllerAnimated:YES];

                }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
//                [self performSegueWithIdentifier:@"Forgot" sender:self];
                return;
                
            }
            
            NSString *sessionid=[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"];

            
            NSString *post=[NSString stringWithFormat:@"email=%@&SID=%@",_txtEmail.text,sessionid];
            NSLog(@"post....%@",post);
            
            NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            NSString *postLength=[NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
            NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
            [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/forgotpwd"]]];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:postData];
            
            NSURLConnection * conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
            [conn start];

            
            

        }
        else
        {
            [SVProgressHUD dismiss];
            alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:@"Please Enter Valid Email ID" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self closeAlertview];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
//            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    else
    {
        [SVProgressHUD dismiss];
        alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:@"Please Enter MailID" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [self closeAlertview];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
//        [self.navigationController popViewControllerAnimated:YES];
        
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
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"%@",dict);
    if (error!=nil)
    {
        NSLog(@"JSON Parsing Error %@",[error localizedDescription]);
    }
    else {
        alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:[dict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [self closeAlertview];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}



-(void)closeAlertview
{
    _txtEmail.text=@"";
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];

}

-(BOOL) validateEmail:(NSString*) emailString
{
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    NSLog(@"%lu", regExMatches);
    if (regExMatches == 0) {
        return NO;
    }
    else{
        return YES;
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField)
        [textField resignFirstResponder];
   	return YES;
}


-(void)callForgotPwdService:(NSString *)EmailId
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    seviceconn = [[ServiceConnection alloc]init];
    seviceconn.delegate = self;
    [seviceconn performForgotpwd:EmailId];
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



@end
