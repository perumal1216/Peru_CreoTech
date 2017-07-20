//
//  SortViewController.m
//  FingoShop
//
//  Created by rizenew on 5/17/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import "SortViewController.h"
#import "Constants.h"

@interface SortViewController ()
{
    
   
    
}
@end

@implementation SortViewController
@synthesize filterFlag,sortOptionsArray,available_filterDict;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([filterFlag isEqualToString:@"Filter"])
    {
       // [available_filterDict allKeys];
        NSLog(@"======%lu====", (unsigned long)[[available_filterDict allKeys] count]);
        
       
        
        
         NSDictionary *keys =[available_filterDict objectForKey:@"avaulable_filters"];
        
        if ([keys count] == 2) {
            
            NSDictionary *price_dict=[available_filterDict valueForKeyPath:@"avaulable_filters.price"];
            NSDictionary *vesbrand_dict=[available_filterDict valueForKeyPath:@"avaulable_filters.vesbrand"];
            
           sortOptionsArray = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",[price_dict valueForKey:@"label"]],[NSString stringWithFormat:@"%@",[vesbrand_dict valueForKey:@"label"]],nil];
        }
        else{
            
            NSDictionary *price_dict=[available_filterDict valueForKeyPath:@"avaulable_filters.price"];
            NSDictionary *vesbrand_dict=[available_filterDict valueForKeyPath:@"avaulable_filters.vesbrand"];
             NSDictionary *ves_size_dict=[available_filterDict valueForKeyPath:@"avaulable_filters.ves_size"];
            
            sortOptionsArray = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",[price_dict valueForKey:@"label"]],[NSString stringWithFormat:@"%@",[vesbrand_dict valueForKey:@"label"]],[NSString stringWithFormat:@"%@",[ves_size_dict valueForKey:@"label"]],nil];
            
        }
        
//         NSDictionary *filtersarr=[resultsDict valueForKeyPath:@"avaulable_filters.price"];
//         
//         NSLog(@"=====%@====",[filtersarr valueForKey:@"label"]);
//         
//         NSArray *optionsArray = [[resultsDict valueForKeyPath:@"avaulable_filters.vesbrand"] valueForKey:@"options"];
//         
        

        
        
    }
    else{
        
          sortOptionsArray = [[NSArray alloc]initWithObjects:@"Price - High to Low",@"Price - Low to High",@"Position", nil];
    }
    
  
  
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sortOptionsArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        
    }
    if ([filterFlag isEqualToString:@"Filter"])
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[sortOptionsArray objectAtIndex:indexPath.row]];
        //[NSString stringWithFormat:@"%@", [[sortOptionsArray objectAtIndex:indexPath.row] objectForKey:@"label"]];
       
        
        
    }
    else{
       cell.textLabel.text = [NSString stringWithFormat:@"%@",[sortOptionsArray objectAtIndex:indexPath.row]];
    }
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
//    if ([filterFlag isEqualToString:@"Filter"])
//    {
//       
//    }else{
    
        _backNavigationSortOption = @"Sorted";
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"sortProductList" object:[sortOptionsArray objectAtIndex:indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
   // }
    
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
