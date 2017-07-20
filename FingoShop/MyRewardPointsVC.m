//
//  MyRewardPointsVC.m
//  FingoShop
//
//  Created by Perumal on 01/05/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import "MyRewardPointsVC.h"
#import "SVProgressHUD.h"
@interface MyRewardPointsVC ()
{
    NSString *serviceType;
}
@end

@implementation MyRewardPointsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self callGetPointsBalance];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationItem.title = @"My Rewards";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)callGetPointsBalance
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    seviceconn = [[ServiceConnection alloc]init];
    seviceconn.delegate = self;
    serviceType = @"GetYourBalance";
    [seviceconn GetPointsBalance];
}

#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    if (jsonDict != nil){
        if ([serviceType isEqualToString:@"GetYourBalance"])
        {
            
            if (![[jsonDict objectForKey:@"status"] isEqualToString:@"FAIL"] ) {
                
                _balanceLabel.text = [NSString stringWithFormat:@"Your balance is %@ Points",[jsonDict objectForKey:@"total-points"]];
                
                
            
            }
            
            else{
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:ok];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }

        }
        }
    
    
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
