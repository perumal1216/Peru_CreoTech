//
//  TopBarNavigationVC.m
//  FingoShop
//
//  Created by Perumal on 11/06/17.
//  Copyright © 2017 Perumal. All rights reserved.
//

#import "TopBarNavigationVC.h"
#import <QuartzCore/QuartzCore.h>
//#import "DealCell.h"
#import "UIViewController+ECSlidingViewController.h"
#import "MEDynamicTransition.h"
#import "METransitions.h"
@interface TopBarNavigationVC ()

@end


@implementation TopBarNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //  myTextField.rightViewMode = UITextFieldViewModeAlways;
    _searchTextField.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
    _searchTextField.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    _searchTextField.layer.shadowOpacity = 1;
    _searchTextField.layer.shadowRadius = 0.0;
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
  _searchTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sideMenuButtonClicked:(id)sender {
    
    ECSlidingViewController *slidingViewController = self.slidingViewController;
    if (slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight) {
        [slidingViewController resetTopViewAnimated:YES];
        [self.view setUserInteractionEnabled:YES];
    } else {
        [slidingViewController anchorTopViewToRightAnimated:YES];
        [self.view setUserInteractionEnabled:YES];
    }
}

#pragma mark - Buttons Clicked


- (IBAction)backButtonClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnCartClicked:(id)sender {
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
            
            [self performSegueWithIdentifier:@"loginSegue" sender:self];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }

    
    
}
- (IBAction)btnVirtualShoppingClicked:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VirtualShoppingVC"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)btnWishlistClicked:(id)sender {
    
    // [self performSegueWithIdentifier:@"WishList" sender:self];
   UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WishListViewController"];
    [self.navigationController pushViewController:vc animated:YES];
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
