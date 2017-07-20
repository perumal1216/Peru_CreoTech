//
//  SettingsViewController.m
//  FingoShop
//
//  Created by kushal mandala on 23/07/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import "SettingsViewController.h"


@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblLogout;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section==0) {
        
        return 3;
        
    }
    else if(section==1)
    {
        return 3;
    }
    else if(section==2)
    {
        return 1;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    
    
    if (indexPath.section==2) {
        
        if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
            
            _lblLogout.text=@"LOGOUT";
        }else
        {
            _lblLogout.text=@"LOGIN";

        }
       

        
    }
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%lu,%lu",indexPath.section,indexPath.row);
    
    if (indexPath.section==0) {
        
        
        switch (indexPath.row) {
            case 0:
                if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
                    
                    
                    
                }else
                {
                    
                    UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Login to Proceed" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    }]];
                    
                    [self presentViewController:alertController animated:YES completion:nil];

                    
                }

                break;
                
            case 1:
                if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
                    
                    [self performSegueWithIdentifier:@"WishList" sender:self];

                    
                }else
                {
                    UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Login to Proceed" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    }]];
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                    

                    
                    
                }
                break;

            case 2:
                if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
                    
                    
                    [self performSegueWithIdentifier:@"OrdersList" sender:self];
                    
                    
                }else
                {
                    
                    
                    UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Login to Proceed" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
                        [self.navigationController pushViewController:vc animated:YES];

                    }]];
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                    

                }

                break;

            default:
                
                break;
        }
        
        
        
    }
    else if (indexPath.section==1)
    {
        
    }
    else  if (indexPath.section==2) {
        
        if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
            
            [self.tabBarController setSelectedIndex:0];
            
            [self PerformLogout];
            
            
        }else
        {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self.navigationController pushViewController:vc animated:YES];

            
        }
        
        
        
    }
    
}

-(void)PerformLogout
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"CartCount"];

    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"logoutNotification" object:nil];
  
}




@end
