//
//  AddToCartViewController.m
//  FingoShop
//
//  Created by fis on 07/07/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import "AddToCartViewController.h"
#import "CartCell.h"
#import "Cart.h"
#import "Product.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "ViewController.h"
@interface AddToCartViewController ()
{
    NSInteger itemTotal,discount,total;
    NSMutableArray *cartInfoArray;
    

}
- (IBAction)btnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblCart;
- (IBAction)btnPlaceorderClicked:(id)sender;
- (IBAction)btnApplyCouponClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblItemTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblDiscount;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblShippingCharges;
@property (weak, nonatomic) IBOutlet UILabel *lblPointsUsed;
@property (weak, nonatomic) IBOutlet UITextField *txtfldCouponCode;

@end

@implementation AddToCartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    cartInfoArray = [[NSMutableArray alloc] init];
    
   /* [self callGetCartInfoService];
    [self checkItemsInCart];
    [self.tblCart reloadData];
    
    */
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self callGetCartInfoService];
    [self checkItemsInCart];
   [self.tblCart reloadData];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self checkItemsInCart];
    [self.tblCart reloadData];
}





-(void)checkItemsInCart
{
    Cart *cart = [Cart singleInstance];
    if ([cart.positions count] == 0) {
        
    }
    else {
        
    }
}


#pragma mark - Tableview Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [cartInfoArray count];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cartCell"];
    if (cell == nil)
    {
        cell = [[CartCell alloc]initWithFrame:CGRectZero];
        cell.layer.borderWidth = 10;
        cell.layer.borderColor = [[UIColor redColor]CGColor];
    }
    
    
    NSDictionary *dict = [cartInfoArray objectAtIndex:indexPath.section];
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
    cell.btnQuantity.tag = indexPath.section;
    [cell.btnQuantity addTarget:self action:@selector(btnQuantityClicked:) forControlEvents:UIControlEventTouchUpInside];
   
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0)
    {
        return 0;
    }
    else
    {
    return 5;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *dict = [cartInfoArray objectAtIndex:indexPath.section];
       [self callDeleteCartItemService:[dict objectForKey:@"cart_item_id"]];
        
        
    }
}


#pragma mark - Button Action Methods


-(void)btnQuantityClicked:(UIButton*)sender {
    
    NSDictionary *dict = [cartInfoArray objectAtIndex:sender.tag];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"FINGOSHOP"
                                                                              message: @"Please enter number of items"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"Quantity";
        textField.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"qty"]];
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];

    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * quantity = textfields[0];
        NSLog(@"%@",quantity.text);
        
        
        [self callUpdateCartServiceWithItemId:[dict objectForKey:@"cart_item_id"] andQuantity:quantity.text];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];

    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnPlaceorderClicked:(id)sender {
    
//    [self performSegueWithIdentifier:@"ShippingAddress" sender:self];
    [self performSegueWithIdentifier:@"ShippingAddrDetails" sender:self];
  //  serviceconn = [[DetailViewController alloc]init];
   // serviceconn.AP_barbutton2.badgeValue = 0;
//[self checkItemsInCart];
}

- (IBAction)btnApplyCouponClicked:(id)sender {
    
    if ([self.txtfldCouponCode.text length]>0) {
        
        [self callApplyCouponService:self.txtfldCouponCode.text];
    }
    else {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"FINGOSHOP"
                                      message:@"Please enter coupon code"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

#pragma mark - Service Call Methods

-(void)callUpdateCartServiceWithItemId:(NSString *)itemId andQuantity: (NSString *)qty
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"Update";
    [serviceconn UpdateCartWithItemId:itemId andQuantity:qty];
}


-(void)callDeleteCartItemService :(NSString *)Post
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"Delete";
    [serviceconn RemoveItemFromcart:Post];
}

-(void)callApplyCouponService :(NSString *)Post
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"ApplyCoupon";
    [serviceconn ApplyCoupon:Post];
}


-(void)callGetCartInfoService
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"GetCartInfo";
    [serviceconn GetCartInfo];
}

#pragma mark - UITextField Delegate Mathods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    
    
    if ([ServiceType isEqualToString:@"Update"]) {
        
        NSLog(@"=====%@====%@=== ",[jsonDict objectForKey:@"code"],[jsonDict objectForKey:@"code"]);
        if([jsonDict objectForKey:@"message"]==(id) [NSNull null] || [[jsonDict objectForKey:@"message"] length]==0 || [[jsonDict objectForKey:@"message"] isEqualToString:@""])
        {
            
            NSDictionary *itemsDict = [jsonDict objectForKey:@"cart_info"];
            NSDictionary *itemsTotal = [jsonDict objectForKey:@"total"];
            [cartInfoArray removeAllObjects];
            cartInfoArray = [[itemsDict objectForKey:@"cart_items"] mutableCopy];
            
            _lblItemTotal.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"subtotal"]];
            _lblTotal.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"grandtotal"]];
            
            if ([[NSString stringWithFormat:@"%@",[itemsTotal objectForKey:@"discount"]] isEqualToString:@""]) {
                _lblDiscount.text = [NSString stringWithFormat:@"₹ 0"];
            }
            
            else {
                _lblDiscount.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"discount"]];
            }
            [_tblCart reloadData];

            
         
            
        }
        
        else{
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[NSString stringWithFormat:@"%@",[jsonDict objectForKey:@"message"]] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
     /*    if ([[jsonDict objectForKey:@"messages"] isEqualToString:@""] || [[jsonDict objectForKey:@"messages"] isKindOfClass:[NSNull class]] ||[[jsonDict objectForKey:@"messages"] isEqual:nil])
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[NSString stringWithFormat:@"%@",[jsonDict objectForKey:@"messages"]] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];

        }
        else{
            
            
            

          
        }
        
       if ([jsonDict isKindOfClass:[NSString class]]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:jsonDict preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];

        }
        else {
        NSDictionary *itemsDict = [jsonDict objectForKey:@"cart_info"];
        NSDictionary *itemsTotal = [jsonDict objectForKey:@"total"];
        [cartInfoArray removeAllObjects];
        cartInfoArray = [[itemsDict objectForKey:@"cart_items"] mutableCopy];
        
        _lblItemTotal.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"subtotal"]];
        _lblTotal.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"grandtotal"]];
            
        if ([[NSString stringWithFormat:@"%@",[itemsTotal objectForKey:@"discount"]] isEqualToString:@""]) {
            _lblDiscount.text = [NSString stringWithFormat:@"₹ 0"];
        }
        
        else {
            _lblDiscount.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"discount"]];
        }
        [_tblCart reloadData];
        
    }
        */
    }
    else  if ([ServiceType isEqualToString:@"Delete"]) {
        
        NSDictionary *itemsDict = [jsonDict objectForKey:@"cart_info"];
        NSDictionary *itemsTotal = [jsonDict objectForKey:@"total"];
        [cartInfoArray removeAllObjects];
        cartInfoArray = [[itemsDict objectForKey:@"cart_items"] mutableCopy];
        
        _lblItemTotal.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"subtotal"]];
        _lblTotal.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"grandtotal"]];
        _lblShippingCharges.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"shipping"]];
        _lblPointsUsed.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"point_used"]];
        
        if ([[NSString stringWithFormat:@"%@",[itemsTotal objectForKey:@"discount"]] isEqualToString:@""]) {
            _lblDiscount.text = [NSString stringWithFormat:@"₹ 0"];
        }
        else {
            _lblDiscount.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"discount"]];
        }

        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu",(unsigned long)cartInfoArray.count]  forKey:@"CartCount"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"Cart Count: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"CartCount"]);
        
        if ([cartInfoArray count] == 0) {
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

        
        _lblItemTotal.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"subtotal"]];
        _lblTotal.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"grandtotal"]];
        if ([[NSString stringWithFormat:@"%@",[itemsTotal objectForKey:@"discount"]] isEqualToString:@""]) {
            _lblDiscount.text = [NSString stringWithFormat:@"₹ 0"];
        }
        else {
            _lblDiscount.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"discount"]];
        }
        [_tblCart reloadData];
        }
    }
    else  if ([ServiceType isEqualToString:@"ApplyCoupon"]) {
                NSLog(@"Coupon result is: %@",jsonDict);
                NSLog(@"%@",[jsonDict objectForKey:@"message"]);
                _lblItemTotal.text = [NSString stringWithFormat:@"₹ %@",[jsonDict objectForKey:@"subtotal"]];
                _lblTotal.text = [NSString stringWithFormat:@"₹ %@",[jsonDict objectForKey:@"grandtotal"]];
        
        
                if ([[NSString stringWithFormat:@"%@",[jsonDict objectForKey:@"discount"]] isEqualToString:@""]) {
                    _lblDiscount.text = [NSString stringWithFormat:@"₹ 0"];
                }
                else {
                    _lblDiscount.text = [NSString stringWithFormat:@"₹ %@",[jsonDict objectForKey:@"discount"]];
                }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
    else  if ([ServiceType isEqualToString:@"GetCartInfo"]) {
        
        NSDictionary *itemsDict = [jsonDict objectForKey:@"cart_info"];
        NSDictionary *itemsTotal = [jsonDict objectForKey:@"total"];
        [cartInfoArray removeAllObjects];
        cartInfoArray = [[itemsDict objectForKey:@"cart_items"] mutableCopy];
        _lblItemTotal.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"subtotal"]];
        _lblTotal.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"grandtotal"]];
        _lblShippingCharges.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"shipping"]];
        _lblPointsUsed.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"point_used"]];
        
        if ([[NSString stringWithFormat:@"%@",[itemsTotal objectForKey:@"discount"]] isEqualToString:@""]) {
            _lblDiscount.text = [NSString stringWithFormat:@"₹ 0"];
        }
        else {
            _lblDiscount.text = [NSString stringWithFormat:@"₹ %@",[itemsTotal objectForKey:@"discount"]];
        }
        [_tblCart reloadData];
                NSLog(@"Cart Info is: %@",cartInfoArray);
                 NSLog(@"Cart Total Info is: %@",itemsTotal);
        
    }
    
    [SVProgressHUD dismiss];
    
}


- (void)errorMessage:(NSString *)errMsg
{
    [SVProgressHUD dismiss];
}

@end
