//
//  OrdersListViewController.m
//  FingoShop
//
//  Created by kushal mandala on 27/08/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import "OrdersListViewController.h"
#import "DetailMyOrdersNewCell.h"
#import "SVProgressHUD.h"
#import "OrdersListCell.h"
#import "DetailMyOrdersNewViewController.h"

@interface OrdersListViewController ()
{
    NSMutableArray *ordersArray;
    NSString *serviceType;

}
@property (weak, nonatomic) IBOutlet UITableView *tblOrdersList;

@end

@implementation OrdersListViewController
@synthesize jsonDict;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"My Orders";
    
    UIImage *abuttonImage1 = [UIImage imageNamed:@"back-white.png"];
    UIButton *aaButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton1 setImage:abuttonImage1 forState:UIControlStateNormal];
    aaButton1.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    UIBarButtonItem *AP_barbutton1 = [[UIBarButtonItem alloc] initWithCustomView:aaButton1];
    [aaButton1 addTarget:self action:@selector(btnordersBackClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=AP_barbutton1;
    
    NSArray *array = [jsonDict allKeys];
    ordersArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<[array count]; i++) {
        NSMutableDictionary *dict = [jsonDict objectForKey:[array objectAtIndex:i]];
        [ordersArray addObject:dict];
        
      //  NSLog(@"ordersarray is %@", ordersArray)
    }
    
//    [self.tblOrdersList reloadData];
//     [self callGetOrdersService];

    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated {
//    [self callGetOrdersService];
}
- (void)btnordersBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ordersArray.count;
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
    OrdersListCell *cell = (OrdersListCell *) [tableView dequeueReusableCellWithIdentifier:@"OrdersListCell"];
      UIButton *btn;
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OrdersListCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell =  (OrdersListCell *) currentObject;
                //                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
                
                
                UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, tableView.bounds.size.width-20, 330)];
                myView.layer.cornerRadius = 5;
                myView.clipsToBounds = YES;
                myView.layer.borderWidth = 1;
                myView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
                [cell.contentView addSubview:myView];
                
                btn = [[UIButton alloc]initWithFrame:CGRectMake(cell.contentView.bounds.size.width-145, 40, 150, 50)];
                [btn setTitle:@"Cancel Order" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14] ];
                [btn addTarget:self action:@selector(btnCancelOrderClicked:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = indexPath.section;
                [cell.contentView addSubview:btn];
                
              
                
            }
        }
    }
    
//    [cell.btnCancelOrder addTarget:self action:@selector(btnCancelOrderClicked:) forControlEvents:UIControlEventTouchUpInside];
//    cell.btnCancelOrder.tag = indexPath.section;
    NSLog(@"orders array :%@",ordersArray);
    NSArray *ProductArr = [[ordersArray objectAtIndex:indexPath.section] objectForKey:@"products"] ;
    NSLog(@"product array is :%@",ProductArr);
    
//    NSDictionary *dict = [ProductArr objectAtIndex:indexPath.section];
     NSDictionary *dict = [ProductArr objectAtIndex:0];
    NSDictionary *additionalDataDict = [[ordersArray objectAtIndex:indexPath.section] objectForKey:@"additional_data"];
    
    cell.lblOrderNo.text=[NSString stringWithFormat:@"Order No : %@",[additionalDataDict objectForKey:@"increment_id"]];
    cell.lblTotalItems.text=[NSString stringWithFormat:@"Total Items(%lu)",(unsigned long)ProductArr.count];
    cell.lblDeliveryEstimate.text=[dict objectForKey:@"updated_at"];
    cell.lblStatus.text=[additionalDataDict objectForKey:@"status"];
    cell.lblQty.text=[dict objectForKey:@"qty_ordered"];
    cell.lblSoldby.text=[additionalDataDict objectForKey:@"store_name"];
    
    cell.lblGrandTotal.text=[additionalDataDict objectForKey:@"grand_total"];
    cell.ProductTitle.text=[dict objectForKey:@"name"];
    if ([[NSString stringWithFormat:@"%@",[additionalDataDict objectForKey:@"status"]] isEqualToString:@"cancel"]) {
        [btn setHidden:YES];
        cell.lblStatus.text = @"Canceled";
    }
    else{
        
        [btn setHidden:NO];                }
    
    return cell;
}

-(void)btnCancelOrderClicked:(UIButton*)sender{
    
    NSArray *ProductArr = [[ordersArray objectAtIndex:sender.tag] objectForKey:@"products"] ;
    NSDictionary *dict = [ProductArr objectAtIndex:0];
//    NSDictionary *additionalDataDict = [[ordersArray objectAtIndex:sender.tag] objectForKey:@"additional_data"];
    
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    seviceconn = [[ServiceConnection alloc]init];
    seviceconn.delegate = self;
    serviceType = @"CancelOrder";
    [seviceconn cancelOrder:[dict objectForKey:@"order_id"]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailMyOrdersNewViewController *details=[[DetailMyOrdersNewViewController alloc] initWithNibName:@"DetailMyOrdersNewViewController" bundle:nil];
    details.orderDict = [ordersArray objectAtIndex:indexPath.section];
    
    [self.navigationController pushViewController:details animated:YES];
    
}



-(void)callGetOrdersService
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    seviceconn = [[ServiceConnection alloc]init];
    seviceconn.delegate = self;
    serviceType = @"GetOrders";
    [seviceconn GetCustomerOrders];
}




#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict1
{
    if (jsonDict1 != nil) {
        if ([serviceType isEqualToString:@"GetOrders"]) {
            NSLog(@"Customer Orders: %@",jsonDict);
            NSArray *array = [jsonDict1 allKeys];
            ordersArray = [[NSMutableArray alloc] init];
            for (int i = 0; i<[array count]; i++) {
                NSMutableDictionary *dict = [jsonDict1 objectForKey:[array objectAtIndex:i]];
                [ordersArray addObject:dict];
                
            }
            [self.tblOrdersList reloadData];
        }
        else {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"FINGOSHOP"
                                         message:[jsonDict1 objectForKey:@"message"]
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            NSLog(@"jsondict1 %@",jsonDict1);
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"ok"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           //Handle your yes please button action here
                                           if ([[jsonDict1 objectForKey:@"status"] isEqualToString:@"success"]) {
                                               [self callGetOrdersService];
                                           }
                                           
                                       }];
            
            
            [alert addAction:okButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }

    }
    
    
    [SVProgressHUD dismiss];
    
}


- (void)errorMessage:(NSString *)errMsg
{
    [SVProgressHUD dismiss];
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
