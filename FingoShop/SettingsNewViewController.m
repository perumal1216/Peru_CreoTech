//
//  SettingsNewViewController.m
//  FingoShop
//
//  Created by Rambabu Mannam on 02/06/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import "SettingsNewViewController.h"
#import "SVProgressHUD.h"
#import "OrdersListViewController.h"
#import "UIBarButtonItem+Badge.h"
#import "PrivacyPolicyVC.h"

@interface SettingsNewViewController ()
{
    NSString *type;
    NSString *serviceType;
     UIBarButtonItem *AP_barbutton2,*AP_barbutton3,*AP_barbutton4;
}
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIButton *btnSignOut;
@property (weak, nonatomic) IBOutlet UIButton *changePswdButton;
@property (weak, nonatomic) IBOutlet UILabel *changedPswdLabel;

- (IBAction)btnYourOrdersClicked:(id)sender;
- (IBAction)btnHelpClicked:(id)sender;
- (IBAction)btnSignOutClicked:(id)sender;
- (IBAction)btnWishListClicked:(id)sender;
- (IBAction)changePasswordButtonAction:(id)sender;

@end

@implementation SettingsNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width / 2;
//    self.userImageView.clipsToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotification) name:@"logoutNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginNotification) name:@"loginNotification" object:nil];
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 150, 20)];
    lbl.textColor=[UIColor whiteColor];
    lbl.text=@"My Profile";
    [view addSubview:lbl];
    self.navigationItem.titleView = view;
    UIImage *abuttonImage2 = [UIImage imageNamed:@"ic_cart.png"];
    UIButton *aaButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton2 setImage:abuttonImage2 forState:UIControlStateNormal];
    aaButton2.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    AP_barbutton2 = [[UIBarButtonItem alloc] initWithCustomView:aaButton2];
    
    [aaButton2 addTarget:self action:@selector(btnCartClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImage *abuttonImage3 = [UIImage imageNamed:@"ic_search_white_1x.png"];
    UIButton *aaButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton3 setImage:abuttonImage3 forState:UIControlStateNormal];
    aaButton3.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    AP_barbutton3 = [[UIBarButtonItem alloc] initWithCustomView:aaButton3];
    [aaButton3 addTarget:self action:@selector(btnSearchClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *abuttonImage4 = [UIImage imageNamed:@"ic_vs.png"];
    UIButton *aaButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton4 setImage:abuttonImage4 forState:UIControlStateNormal];
    aaButton4.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    AP_barbutton4 = [[UIBarButtonItem alloc] initWithCustomView:aaButton4];
    [aaButton4 addTarget:self action:@selector(btnVirtualShopping:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItems =
    [NSArray arrayWithObjects:AP_barbutton2,AP_barbutton4,AP_barbutton3,nil];
    
    
}

-(void)loginNotification {
    [self CheckCart];
    
}

-(void)logoutNotification {
    [self CheckCart];
    
}

-(void)CheckCart
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
        AP_barbutton2.badgeValue =[[NSUserDefaults standardUserDefaults] stringForKey:@"CartCount"];
        
    }
    else {
        AP_barbutton2.badgeValue = 0;
    }
    
}

-(void)btnVirtualShopping:(id)sender
{
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VirtualShoppingVC"];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)btnSearchClicked:(id)sender
{
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnCartClicked:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
        if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"CartCount"] integerValue] > 0) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Cart"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else {
            UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Add atleast one Product to your cart" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
    }
    else {
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Please login to get cart information" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
           // [self performSegueWithIdentifier:@"loginSegue" sender:self];
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self.navigationController pushViewController:vc animated:YES];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated {
     [self CheckCart];
    [_changePswdButton setHidden:true];
    [_changedPswdLabel setHidden:true];
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
        self.lblUserName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];

        [_btnSignOut setTitle:@"Sign Out" forState:UIControlStateNormal];
        type = @"LOGOUT";
       // [_changePswdButton setHidden:false];
       // [_changedPswdLabel setHidden:false];
        [_lblUserName setHidden:false];
        [_userImageView setHidden:true];
        
//        _lblLogout.text=@"LOGOUT";
    }else
    {
        self.lblUserName.text = @"Guest";
        [_btnSignOut setTitle:@"Sign In" forState:UIControlStateNormal];
        type = @"LOGIN";
      //  [_changePswdButton setHidden:true];
       // [_changedPswdLabel setHidden:true];
        [_lblUserName setHidden:true];
        [_userImageView setHidden:false];


//        _lblLogout.text=@"LOGIN";
        
    }

}


- (IBAction)btnYourOrdersClicked:(id)sender {
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
        
        [self callGetOrdersService];
        
        
        
    }else
    {
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Login to Proceed" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }

}

- (IBAction)termsandconditionsClicked:(id)sender {
    PrivacyPolicyVC *privacyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyPolicyVC"];
    privacyVC.flagStrng = @"TermsAndConditions";
    [self.navigationController pushViewController:privacyVC animated:YES];
}

- (IBAction)btnHelpClicked:(id)sender {
    
    PrivacyPolicyVC *privacyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyPolicyVC"];
    privacyVC.flagStrng = @"PrivacyAndPolicy";
    [self.navigationController pushViewController:privacyVC animated:YES];
    
}

- (IBAction)btnSignOutClicked:(id)sender {
    
    if ([type isEqualToString:@"LOGIN"]) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
        [self.navigationController pushViewController:vc animated:YES];
        [_btnSignOut setTitle:@"Sign Out" forState:UIControlStateNormal];
        type = @"LOGOUT";
    }
    else {
      
        [self callLogoutService];
        
    }
    
    
}

- (IBAction)btnWishListClicked:(id)sender {
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
        
        [self performSegueWithIdentifier:@"WishList" sender:self];
        
        
    }else
    {
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Login to Proceed" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self.navigationController pushViewController:vc animated:YES];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }

}

- (IBAction)changePasswordButtonAction:(id)sender {
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordVC"];
    [self.navigationController pushViewController:vc animated:YES];
    //[self performSegueWithIdentifier:@"ChangePasswordVC" sender:self];
    
}
- (IBAction)myAccountButtonAction:(id)sender {
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
        
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAccountVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else
    {
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Login to Proceed" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
}
- (IBAction)myRewardsButtonAction:(id)sender {
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
        
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MyRewardPointsVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    }else
    {
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Login to Proceed" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
}



-(void)callLogoutService
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    seviceconn = [[ServiceConnection alloc]init];
    seviceconn.delegate = self;
    serviceType = @"Logout";
    [seviceconn performLogout];
}

-(void)callGetOrdersService
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    seviceconn = [[ServiceConnection alloc]init];
    seviceconn.delegate = self;
    serviceType = @"GetOrder";
    [seviceconn GetCustomerOrders];
}




#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    if (jsonDict != nil){
        if ([serviceType isEqualToString:@"Logout"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"CartCount"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName: @"logoutNotification" object:nil];
            [_btnSignOut setTitle:@"Sign In" forState:UIControlStateNormal];
            self.lblUserName.text = @"Guest";
            type = @"LOGIN";
            [_changePswdButton setHidden:true];
            [_changedPswdLabel setHidden:true];
            [_lblUserName setHidden:true];
            [_userImageView setHidden:false];
            
        }
        else {
            if (jsonDict.count == 0) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Currently you have no orders" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:ok];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else if ([[jsonDict objectForKey:@"status"] isEqualToString:@"FAIL"]) {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:ok];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            else if (jsonDict.count > 0) {
                //[self performSegueWithIdentifier:@"OrdersList" sender:self];
                OrdersListViewController *list=[[OrdersListViewController alloc] initWithNibName:@"OrdersListViewController" bundle:nil];
                list.jsonDict = jsonDict;
                [self.navigationController pushViewController:list animated:YES];
                
            }
            else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Currently you have no orders" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:ok];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }

    }
    
    
    [SVProgressHUD dismiss];
    
}



- (void)errorMessage:(NSString *)errMsg
{
    [SVProgressHUD dismiss];
}


@end
