//
//  SearchViewController.m
//  FingoShop
//
//  Created by Rambabu Mannam on 20/10/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCell.h"
#import "SVProgressHUD.h"
#import "Constants.h"
#import "UIViewController+HeaderContainer.h"
#import "TopBarNavigationVC.h"
#import "FingoShopTags.pch"


@interface SearchViewController ()
{
    UIBarButtonItem *AP_barbutton1,*AP_barbutton2;

}
@property (weak, nonatomic) IBOutlet UITextField *txtfldSearch;

@end

@implementation SearchViewController
@synthesize search_string;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *abuttonImage1 = [UIImage imageNamed:@"back-white.png"];
    UIButton *aaButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton1 setImage:abuttonImage1 forState:UIControlStateNormal];
    aaButton1.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    AP_barbutton1 = [[UIBarButtonItem alloc] initWithCustomView:aaButton1];
    [aaButton1 addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *aaButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton2 setTitle:@"Done" forState:UIControlStateNormal];
    aaButton2.frame = CGRectMake(0.0, 0.0, 50.0, 36.0);
    AP_barbutton2 = [[UIBarButtonItem alloc] initWithCustomView:aaButton2];
    [aaButton2 addTarget:self action:@selector(btnDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItems =
    [NSArray arrayWithObjects:AP_barbutton1, nil];
    
    self.navigationItem.rightBarButtonItems =
    [NSArray arrayWithObjects:AP_barbutton2, nil];
    
    self.txtfldSearch.layer.borderWidth = 1;
    self.txtfldSearch.layer.cornerRadius = 5;
    self.txtfldSearch.clipsToBounds = YES;
    
    // TopBar Navigation
    TopBarNavigationVC *topVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TopBarNavigationVC"];
    [self displayContentController:topVC];
    [topVC.menu_button setHidden :YES];
    [topVC.back_button setHidden :NO];
    
    [self searchandlerMethod :search_string];
    
}
-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Buttons Methods

-(void)searchandlerMethod:(NSString *)searchStr
{
    [APPDELEGATE showCustomLoader:self]; // Progress
    
    NSString * post = searchStr;
    
    
    serviceConn = [[ServiceConnection alloc]init];
    serviceConn.delegate = self;
    
    [serviceConn GetSearchList:post];
    
}

- (void)btnBackClicked:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnDoneClicked:(id)sender
{
    
    [APPDELEGATE showCustomLoader:self]; // Progress
    
    NSString * post = _txtfldSearch.text;
    
    
    serviceConn = [[ServiceConnection alloc]init];
    serviceConn.delegate = self;
    
    [serviceConn GetSearchList:post];
    //[self.conn cancel];
    
}

#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    
    [APPDELEGATE removeCustomLoader:self];
    if (jsonDict) {
        _searchFiltersProductsArray = [jsonDict objectForKey:@"products"];
        if ([_searchFiltersProductsArray count] > 0) {
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
            _WSConstScreenValue = @"Search";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"FIGOSHOP"
                                         message:@"Please Specify a Product"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                        }];
            
            
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
    
    
    
}


- (void)errorMessage:(NSString *)errMsg
{
    [APPDELEGATE removeCustomLoader:self];
}




@end
