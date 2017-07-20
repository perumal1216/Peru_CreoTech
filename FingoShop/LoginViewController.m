//
//  LoginViewController.m
//  FingoShop
//
//  Created by Rambabu Mannam on 19/04/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "SettingsNewViewController.h"
@interface LoginViewController ()
{
    BOOL show;
    NSMutableDictionary *socialUserDict;
    
    
}
- (IBAction)btnShowClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnForgotPasswordClicked:(id)sender;
- (IBAction)btnFacebookClicked:(id)sender;
- (IBAction)btnGoogleClicked:(id)sender;
- (IBAction)btnLoginClicked:(id)sender;
- (IBAction)btnSignUpClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername,*txtPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnShow;

@end

@implementation LoginViewController
AppDelegate *apdl_login;



- (void)viewDidLoad {
    socialUserDict = [[NSMutableDictionary alloc] init];
    [super viewDidLoad];
    receivedData=[NSMutableData data];
    
    apdl_login=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
    [[GIDSignIn sharedInstance] signOut];
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)btnShowClicked:(id)sender
{
    if (show == YES)
    {
        self.txtPassword.secureTextEntry = YES;
        [self.btnShow setTitle:@"Show" forState:UIControlStateNormal];
        show = NO;
    }
    else
    {
        self.txtPassword.secureTextEntry = NO;
        [self.btnShow setTitle:@"Hide" forState:UIControlStateNormal];
        show = YES;
    }
    
}

- (IBAction)btnBackClicked:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnForgotPasswordClicked:(id)sender
{
    [self performSegueWithIdentifier:@"Forgot" sender:self];
}

- (IBAction)btnFacebookClicked:(id)sender
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    [login
     logInWithReadPermissions: @[@"public_profile",@"email",@"user_about_me",@"user_birthday",@"user_education_history",@"user_hometown"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error: %@",error.localizedDescription);
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             
             if ([FBSDKAccessToken currentAccessToken]) {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/me?fields=name,picture,email" parameters:nil]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                      if (!error) {
                          NSLog(@"fetched user:%@", result);
                          _WSServiceType = @"social";
                          if (result) {
                              [[NSUserDefaults standardUserDefaults]setObject:[result objectForKey:@"name"] forKey:@"name"];
                              [[NSUserDefaults standardUserDefaults] synchronize];
                              [socialUserDict setObject:[result objectForKey:@"name"] forKey:@"username"];
                              
                              [socialUserDict setObject:[result objectForKey:@"email"] forKey:@"useremail"];
                          }
                          [self callSocialLoginService:[result objectForKey:@"email"]];
                      }
                      else {
                          NSLog(@"Facebook Error:%@",[error localizedDescription]);
                          
                      }
                  }];
             }
         }
     }];
    
}

- (IBAction)btnGoogleClicked:(id)sender
{
    [[GIDSignIn sharedInstance] signIn];
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    NSString *userId = user.userID;                  // For client-side use only!
    //  NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *fullName = user.profile.name;
    // NSString *givenName = user.profile.givenName;
    //  NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
    if (user) {
        [socialUserDict setObject:fullName forKey:@"username"];
        [socialUserDict setObject:email forKey:@"useremail"];
        [[NSUserDefaults standardUserDefaults]setObject:fullName forKey:@"name"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _WSServiceType = @"social";
        [self callSocialLoginService:email];
    }
    else{
        
       // [self.navigationController popViewControllerAnimated:YES];
        //return
        
    }
    
    NSLog(@"User Profile Name is: %@",fullName);
    NSLog(@"User ID: %@",userId);
    NSLog(@"User Email: %@",email);
   
}

- (IBAction)btnLoginClicked:(id)sender
{
    
    if ([_txtUsername.text length]>0 && [_txtPassword.text length]>0)
    {
        if ([self validateEmail:_txtUsername.text])
        {
            
            if(apdl_login.net == 0)
            {
                
                
                alertController = [UIAlertController alertControllerWithTitle:apdl_login.alertTTL message:apdl_login.alertMSG preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
                
                
                return;
            }
            
            
            
            [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
            
            [SVProgressHUD showWithStatus:@"Please wait"];
            
            _WSServiceType = @"normal";
            NSString *sessionid=[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"];
            
            NSString *post=[NSString stringWithFormat:@"username=%@&password=%@",_txtUsername.text,_txtPassword.text];
            NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            NSString *postLength=[NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
            NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
            [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/login?SID=%@",sessionid]]];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:postData];
            
            NSURLConnection * conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
            [conn start];
        }
        else
        {
            alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:@"Please Enter Valid Email ID" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //   [self closeAlertview];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    else
    {
        alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:@"Please Enter Email ID and Password" preferredStyle:UIAlertControllerStyleAlert];
        
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
    
    if ([_WSServiceType isEqualToString:@"social"]) {
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",dict);
        
        
        if (error!=nil)
        {
            NSLog(@"JSON Parsing Error %@",[error localizedDescription]);
        }
        
        else if([dict objectForKey:@"code"])
        {
            //            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginDictionary" object:self userInfo:socialUserDict];
            [self performSegueWithIdentifier:@"Signup" sender:self];
            
            
        }
        else
        {
            
            [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"sessionid"] forKey:@"sessionid"];
            [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"email"] forKey:@"email"];
            if ([_WSServiceType isEqualToString:@"social"])
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else{
                [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"name"] forKey:@"name"];
                
            }
            
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]);
            [self callGetCartInfoService];
          //  [self.navigationController popViewControllerAnimated:YES];
          
            
            
        }
        
    }
    else {
        //Normal login
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",dict);
        
        if (error!=nil)
        {
            NSLog(@"JSON Parsing Error %@",[error localizedDescription]);
        }
        
        else if([dict objectForKey:@"code"])
        {
            
            alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[dict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        else
        {
            
            [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"sessionid"] forKey:@"sessionid"];
            [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"email"] forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"name"] forKey:@"name"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]);
            [self callGetCartInfoService];
            
            
           
            if ([_backNavigationName1 isEqualToString:@"SendOTP"]) {
                
                _backNavigationName1 = @"";
                
                for (UIViewController *controller in self.navigationController.viewControllers)
                {
                    if ([controller isKindOfClass:[SettingsNewViewController class]])
                    {
                        
                        [self.navigationController popToViewController:controller animated:YES];
                        
                        break;
                    }
                }

                
                
            }
            else{
                if ([_backNavigationName isEqualToString:@"Home"])
                {
                    _backNavigationName = @"";
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else{
                    [self.navigationController popViewControllerAnimated:YES];
                }

                
            }
            
           
            
            
            
        }
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([_WSServiceType isEqualToString:@"social"]) {
       // SignupViewController *svc = [segue destinationViewController];
       // svc.loginUserDataDict = socialUserDict;
    }
}




-(BOOL) validateEmail:(NSString*) emailString
{
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    NSLog(@"%li", regExMatches);
    if (regExMatches == 0) {
        return NO;
    }
    else{
        return YES;
    }
}

- (IBAction)btnSignUpClicked:(id)sender
{
    _WSServiceType = @"normal";
    [self performSegueWithIdentifier:@"Signup" sender:self];
    
}

-(void)callSocialLoginService:(NSString *)mailID {
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    [SVProgressHUD showWithStatus:@"Please wait"];
    
    
    NSString *sessionid=[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"];
    
    NSString *post=[NSString stringWithFormat:@"username=%@&is_social_login=1",mailID];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.fingoshop.com/restconnect/customer/login?SID=%@",sessionid]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSURLConnection * conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [conn start];
    
}

-(void)callLoginService:(NSMutableDictionary *)loginDict
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    [serviceconn performLogin:loginDict];
}

-(void)callGetCartInfoService
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    //    ServiceType=@"GetCartInfo";
    [serviceconn GetCartInfo];
}


#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    NSDictionary *itemsDict = [jsonDict objectForKey:@"cart_info"];
    NSArray *cartInfoArray = [itemsDict objectForKey:@"cart_items"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu",(unsigned long)cartInfoArray.count]  forKey:@"CartCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"Cart Count: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"CartCount"]);
    [[NSNotificationCenter defaultCenter] postNotificationName: @"loginNotification" object:nil];
    
    [SVProgressHUD dismiss];
    
}


- (void)errorMessage:(NSString *)errMsg
{
    [SVProgressHUD dismiss];
}




@end
