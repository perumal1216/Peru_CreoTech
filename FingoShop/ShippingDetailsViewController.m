//
//  ShippingDetailsViewController.m
//  FingoShop
//
//  Created by Rambabu Mannam on 25/04/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import "ShippingDetailsViewController.h"
#import "ShippingDetailsCell.h"
#import "SVProgressHUD.h"
#import "InformationViewController.h"
#import "CartCell.h"
#import "ChoicePaymentViewController.h"
#import "UIImageView+WebCache.h"
#import "ViewController.h"
#import "DetailViewController.h"

@interface ShippingDetailsViewController ()

{
    NSMutableArray *addressListArray;
    NSMutableArray *cartItemsInfoArray;
    NSString *type,*serviceType;
    NSInteger selectedIndexVal;
    NSMutableDictionary *addressDict,*ShippingInfoDict;
    NSString *productName;
    NSString *selected_address;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tbladdress;

- (IBAction)btnAddClicked:(id)sender;
- (IBAction)btnNextClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;

@end

@implementation ShippingDetailsViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 5;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
//                                 CGRectMake(0, 0, tableView.frame.size.width, 30.0)];
//    sectionHeaderView.backgroundColor = [UIColor colorWithRed:223/255.0 green:231/255.0 blue:235/255.0 alpha:1];
//
//    UILabel *headerLabel1 = [[UILabel alloc] initWithFrame:
//                             CGRectMake(5,3,60, 25.0)];
//
//    UILabel *headerLabel2 = [[UILabel alloc] initWithFrame:
//                             CGRectMake(63,3, 140, 25.0)];
//
//    UILabel *headerLabel3 = [[UILabel alloc] initWithFrame:
//                             CGRectMake(tableView.frame.size.width-110,3,100, 25.0)];
//
//    headerLabel1.backgroundColor = [UIColor clearColor];
//    headerLabel2.backgroundColor = [UIColor clearColor];
//    headerLabel3.backgroundColor = [UIColor clearColor];
//    //    headerLabel.textAlignment = NSTextAlignmentCenter;
//    //    [headerLabel setFont:[UIFont fontWithName:@"Verdana" size:17.0]];
//    //    headerLabel1.font = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold",@"Verdana"] size:14.0];
//    //    headerLabel2.font = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold",@"Verdana"] size:14.0];
//    //    headerLabel3.font = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold",@"Verdana"] size:12.0];
//
//    [headerLabel1 setFont:[UIFont fontWithName:@"Verdana" size:14.0]];
//    [headerLabel2 setFont:[UIFont fontWithName:@"Verdana" size:14.0]];
//    [headerLabel3 setFont:[UIFont fontWithName:@"Verdana" size:14.0]];
//
//    headerLabel1.text = @"TOTAL -";
//    headerLabel2.text = @"1 product";
//
//    headerLabel3.text = @"Rs. 575.40";
//    headerLabel3.textAlignment = NSTextAlignmentRight;
//
//
//
//    [sectionHeaderView addSubview:headerLabel1];
//    [sectionHeaderView addSubview:headerLabel2];
//    [sectionHeaderView addSubview:headerLabel3];
//
//
//    return sectionHeaderView;
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 30;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ShippingDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shippingDetailsCell"];
//    if (cell == nil)
//    {
//        cell = [[ShippingDetailsCell alloc]initWithFrame:CGRectZero];
//
//    }
//
//    return cell;
//}
//
//
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//- (IBAction)btnAddClicked:(id)sender
//{
//    [self performSegueWithIdentifier:@"AddAddress" sender:self];
//}
//
//- (IBAction)btnNextClicked:(id)sender
//{
//    [self performSegueWithIdentifier:@"paymentSegue" sender:self];
//}
//
//- (IBAction)btnBackClicked:(id)sender {
//
//    [self.navigationController popViewControllerAnimated:YES];
//
//}
//
//
//-(void)callShippingService:(NSMutableDictionary *)loginDict
//{
//    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
//
//    serviceconn = [[ServiceConnection alloc]init];
//    serviceconn.delegate = self;
//   // [serviceconn performLogin:loginDict];
//}
//
//
//
//#pragma mark - ServiceConnection Delegate Methods
//
//- (void)jsonData:(NSDictionary *)jsonDict
//{
//
//    [SVProgressHUD dismiss];
//
//}
//
//
//- (void)errorMessage:(NSString *)errMsg
//{
//    [SVProgressHUD dismiss];
//}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.tbladdress.delegate = self;
    self.tbladdress.dataSource = self;
    self.tbladdress.allowsMultipleSelectionDuringEditing = NO;
    
    
    cartItemsInfoArray = [[NSMutableArray alloc] init];
    addressListArray = [[NSMutableArray alloc] init];
    //    [self callGetCartInfoService];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    
    [self callGetCartInfoService];
   
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:true];
}


-(void) dealloc
{
}

#pragma mark - UITableView Delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [cartItemsInfoArray count];
    }
    else {
        return addressListArray.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                     CGRectMake(0, 0, tableView.frame.size.width, 30.0)];
        sectionHeaderView.backgroundColor = [UIColor colorWithRed:238/255.0 green:239/255.0 blue:241/255.0 alpha:1];
        
        UILabel *headerLabel1 = [[UILabel alloc] initWithFrame:
                                 CGRectMake(5,13,100, 25.0)];
        
        //    UILabel *headerLabel2 = [[UILabel alloc] initWithFrame:
        //                             CGRectMake(63,3, 140, 25.0)];
        //
        //    UILabel *headerLabel3 = [[UILabel alloc] initWithFrame:
        //                             CGRectMake(tableView.frame.size.width-110,3,100, 25.0)];
        
        headerLabel1.backgroundColor = [UIColor clearColor];
        //    headerLabel2.backgroundColor = [UIColor clearColor];
        //    headerLabel3.backgroundColor = [UIColor clearColor];
        //    headerLabel.textAlignment = NSTextAlignmentCenter;
        //    [headerLabel setFont:[UIFont fontWithName:@"Verdana" size:17.0]];
        //    headerLabel1.font = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold",@"Verdana"] size:14.0];
        //    headerLabel2.font = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold",@"Verdana"] size:14.0];
        //    headerLabel3.font = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold",@"Verdana"] size:12.0];
        
        [headerLabel1 setFont:[UIFont fontWithName:@"Verdana" size:14.0]];
        //    [headerLabel2 setFont:[UIFont fontWithName:@"Verdana" size:14.0]];
        //    [headerLabel3 setFont:[UIFont fontWithName:@"Verdana" size:14.0]];
        
        headerLabel1.text = @"ITEMS(1)";
        //    headerLabel2.text = @"1 product";
        //
        //    headerLabel3.text = @"Rs. 575.40";
        //    headerLabel3.textAlignment = NSTextAlignmentRight;
        
        
        
        [sectionHeaderView addSubview:headerLabel1];
        //    [sectionHeaderView addSubview:headerLabel2];
        //    [sectionHeaderView addSubview:headerLabel3];
        return sectionHeaderView;
        
    }
    else {
        UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                     CGRectMake(0, 0, tableView.frame.size.width, 30.0)];
        sectionHeaderView.backgroundColor = [UIColor colorWithRed:238/255.0 green:239/255.0 blue:241/255.0 alpha:1];
        
        UILabel *headerLabel1 = [[UILabel alloc] initWithFrame:
                                 CGRectMake(5,13,160, 25.0)];
        
        headerLabel1.backgroundColor = [UIColor clearColor];
        [headerLabel1 setFont:[UIFont fontWithName:@"Verdana" size:14.0]];
        headerLabel1.text = @"SHIPPING ADDRESS";
        [sectionHeaderView addSubview:headerLabel1];
        return sectionHeaderView;
        
        
    }
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 40.0;
    }
    else {
        return 40.0;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                     CGRectMake(0, 0, tableView.frame.size.width, 80.0)];
        sectionHeaderView.backgroundColor = [UIColor whiteColor];
        
        
        UIButton *footerButton1 = [[UIButton alloc] initWithFrame:
                                   CGRectMake(tableView.frame.size.width/4-55,4,111, 32.0)];
        
        [footerButton1 setTitle:@"ADD MORE" forState:UIControlStateNormal];
        [footerButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        footerButton1.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [footerButton1 addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        footerButton1.tag = section;
        
        
        
        UIButton *footerButton2 = [[UIButton alloc] initWithFrame:
                                   CGRectMake((tableView.frame.size.width/4)*3-55,4,109, 32)];
        
        [footerButton2 setTitle:@"EDIT" forState:UIControlStateNormal];
        [footerButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [footerButton2 addTarget:self action:@selector(continueBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        footerButton2.tag = section;
        footerButton2.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
    UILabel *footerLabel = [[UILabel alloc]initWithFrame:CGRectMake(tableView.frame.size.width/2, 4, 1, 32)];
//        footerLabel.backgroundColor = [UIColor grayColor];;
//        
    [sectionHeaderView addSubview:footerButton1];
        [sectionHeaderView addSubview:footerLabel];
       //[sectionHeaderView addSubview:footerButton2];
        
        return sectionHeaderView;
        
    }
    else {
        UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                     CGRectMake(0, 0, tableView.frame.size.width, 40.0)];
        sectionHeaderView.backgroundColor = [UIColor whiteColor];
        
        
        UIButton *footerButton1 = [[UIButton alloc] initWithFrame:
                                   CGRectMake(tableView.frame.size.width/8-50,4,111, 32.0)];
        
        [footerButton1 setTitle:@"ADD MORE" forState:UIControlStateNormal];
        [footerButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        footerButton1.titleLabel.font = [UIFont systemFontOfSize:16.0];
        footerButton1.tag = section;
        
        [footerButton1 addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *footerButton2 = [[UIButton alloc] initWithFrame:
                                   CGRectMake((tableView.frame.size.width/4)*3-55,4,109, 32)];
        [footerButton2 setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:111.0/255.0 blue:110.0/255.0 alpha:1]];
        [footerButton2.layer setCornerRadius:3];
        
        [footerButton2 setTitle:@"CONTINUE" forState:UIControlStateNormal];
        [footerButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        footerButton2.titleLabel.font = [UIFont systemFontOfSize:14.0];
        footerButton2.tag = section;
        [footerButton2 addTarget:self action:@selector(continueBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        UILabel *footerLabel = [[UILabel alloc]initWithFrame:CGRectMake(tableView.frame.size.width/2, 4, 1, 32)];
        footerLabel.backgroundColor = [UIColor grayColor];;
        
        
        
        [sectionHeaderView addSubview:footerButton1];
        [sectionHeaderView addSubview:footerLabel];
        [sectionHeaderView addSubview:footerButton2];
        
        if ([selected_address isEqualToString:@"AddressSelected"]) {
            
            [footerButton2 setHidden:NO];
        }
        else{
            [footerButton2 setHidden:YES];
        }
        
        return sectionHeaderView;
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    if (indexPath.section == 1) {
        return NO;
    }
    else{
    return YES;
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (indexPath.section == 1) {
            
            NSDictionary *dict = [addressListArray objectAtIndex:indexPath.row];
           [self callAddressDeleteService:[dict objectForKey:@"entity_id"]];
        }
        else {
            
            NSDictionary *dict = [cartItemsInfoArray objectAtIndex:indexPath.row];
            [self callDeleteCartItemService:[dict objectForKey:@"cart_item_id"]];
            
            
        }
        
        
        
    }
}



-(void)moreBtnClicked:(UIButton*)sender
{
    if (sender.tag == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else {
        type = @"More";
        [self performSegueWithIdentifier:@"AddAddress" sender:self];
        
    }
}

-(void)editBtnClicked:(UIButton*)sender
{
    if (sender.tag == 0) {
        
    }
    else {
        type = @"Edit";
        [self performSegueWithIdentifier:@"AddAddress" sender:self];
        
    }
}
-(void)continueBtnClicked:(UIButton*)sender
{
      addressDict=[addressListArray objectAtIndex:selectedIndexVal];
     
     if (addressDict) {
     
     NSString *post = [NSString stringWithFormat:@"email=%@&firstname=%@&lastname=%@&street=%@&city=%@&postcode=%@&telephone=%@&country_id=%@&region=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"email"],[addressDict objectForKey:@"firstname"],[addressDict objectForKey:@"lastname"],[addressDict objectForKey:@"street"],[addressDict objectForKey:@"city"],[addressDict objectForKey:@"postcode"],[addressDict objectForKey:@"telephone"],[addressDict objectForKey:@"country_id"],[addressDict objectForKey:@"region"]];
     [self callAddressSaveService:post];
     }
     //            [self performSegueWithIdentifier:@"paymentSegue" sender:self];
     NSLog(@"Test");

}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"AddAddress"]) {
        
        if ([type isEqualToString:@"Edit"]) {
            
            UIButton * button = (UIButton *)sender;
            InformationViewController *ivc = [segue destinationViewController];
            ivc.type = type;
            ivc.addressDict = [addressListArray objectAtIndex:button.tag];

        }
    }
    
    else if ([segue.identifier isEqualToString:@"choicePaymentSegue"]) {
        ChoicePaymentViewController *ivc = [segue destinationViewController];
        ivc.shippingInfo = ShippingInfoDict;
        ivc.productInfo = productName;

        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 40.0;
    }
    else {
        return 40.0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cartCellAddress"];
        if (cell == nil)
        {
            cell = [[CartCell alloc]initWithFrame:CGRectZero];
            
        }
        
        
        NSDictionary *dict = [cartItemsInfoArray objectAtIndex:indexPath.row];
        NSLog(@"Item is: %@",dict);
        
        NSString *urlString =[NSString stringWithFormat:@"%@",[dict objectForKey:@"thumbnail_pic_url"]];
        
        urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSLog(@"prof img is %@",urlString);
        NSURL *url = [NSURL URLWithString:urlString];
        [cell.imgProductImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
        
        
        
        NSInteger qty = [[dict objectForKey:@"qty"] integerValue];
        NSInteger itemPrice = [[dict objectForKey:@"item_price"] integerValue] * qty;
        cell.lblName.text = [dict objectForKey:@"item_title"];
        cell.lblSeller.text = @"by test seller";
        cell.lblFinalPrice.text = [NSString stringWithFormat:@"₹ %ld",(long)itemPrice];
        cell.lblQuantity.text= [ NSString stringWithFormat:@"%ld",[[dict objectForKey:@"qty"] integerValue]];
        return cell;
    }
    else {
        ShippingDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shippingDetailsCell"];
        if (cell == nil)
        {
            cell = [[ShippingDetailsCell alloc]initWithFrame:CGRectZero];
            
        }
        NSMutableDictionary *addrDict=[addressListArray objectAtIndex:indexPath.row];
        
        cell.lblName.text=[NSString stringWithFormat:@"%@ %@",[addrDict objectForKey:@"firstname"],[addrDict objectForKey:@"lastname"]];
        cell.lblAddress.text=[NSString stringWithFormat:@"%@,%@,%@ - %@",[addrDict objectForKey:@"street"],[addrDict objectForKey:@"city"],[addrDict objectForKey:@"region"],[addrDict objectForKey:@"postcode"]];
        
        if ([addrDict objectForKey:@"telephone"]) {
            cell.lblPhone.text=[addrDict objectForKey:@"telephone"];

        }
        else {
            cell.lblPhone.text = @"";
        }
        
        [cell.deleteButton setTag:indexPath.row];
        [cell.editButton setTag:indexPath.row];
        
        [cell.editButton addTarget:self action:@selector(adressEditButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteButton addTarget:self action:@selector(adressDeleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
        
    }
    
}
-(void)adressEditButtonAction:(UIButton *)sender
{
//    type = @"Edit";
//    InformationViewController *ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"InformationViewController"];
//    ivc.type = type;
//    ivc.addressDict = [addressListArray objectAtIndex:selectedIndexVal];
    
    type = @"Edit";
    [self performSegueWithIdentifier:@"AddAddress" sender:sender];
    
}
-(void)adressDeleteButtonAction:(UIButton *)sender
{
    NSDictionary *dict = [addressListArray objectAtIndex:sender.tag];
    [self callAddressDeleteService:[dict objectForKey:@"entity_id"]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Successfully tapped");
    
    
    if (indexPath.section == 0) {
        [tableView selectRowAtIndexPath:indexPath
                               animated:NO
                         scrollPosition:UITableViewScrollPositionMiddle];
        selectedIndexVal = indexPath.row;
    }
    else
    {
        
      // [_tbladdress reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
        
        
        selected_address = @"AddressSelected";
        
        [tableView selectRowAtIndexPath:indexPath
                               animated:NO
                         scrollPosition:UITableViewScrollPositionMiddle];
        selectedIndexVal = indexPath.row;
        
        [_tbladdress reloadData];
      /*  addressDict=[addressListArray objectAtIndex:indexPath.row];
        
        if (addressDict) {
            
            NSString *post = [NSString stringWithFormat:@"email=%@&firstname=%@&lastname=%@&street=%@&city=%@&postcode=%@&telephone=%@&country_id=%@&region=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"email"],[addressDict objectForKey:@"firstname"],[addressDict objectForKey:@"lastname"],[addressDict objectForKey:@"street"],[addressDict objectForKey:@"city"],[addressDict objectForKey:@"postcode"],[addressDict objectForKey:@"telephone"],[addressDict objectForKey:@"country_id"],[addressDict objectForKey:@"region"]];
            [self callAddressSaveService:post];
        }
        //            [self performSegueWithIdentifier:@"paymentSegue" sender:self];
        NSLog(@"Test"); */
    }
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 143.0;
        
    }
    else {
        return 85.0;
        
    }
}



- (IBAction)btnAddClicked:(id)sender
{
    type = @"New";
    [self performSegueWithIdentifier:@"AddAddress" sender:self];
}

- (IBAction)btnNextClicked:(id)sender
{
    
}

- (IBAction)btnBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Service Call Methods

-(void)callGetCartInfoService
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    serviceType=@"GetCartInfo";
    [serviceconn GetCartInfo];
}

-(void)callDeleteCartItemService :(NSString *)Post
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    serviceType=@"DeleteCartInfo";
    [serviceconn RemoveItemFromcart:Post];
}


-(void)callAddressService
{
    serviceType = @"GetAddressInfo";
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    [serviceconn getAddressList];
}

-(void)callAddressDeleteService:(NSString *)string {
    serviceType = @"DeleteAddressInfo";
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    [serviceconn DeleteAddress:string];
    
}

-(void)callAddressSaveService:(NSString *)string {
    serviceType = @"SaveAddressInfo";
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    [serviceconn SaveAddress:string];
    
}

-(void)saveShipmentDetails
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    serviceType=@"ShipmentDetails";
    
   // [serviceconn SaveShipmentDetails:<#(NSString *)#>];
}





#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    if ([serviceType isEqualToString:@"DeleteAddressInfo"]) {
        
        if ([[jsonDict objectForKey:@"status"] isEqualToString:@"SUCCESS"]) {
           
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction*alertaction){
                
                 [self callGetCartInfoService];
                
            }];
            
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Fingoshop" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }
    else if ([serviceType isEqualToString:@"GetAddressInfo"]) {
        [addressListArray removeAllObjects];
        addressListArray=[jsonDict mutableCopy];
        [_tbladdress reloadData];
        
        
    }
    else if ([serviceType isEqualToString:@"GetCartInfo"]) {
        NSDictionary *itemsDict = [jsonDict objectForKey:@"cart_info"];
        [cartItemsInfoArray removeAllObjects];
        cartItemsInfoArray = [[itemsDict objectForKey:@"cart_items"] mutableCopy];
        productName = [[cartItemsInfoArray objectAtIndex:0] objectForKey:@"item_title"];
         [_tbladdress reloadData];
         [self callAddressService];
        
    }
    else if ([serviceType isEqualToString:@"DeleteCartInfo"]) {
        NSDictionary *itemsDict = [jsonDict objectForKey:@"cart_info"];
        [cartItemsInfoArray removeAllObjects];
        cartItemsInfoArray = [[itemsDict objectForKey:@"cart_items"] mutableCopy];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu",(unsigned long)cartItemsInfoArray.count]  forKey:@"CartCount"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"Cart Count: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"CartCount"]);
        
        
        if ([cartItemsInfoArray count] == 0) {
            //[self.navigationController popToRootViewControllerAnimated:YES];
            
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[ViewController class]])
                {
                    
                    [self.navigationController popToViewController:controller animated:YES];
                    
                    break;
                }
                else if ([controller isKindOfClass:[DetailViewController class]])
                {
                    [self.navigationController popToViewController:controller animated:YES];
                    
                    break;
                    
                }
            }
            
        }
        else {
        
        //[self callGetCartInfoService];
        [_tbladdress reloadData];
        }
        
    }
    else if ([serviceType isEqualToString:@"SaveAddressInfo"]) {
        
        ShippingInfoDict=[jsonDict mutableCopy];
        
        [self performSegueWithIdentifier:@"choicePaymentSegue" sender:self];

        NSLog(@"Save Address Result: %@",jsonDict);
        //[self saveShipmentDetails];
    }
    else if ([serviceType isEqualToString:@"ShipmentDetails"]) {
        NSLog(@"Save Shipemnt Result: %@",jsonDict);
        
    }

    [SVProgressHUD dismiss];
    
}


- (void)errorMessage:(NSString *)errMsg
{
    [SVProgressHUD dismiss];
}






@end
