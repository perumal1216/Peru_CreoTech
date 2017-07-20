//
//  ShippingMethodViewController.m
//  FingoShop
//
//  Created by Rambabu Mannam on 01/06/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import "ShippingMethodViewController.h"
#import "SVProgressHUD.h"
#import "Constants.h"
#import "ShippingMethodCellCell.h"

@interface ShippingMethodViewController ()
@property(strong,nonatomic)NSMutableArray *shippingMethodsArr;
@property (weak, nonatomic) IBOutlet UITableView *tblShippingMethod;
- (IBAction)backClicked:(id)sender;

@end

@implementation ShippingMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self callShipmentDetails];
}

#pragma mark - ServiceConnection Methods

-(void)callShipmentDetails
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"ShipmentDetails";
    
    [serviceconn GetShipmentDetails];
}


#pragma mark - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _shippingMethodsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShippingMethodCellCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[ShippingMethodCellCell alloc]initWithFrame:CGRectZero];
    }
    
    
    NSMutableDictionary *selectedDict=[_shippingMethodsArr objectAtIndex:indexPath.row];
    
    cell.shippingTitle.text=[selectedDict objectForKey:@"title"];
    cell.shippingPrice.text=[NSString stringWithFormat:@"₹ %@",[selectedDict objectForKey:@"price"]];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *selectedDict=[_shippingMethodsArr objectAtIndex:indexPath.row];
    _SelectedShipmentName=[selectedDict objectForKey:@"title"];
    _SelectedShipmentPrice=[NSString stringWithFormat:@"%@",[selectedDict objectForKey:@"price"]];
    _SelectedShipmentCode=[selectedDict objectForKey:@"shipping_method_code"];

    [self saveShipmentDetails];
    
    
}


-(void)saveShipmentDetails
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"SaveShipmentDetails";
    
    [serviceconn SaveShipmentDetails:_SelectedShipmentCode];
}




#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    
    [SVProgressHUD dismiss];
    
    if ([ServiceType isEqualToString:@"ShipmentDetails"]) {
        NSLog(@"Shiment : %@",jsonDict);
        _shippingMethodsArr=[[NSMutableArray alloc] init];
        
        
        if (jsonDict.count) {
            NSArray *keys=[jsonDict allKeys];
            
            for (int i=0; i<keys.count; i++) {
                NSMutableDictionary *dict=[jsonDict objectForKey:[keys objectAtIndex:0]];
                
                [_shippingMethodsArr addObject:dict];
                
            }
            
            NSLog(@"shipping arr %@",_shippingMethodsArr);
            
            
            [_tblShippingMethod reloadData];

        }
        
    }
    else if ([ServiceType isEqualToString:@"SaveShipmentDetails"])
    {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
}


- (void)errorMessage:(NSString *)errMsg
{
    [SVProgressHUD dismiss];
}



- (IBAction)backClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
