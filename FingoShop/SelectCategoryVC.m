//
//  SelectCategoryVC.m
//  FingoShop
//
//  Created by Perumal on 22/04/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import "SelectCategoryVC.h"
#import "DetailViewController.h"

@interface SelectCategoryVC ()
{
    NSArray *categoryArray;
    NSArray *categoryIDArray;
    
    
}
@end

@implementation SelectCategoryVC
@synthesize categoryFlag;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    categoryArray = [[NSArray alloc]init];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if ([categoryFlag isEqualToString:@"Men"]) {
        
        categoryArray = @[@"Clothing", @"Sunglasses"];
        categoryIDArray = @[@"635", @"669"];
       // Men's: Clothing - 635
       // Sunglasses - 669
    }
    else if([categoryFlag isEqualToString:@"Women"])
    {
        categoryArray = @[@"Clothing", @"Jewellery",@"Sunglasses"];
        categoryIDArray = @[@"632",@"633", @"668"];
   // Womens: Clothing - 632
     //   Sunglasses - 668
       // Jewellery - 633
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return categoryArray.count;
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
   
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[categoryArray objectAtIndex:indexPath.row]];
    
    return cell;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if ([categoryFlag isEqualToString:@"Men"]) {
        
        
            NSString *selectedItemID;
            NSString *selectedItemType;
            selectedItemID =[NSString stringWithFormat:@"%@",[categoryIDArray objectAtIndex:indexPath.row]];
             selectedItemType = @"Mens";
            NSLog(@"%@",selectedItemID);
            _WSConstScreenValue = @"Home";
            _WSConstSelectedCategoryID = selectedItemID;
             _WSConstSelectedCategoryType = selectedItemType;
            // [self performSegueWithIdentifier:@"detailSegue" sender:self];
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            DetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
             vc.navigationFlag = @"Men";
            [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    else if([categoryFlag isEqualToString:@"Women"])
    {
        NSString *selectedItemID;
        NSString *selectedItemType;
        selectedItemID =[NSString stringWithFormat:@"%@",[categoryIDArray objectAtIndex:indexPath.row]];
        selectedItemType = @"Womens";
        NSLog(@"%@",selectedItemID);
        _WSConstScreenValue = @"Home";
        _WSConstSelectedCategoryID = selectedItemID;
        _WSConstSelectedCategoryType = selectedItemType;
        // [self performSegueWithIdentifier:@"detailSegue" sender:self];
      //  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        DetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        
         vc.navigationFlag = @"Women";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
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
