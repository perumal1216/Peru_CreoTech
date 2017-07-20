//
//  OffersViewController.m
//  FingoShop
//
//  Created by Rambabu Mannam on 25/04/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import "OffersViewController.h"
#import "NotificationCell.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"
#import "UIBarButtonItem+Badge.h"

@interface OffersViewController ()
{
    NSMutableArray *offersArray;
    UIBarButtonItem *AP_barbutton2,*AP_barbutton3,*AP_barbutton4;
}
@property (nonatomic,retain)NSArray *bannerarr;
@property (weak, nonatomic) IBOutlet UITableView *tblOffers;

@end

@implementation OffersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    offersArray = [[NSMutableArray alloc] init];
    [self callGetOffersList];
    
    
//    UIImage *abuttonImage1 = [UIImage imageNamed:@"User_1x.png"];
//    UIButton *aaButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [aaButton1 setImage:abuttonImage1 forState:UIControlStateNormal];
//    aaButton1.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
//    UIBarButtonItem *AP_barbutton1 = [[UIBarButtonItem alloc] initWithCustomView:aaButton1];
//    [aaButton1 addTarget:self action:@selector(btnUserClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotification) name:@"logoutNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginNotification) name:@"loginNotification" object:nil];
    
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 150, 20)];
    lbl.textColor=[UIColor whiteColor];
    lbl.text=@"Offers";
    lbl.textAlignment = NSTextAlignmentLeft;
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
            
            //[self performSegueWithIdentifier:@"loginSegue" sender:self];
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self.navigationController pushViewController:vc animated:YES];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}
- (IBAction)tollFreeButtonAction:(id)sender
{
    NSString *URLString = [@"tel://" stringByAppendingString:@"18003139899"];
    
    NSURL *URL = [NSURL URLWithString:URLString];
    
    [[UIApplication sharedApplication] openURL:URL];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return [offersArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2; // you can have your own choice, of course
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1; // you can have your own choice, of course
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 150.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell"];
    if (cell == nil)
    {
        cell = [[NotificationCell alloc]initWithFrame:CGRectZero];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

    }
    
  
    NSString *urlString =[NSString stringWithFormat:@"%@",[[offersArray objectAtIndex:indexPath.section] objectForKey:@"image_url"]];
    
    urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"prof img is %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    [cell.notificationImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _WSConstSelectedCategoryID = [[offersArray objectAtIndex:indexPath.section] objectForKey:@"id"];
    _WSConstScreenValue = @"Offers";
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)callGetOffersList {
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    [serviceconn GetOffersList];
}


#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    NSLog(@"Offers: %@",jsonDict);
    [SVProgressHUD dismiss];
    if (![jsonDict isEqual:[NSNull null]]) {
        offersArray = [jsonDict objectForKey:@"offers"];
        [self.tblOffers reloadData];
    }
    
}


- (void)errorMessage:(NSString *)errMsg
{
    [SVProgressHUD dismiss];
}

@end
