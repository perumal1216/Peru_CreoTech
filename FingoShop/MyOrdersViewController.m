//
//  MyOrdersViewController.m
//  FingoShop
//
//  Created by Rambabu Mannam on 25/04/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import "MyOrdersViewController.h"
#import "MyOrdersCell.h"
#import "SVProgressHUD.h"
#import "DetailMyOrdersNewViewController.h"
@interface MyOrdersViewController ()
{
    NSMutableArray *ordersArray;
    
}
- (IBAction)btnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblMyOrders;

@end

@implementation MyOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self callGetOrdersService];
  }

-(void)viewWillAppear:(BOOL)animated {
//    [self callGetOrdersService];
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [ordersArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = [[ordersArray objectAtIndex:section] objectForKey:@"products"];
    return [dict count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                 CGRectMake(0, 0, tableView.frame.size.width, 50.0)];
    sectionHeaderView.backgroundColor = [UIColor colorWithRed:223/255.0 green:231/255.0 blue:235/255.0 alpha:1];
    
    UILabel *headerLabel1 = [[UILabel alloc] initWithFrame:
                            CGRectMake(10,5,90, 25.0)];
    
    UILabel *headerLabel2 = [[UILabel alloc] initWithFrame:
                            CGRectMake(90,5, 140, 25.0)];
    
    UILabel *headerLabel3 = [[UILabel alloc] initWithFrame:
                            CGRectMake(10,20, 200, 25.0)];
    
    headerLabel1.backgroundColor = [UIColor clearColor];
    headerLabel2.backgroundColor = [UIColor clearColor];
    headerLabel3.backgroundColor = [UIColor clearColor];
   
    
    [headerLabel1 setFont:[UIFont fontWithName:@"Verdana" size:14.0]];
    [headerLabel2 setFont:[UIFont fontWithName:@"Verdana" size:14.0]];
    [headerLabel3 setFont:[UIFont fontWithName:@"Verdana" size:13.0]];
    
    headerLabel1.text = @"ORDER NO. ";
    headerLabel2.text = [[ordersArray objectAtIndex:section] objectForKey:@"increment_id"];
    NSString *dateString = [[ordersArray objectAtIndex:section] objectForKey:@"order_date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"EEE, dd MMM YY HH:mma"];
    headerLabel3.text = [dateFormatter1 stringFromDate:date];
//    NSString *dateString =  @"2014-10-07T07:29:55.850Z";2016-08-23 23:40:20
    
//    headerLabel3.text = @"Sat, 25th Jun'16 at 11.20pm";

    
    [sectionHeaderView addSubview:headerLabel1];
    [sectionHeaderView addSubview:headerLabel2];
    [sectionHeaderView addSubview:headerLabel3];
    
    
    return sectionHeaderView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myordersCell"];
    if (cell == nil)
    {
        cell = [[MyOrdersCell alloc]initWithFrame:CGRectZero];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

    }
     NSArray *arr = [[ordersArray objectAtIndex:indexPath.section] objectForKey:@"products"] ;
    NSDictionary *dict = [arr objectAtIndex:indexPath.row];
     NSDictionary *dict1 = [[ordersArray objectAtIndex:indexPath.section] objectForKey:@"additional_data"];
    cell.productName.text = [dict objectForKey:@"name"];
    cell.status.text = [dict1 objectForKey:@"status"];
    if ([[dict1 objectForKey:@"status"] isEqualToString:@"pending"]) {
        cell.deliveredDate.hidden = YES;
    }
    else {
        cell.deliveredDate.hidden = NO;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        DetailMyOrdersNewViewController *details=[[DetailMyOrdersNewViewController alloc] initWithNibName:@"DetailMyOrdersNewViewController" bundle:nil];
        details.orderDict = [ordersArray objectAtIndex:indexPath.section];

    [self.navigationController pushViewController:details animated:YES];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (IBAction)btnBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(void)callGetOrdersService
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress

    seviceconn = [[ServiceConnection alloc]init];
    seviceconn.delegate = self;
    [seviceconn GetCustomerOrders];
}



#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    
    NSLog(@"Customer Orders: %@",jsonDict);
    NSArray *array = [jsonDict allKeys];
    ordersArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<[array count]; i++) {
        NSMutableDictionary *dict = [jsonDict objectForKey:[array objectAtIndex:i]];
        [ordersArray addObject:dict];
        
    }
    [self.tblMyOrders reloadData];
    
    [SVProgressHUD dismiss];
    
}


- (void)errorMessage:(NSString *)errMsg
{
    
    [SVProgressHUD dismiss];
}


@end
