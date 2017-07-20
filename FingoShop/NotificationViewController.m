//
//  NotificationViewController.m
//  FingoShop
//
//  Created by Rambabu Mannam on 25/04/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationCell.h"
#import "SVProgressHUD.h"
#import "Constants.h"
#import "DetailViewController.h"
#import "UIBarButtonItem+Badge.h"
@interface NotificationViewController ()
{
        UIBarButtonItem *AP_barbutton2,*AP_barbutton3,*AP_barbutton4;
}
@property (nonatomic,retain)NSArray *bannerarr;
@property (strong, nonatomic) IBOutlet UITableView *notificationTableView;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bannerarr = [NSArray arrayWithObjects:
                  [UIImage imageNamed:@"notif1.jpg"],
                  [UIImage imageNamed:@"notif2.jpg"],
                  [UIImage imageNamed:@"notif3.jpg"],
                  [UIImage imageNamed:@"notif4.jpg"],
                  nil];
    notificationArray = [[NSArray alloc]init];

    [self callNotificationService];
    
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 150, 20)];
    lbl.textColor=[UIColor whiteColor];
    lbl.text=@"Notifications";
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

-(void)viewWillAppear:(BOOL)animated {
    [self CheckCart];
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
            
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self.navigationController pushViewController:vc animated:YES];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (cell == nil)
    {
        cell = [[NotificationCell alloc]initWithFrame:CGRectZero];
        

    }
   //cell.notificationImageView.image = [_bannerarr objectAtIndex:indexPath.section];
    cell.offerTitleLabel.text = [NSString stringWithFormat:@"%@",[[notificationArray objectAtIndex:indexPath.section] objectForKey:@"title"]];
    cell.offerDescriptionLabel.text = [NSString stringWithFormat:@"%@",[[notificationArray objectAtIndex:indexPath.section] objectForKey:@"description"]];
    
    return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return notificationArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedItemID;
    //NSString *selectedItemType;
    selectedItemID =[NSString stringWithFormat:@"%@",[[notificationArray objectAtIndex:indexPath.section] objectForKey:@"categoryid"]];
    // selectedItemType = @"Womens";
    NSLog(@"%@",selectedItemID);
    _WSConstScreenValue = @"Home";
    _WSConstSelectedCategoryID = selectedItemID;
    // _WSConstSelectedCategoryType = selectedItemType;
   // [self performSegueWithIdentifier:@"detailSegue" sender:self];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}



//// NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
//NSString *selectedItemID;
////NSString *selectedItemType;
//selectedItemID =[NSString stringWithFormat:@"%@",[banner_idarry objectAtIndex:index]];
//// selectedItemType = @"Womens";
//NSLog(@"%@",selectedItemID);
//_WSConstScreenValue = @"Home";
//_WSConstSelectedCategoryID = selectedItemID;
//// _WSConstSelectedCategoryType = selectedItemType;
//[self performSegueWithIdentifier:@"detailSegue" sender:self];

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)callNotificationService
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress

    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    [serviceconn GetNotificationsList];
}

#pragma mark - button Actions

- (IBAction)tollFreeButtonAction:(id)sender
{
    NSString *URLString = [@"tel://" stringByAppendingString:@"18003139899"];
    
    NSURL *URL = [NSURL URLWithString:URLString];
    
    [[UIApplication sharedApplication] openURL:URL];
}


#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary*)jsonDict
{
    
    
    notificationArray = [NSArray arrayWithArray:jsonDict];
    
   // [notificationArray addObjectsFromArray:jsonDict];
    [_notificationTableView reloadData];
    [SVProgressHUD dismiss];
    
}


- (void)errorMessage:(NSString *)errMsg
{
    [SVProgressHUD dismiss];
}

@end
