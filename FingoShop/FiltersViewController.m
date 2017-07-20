//
//  FiltersViewController.m
//  FingoShop
//
//  Created by SkoopView on 26/07/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import "FiltersViewController.h"
#import "Constants.h"
#import "SVProgressHUD.h"

@interface FiltersViewController ()
{
    NSArray *mainCategoryArray;
    NSInteger indexVAl;
    NSMutableArray *subCategoryArray;
    NSMutableArray *filteredArray;
}
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnApply;
- (IBAction)btnClearAllClicked:(id)sender;
- (IBAction)btnApplyClicked:(id)sender;

@end

@implementation FiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    filteredArray = [[NSMutableArray alloc] init];
    indexVAl = 0;
    subCategoryArray = [NSMutableArray new];
    mainCategoryArray = [_availableFiltersDict allKeys];
    NSString *str = [mainCategoryArray objectAtIndex:0];
    subCategoryArray = [[[_availableFiltersDict objectForKey:str] objectForKey:@"options"]mutableCopy];
    


    
    [self.btnApply setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView)
    {
        return mainCategoryArray.count;
    }
    else
    {
        return subCategoryArray.count;

    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
    }
    
    if (tableView == self.mainTableView)
    {
        cell.textLabel.text = [mainCategoryArray objectAtIndex:indexPath.row];
        [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
        cell.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        if (indexVAl == indexPath.row)
        {
            cell.textLabel.textColor = [UIColor redColor];
        }
        
    }
    else
    {
        NSString *str = [[subCategoryArray objectAtIndex:indexPath.row] objectForKey:@"label"];
        cell.textLabel.text = str;
        [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
        if ([filteredArray containsObject:str]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }

        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView)
    {
        indexVAl = indexPath.row;
        [subCategoryArray removeAllObjects];
        NSString *str = [mainCategoryArray objectAtIndex:indexPath.row];
        subCategoryArray = [[[_availableFiltersDict objectForKey:str] objectForKey:@"options"] mutableCopy];
        [self.mainTableView reloadData];
        [self.subTableView reloadData];
        
    }
    else
    {
        if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
            NSString *str = [[subCategoryArray objectAtIndex:indexPath.row] objectForKey:@"label"];
            
                if ([filteredArray containsObject:str]) {
                    [filteredArray removeObject:str];
                }
            
            
        }else{
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
            [filteredArray addObject:[[subCategoryArray objectAtIndex:indexPath.row] objectForKey:@"label"]];
        }
    }
        
   

}

#pragma mark - UIButton Action Methods

- (IBAction)btnClearAllClicked:(id)sender
{
    [filteredArray removeAllObjects];
    indexVAl = 0;
    [subCategoryArray removeAllObjects];
    NSString *str = [mainCategoryArray objectAtIndex:0];
    subCategoryArray = [[[_availableFiltersDict objectForKey:str] objectForKey:@"options"] mutableCopy];
    [self.subTableView reloadData];
    [self.mainTableView reloadData];
}

- (IBAction)btnApplyClicked:(id)sender
{

    
}


@end
