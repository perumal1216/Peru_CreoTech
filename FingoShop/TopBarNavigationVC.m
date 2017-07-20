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
- (IBAction)backButtonClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
