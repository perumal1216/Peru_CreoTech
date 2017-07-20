//
//  DetailMyOrdersNewViewController.m
//  FingoShop
//
//  Created by Rambabu Mannam on 03/06/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import "DetailMyOrdersNewViewController.h"
#import "SVProgressHUD.h"
#import "DetailMyOrdersNewCell.h"
#import "UIImageView+WebCache.h"

@interface DetailMyOrdersNewViewController ()
{
    NSMutableArray *productsArray;
}
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UITableView *tblDetailMyOrders;
@property (weak, nonatomic) IBOutlet UIView *orderDetailsView;
@property (weak, nonatomic) IBOutlet UIView *paymentInformationView;
@property (weak, nonatomic) IBOutlet UIView *shippingAddressView;
@property (weak, nonatomic) IBOutlet UIView *orderSummaryView;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderDate;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblname;
@property (weak, nonatomic) IBOutlet UILabel *lbl2name;
@property (weak, nonatomic) IBOutlet UILabel *lbl3name;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *post;
@property (weak, nonatomic) IBOutlet UILabel *region;
@property (weak, nonatomic) IBOutlet UILabel *emailid;
@property (weak, nonatomic) IBOutlet UILabel *telephone;




@property (weak, nonatomic) IBOutlet UILabel *lblPaymentMethod;
@property (weak, nonatomic) IBOutlet UILabel *grandTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblTax;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;

@end

@implementation DetailMyOrdersNewViewController
@synthesize orderDict;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Order Details";

    
    
    NSLog(@"product array is %@",productsArray);
    productsArray = [orderDict objectForKey:@"products"];
    NSLog(@"product array is %@",productsArray);
    NSLog(@"order dict :%@", orderDict);
   NSString *dateString = [orderDict objectForKey:@"order_date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"dd-MMM-YY"];
    _lblOrderDate.text = [dateFormatter1 stringFromDate:date];
   // _lblname.text = [orderDict objectForKey:@"parent_id"];
    NSDictionary*newdict = [orderDict objectForKey:@"shipment"];
    _lblname.text = [newdict objectForKey:@"firstname"];
    _city.text = [newdict objectForKey:@"city"];
    _region.text = [newdict objectForKey:@"region"];
    
    //_emailid.text = [newdict objectForKey:@"email"];
    _telephone.text = [newdict objectForKey:@"telephone"];
 //   if (_lbl2name == (id)[NSNull null]) {
   //     _lbl2name.text = [newdict objectForKey:@"street"];
    //}
_lbl2name.text = [newdict objectForKey:@"street"];
    _post.text = [newdict objectForKey:@"postcode"];
    _lbl3name.text = [newdict objectForKey:@"lastname"];
    NSLog(@"new shipment dict is:%@",newdict);
    NSLog(@"label text is:%@", _lblname.text);
     _lblOrderNumber.text = [orderDict objectForKey:@"increment_id"];
    NSLog(@"increment_id:%@", _lblOrderNumber);
    
    _lblOrderTotal.text = [NSString stringWithFormat:@"₹ %@(%@ item)",[[orderDict objectForKey:@"additional_data"] objectForKey:@"grand_total"],[[orderDict objectForKey:@"additional_data"] objectForKey:@"total_item_count"]];
    _lblPaymentMethod.text = [[orderDict objectForKey:@"payment"] objectForKey:@"method"];
    _grandTotal.text = [NSString stringWithFormat:@"₹ %@",[[orderDict objectForKey:@"additional_data"] objectForKey:@"grand_total"]];
    _lblTax.text = [NSString stringWithFormat:@"₹ %@",[[orderDict objectForKey:@"additional_data"] objectForKey:@"tax_amount"]];
     _lblTotal.text = [NSString stringWithFormat:@"₹ %@",[[orderDict objectForKey:@"additional_data"] objectForKey:@"base_grand_total"]];
                        
    self.tblDetailMyOrders.tableHeaderView = self.headerView;
    self.tblDetailMyOrders.tableFooterView = self.footerView;
    
    self.orderDetailsView.layer.cornerRadius = 5;
    self.orderDetailsView.clipsToBounds = YES;
    self.orderDetailsView.layer.borderWidth = 1;
    self.orderDetailsView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    self.paymentInformationView.layer.cornerRadius = 5;
    self.paymentInformationView.clipsToBounds = YES;
    self.paymentInformationView.layer.borderWidth = 1;
    self.paymentInformationView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    self.shippingAddressView.layer.cornerRadius = 5;
    self.shippingAddressView.clipsToBounds = YES;
    self.shippingAddressView.layer.borderWidth = 1;
    self.shippingAddressView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    self.orderSummaryView.layer.cornerRadius = 5;
    self.orderSummaryView.clipsToBounds = YES;
    self.orderSummaryView.layer.borderWidth = 1;
    self.orderSummaryView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    UIImage *abuttonImage1 = [UIImage imageNamed:@"back-white.png"];
    UIButton *aaButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton1 setImage:abuttonImage1 forState:UIControlStateNormal];
    aaButton1.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    UIBarButtonItem *AP_barbutton1 = [[UIBarButtonItem alloc] initWithCustomView:aaButton1];
    [aaButton1 addTarget:self action:@selector(btnapBackClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=AP_barbutton1;
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return productsArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 342.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailMyOrdersNewCell *cell = (DetailMyOrdersNewCell *) [tableView dequeueReusableCellWithIdentifier:@"detailMyOrderCell"];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DetailMyOrdersNewCell" owner:self options:nil];
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell =  (DetailMyOrdersNewCell *) currentObject;
                //                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
                UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, tableView.bounds.size.width-20, 330)];
                myView.layer.cornerRadius = 5;
                myView.clipsToBounds = YES;
                myView.layer.borderWidth = 1;
                myView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
                [cell.contentView addSubview:myView];
                
                NSDictionary *dict = [productsArray objectAtIndex:indexPath.section];
                cell.lblStatus.text = [[orderDict objectForKey:@"additional_data"] objectForKey:@"status"];
                cell.lblProductCost.text = [NSString stringWithFormat:@"₹ %@",[dict objectForKey:@"price"]];
                cell.lblQuantity.text = [dict objectForKey:@"qty_ordered"];
                cell.lblProductName.text = [NSString stringWithFormat:@"₹ %@",[dict objectForKey:@"name"]];
                
//                NSString *urlString =[NSString stringWithFormat:@"%@",[orderDict objectForKey:@"image_url"]];
//                
//                urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//                NSLog(@"prof img is %@",urlString);
//                NSURL *url = [NSURL URLWithString:urlString];
//                [cell.productImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];

            }
        }
    }
    
    return cell;
}


- (void)btnapBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
