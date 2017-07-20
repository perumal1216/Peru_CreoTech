//
//  DetailViewController.m
//  FingoShop
//
//  Created by fis on 26/06/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import "DetailViewController.h"
#import "ItemCell.h"
#import "UIViewController+ECSlidingViewController.h"
#import "ProductDetailVC.h"
#import "UIImageView+WebCache.h"
#import "ProductDetailVC.h"
#import "Constants.h"
#import "SVProgressHUD.h"
#import "UIView+Toast.h"
#import "AppDelegate.h"
#import "Cart.h"
#import "UIBarButtonItem+Badge.h"
#import "Constants.h"
#import "ProductDetailNewVC.h"
#import "VirtualDetailsVC.h"
#import "SortViewController.h"


#define IS_IPHONE5 ( [ [ UIScreen mainScreen ] bounds ].size.height == 568 )
#define IS_IPHONE6 ( [ [ UIScreen mainScreen ] bounds ].size.height == 667 )
#define IS_IPHONE6S ( [ [ UIScreen mainScreen ] bounds ].size.height == 736 )
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds ].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds ].size.height


@interface DetailViewController ()
{
    NSMutableArray *boolArray;
    NSInteger indexVal;
    NSInteger selectedindexVal;
    UIBarButtonItem *AP_barbutton1,*AP_barbutton2,*AP_barbutton3,*AP_barbutton4;
    NSDictionary *selectedProduct;
    NSMutableDictionary *avaulable_filter_Dict;
    NSMutableArray *avaulable_filters_array;
    
    
}
- (IBAction)btnMenuClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *Detail_collecVW;
@property(nonatomic,strong) NSMutableArray *Images_arr,*Name_arr,*NewPrice_arr,*oldPrice_arr,*Offer_arr;
@property(nonatomic,strong) NSMutableArray *itemsListArr;
@property(nonatomic,strong) NSMutableDictionary *selectedItemDict;

@end

@implementation DetailViewController
@synthesize navigationFlag;
AppDelegate *apdl_detail;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotification) name:@"logoutNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sortProductListAction:) name:@"sortProductList" object:nil];
    
    apdl_detail=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    receivedData=[NSMutableData data];
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
    lbl.textColor=[UIColor whiteColor];
    lbl.text=@"FINGOSHOP";
    [view addSubview:lbl];
    
    self.navigationItem.titleView = view;
    
    page=0;
    
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  /*  let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
    layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    collectionView!.collectionViewLayout = layout
   */
    
    NSLog(@"====%f=====%f",SCREEN_WIDTH,SCREEN_HEIGHT);
    [layout setItemSize:CGSizeMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT - 114)/2)];
    [layout setSectionInset:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [layout setMinimumInteritemSpacing:0.0];
    [layout setMinimumLineSpacing:0.0];
    [self.Detail_collecVW setCollectionViewLayout:layout];
    
    /*
   
    if (IS_IPHONE6) {
        [layout setItemSize:CGSizeMake(177.0, 300.0)];
        
    }else if(IS_IPHONE6S)
    {
        [layout setItemSize:CGSizeMake(197.0, 300.0)];
    }
    else
    {
        [layout setItemSize:CGSizeMake(150.0, 300.0)];
    }
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //[layout setSectionInset:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
    //[layout setMinimumInteritemSpacing:5.0];
    */
    
   
    
    UIImage *abuttonImage1 = [UIImage imageNamed:@"filter_30.png"];
    UIButton *aaButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton1 setImage:abuttonImage1 forState:UIControlStateNormal];
    aaButton1.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    AP_barbutton1 = [[UIBarButtonItem alloc] initWithCustomView:aaButton1];
    
    [aaButton1 setTintColor:[UIColor whiteColor]];
    [aaButton1 addTarget:self action:@selector(btnFilterClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *abuttonImage2 = [UIImage imageNamed:@"ic_cart.png"];
    UIButton *aaButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton2 setImage:abuttonImage2 forState:UIControlStateNormal];
    aaButton2.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    AP_barbutton2 = [[UIBarButtonItem alloc] initWithCustomView:aaButton2];
    
    [aaButton2 addTarget:self action:@selector(btnCartClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImage *abuttonImage3 = [UIImage imageNamed:@"ic_search_white_1x.png"];
    UIButton *aaButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton3 setImage:abuttonImage3 forState:UIControlStateNormal];
    aaButton3.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    AP_barbutton3 = [[UIBarButtonItem alloc] initWithCustomView:aaButton3];
    [aaButton3 addTarget:self action:@selector(btnSearchClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *abuttonImage4 = [UIImage imageNamed:@"ic_vs.png"];
    UIButton *aaButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton4 setImage:abuttonImage4 forState:UIControlStateNormal];
    aaButton4.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    AP_barbutton4 = [[UIBarButtonItem alloc] initWithCustomView:aaButton4];
    [aaButton4 addTarget:self action:@selector(btnVirtualShopping:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItems =
    [NSArray arrayWithObjects:AP_barbutton2,AP_barbutton4,AP_barbutton3,nil];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if ([_WSConstScreenValue isEqualToString:@"Search"]) {
        
        _itemsListArr=[[NSMutableArray alloc]init];
        [_itemsListArr addObjectsFromArray:_searchFiltersProductsArray];
    }
    else {
        
        if ([_backNavigationSortOption isEqualToString:@"Sorted"]) {
            
            _backNavigationSortOption = @"";
            
        }
        else{
            
            [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack];
            // Dispatch a block of code to a background queue
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
            dispatch_async(queue, ^{
                // Do initialisation in the background
                /*dispatch_sync(dispatch_get_main_queue(), ^{
                 // Set progress indicator to complete?
                 [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack];
                 });
                 
                 */
                
                
                //  NSLog(@" call product list:%@",   )
                
                NSLog(@"selected category id:%@", _WSConstSelectedCategoryID);
                // Call back to the main queue if you want to update any UI when you are done
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self callProductListService:_WSConstSelectedCategoryID];
                    // Set progress indicator to complete?
                    [_Detail_collecVW reloadData];
                    [SVProgressHUD dismiss];
                });
            });
        }
        
        
        [self CheckCart];
        }
        
        
        
        

    
}

-(void)logoutNotification {
    [self CheckCart];
    
}


#pragma mark - UICollectionView Delegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    NSLog(@"itemsListArr is %@",_itemsListArr);
    return _itemsListArr.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"itemCell" forIndexPath:indexPath];
    if (cell==nil)
    {
        cell=[[ItemCell alloc]initWithFrame:CGRectZero];
        
        cell.layer.borderWidth=2;
        cell.layer.borderColor=[UIColor blackColor].CGColor;
        
    }
    
    
    cell.btnLike.tag=indexPath.item;
    [cell.btnLike addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableDictionary *itemDict=[_itemsListArr objectAtIndex:indexPath.row];
    
    if ([[itemDict objectForKey:@"is_in_wishlist"]integerValue] == 1) {
        [cell.btnLike setSelected: YES];
    }
    else {
        [cell.btnLike setSelected: NO];
        
    }
    
    NSString *urlString =[NSString stringWithFormat:@"%@",[itemDict objectForKey:@"image_url"]];
    
    urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"prof img is %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    [cell.imageVW sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
    
    
    
    //    cell.imageVW.image=[_Images_arr objectAtIndex:indexPath.row];
    cell.Name_lbl.text=[itemDict objectForKey:@"name"];
    cell.newprice_lbl.text=[NSString stringWithFormat:@"₹%@",[itemDict objectForKey:@"final_price"]];
    cell.oldPrice_lbl.text=[NSString stringWithFormat:@"₹%@",[itemDict objectForKey:@"price"]];
    cell.off_lbl.text=[NSString stringWithFormat:@"%@ off",[itemDict objectForKey:@"discount"]];
    
    
    
    NSAttributedString * title =
    [[NSAttributedString alloc] initWithString:cell.oldPrice_lbl.text
                                    attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
    [cell.oldPrice_lbl setAttributedText:title];
    
    
   /* if ([[itemDict objectForKey:@"reviews_count"] isEqual:[NSNull null]]) {
        cell.lblReviewsCount.text=@"( 0 )";
        
    }
    else
    {
        cell.lblReviewsCount.text=[NSString stringWithFormat:@"( %@ )",[itemDict objectForKey:@"reviews_count"]];
        
    }
    
    if ([[itemDict objectForKey:@"is_in_stock"] intValue]== 1) {
        cell.lblAvailability.text=@"In Stock";
        
    }
    else
    {
        cell.lblAvailability.text=@"Sold out";
        
    }
    
    cell.lblSeller.text=[NSString stringWithFormat:@"Seller : %@",[itemDict objectForKey:@"seller_info"]];
    
    */
    
    cell.layer.borderWidth = 0.3;
    cell.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([navigationFlag isEqualToString:@"Men"] ||[navigationFlag isEqualToString:@"Women"] ) {
        
        navigationFlag = @"";
        
        selectedProduct = [_itemsListArr objectAtIndex:indexPath.row];
        [self callVirtualDetailsService:[selectedProduct objectForKey:@"entity_id"]];
        
        NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:selectedProduct];
        [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:@"SelectedProduct"];
        [[NSUserDefaults standardUserDefaults] synchronize];
   // [[NSUserDefaults standardUserDefaults] setObject:selectedProduct forKey:@"SelectedProduct"];
              //  [[NSUserDefaults standardUserDefaults] synchronize];

        
    }
    else
    {
    
    [self callProductDetailsService:[[_itemsListArr objectAtIndex:indexPath.row] objectForKey:@"entity_id"]];
    selectedProduct = [_itemsListArr objectAtIndex:indexPath.row];
    NSLog(@"selected product is %@",selectedProduct);
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ProductDetail"]) {
        ProductDetailVC *mvc=[segue destinationViewController];
        mvc.productDetailsDict = [selectedProduct mutableCopy];
        
        mvc.productDetailsDict1 = [_selectedProductDict mutableCopy];
    }
    else if ([segue.identifier isEqualToString:@"ProductDetail1"]) {
        ProductDetailNewVC *mvc=[segue destinationViewController];
        mvc.productDetailsDict = [selectedProduct mutableCopy];
        mvc.productDetailsDict1 = [_selectedProductDict mutableCopy];
    }
    
}


#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
    NSLog(@"%@",response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
    NSLog(@"getting data");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [SVProgressHUD dismiss];
    
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"%@",jsonDict);
    if (error!=nil)
    {
        NSLog(@"JSON Parsing Error %@",[error localizedDescription]);
    }
    else {
        if ([_availableFiltersDict count]>0) {
            [_availableFiltersDict removeAllObjects];
        }
        _availableFiltersDict = [[jsonDict objectForKey:@"avaulable_filters"] mutableCopy];
    }
}



#pragma mark - Button Action Methods
- (IBAction)filterButtonAction:(id)sender
{
    
  /*  UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"FingoShop" message:@"still working on "preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    */
    
//
   // NSLog(@"======%@",avaulable_filters_array);
    SortViewController *sortvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SortViewController"];
    
    sortvc.filterFlag = @"Filter";
    sortvc.available_filterDict = avaulable_filter_Dict;
    
    [self.navigationController pushViewController:sortvc animated:YES];
    
    
}


- (IBAction)sortButtonAction:(id)sender
{
    SortViewController *sortvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SortViewController"];
    
     sortvc.filterFlag = @"Sorted";
    
    [self.navigationController pushViewController:sortvc animated:YES];
   // [self.navigationController presentViewController:vc animated:YES completion:nil];
}


-(void)yourButtonClicked:(UIButton*)sender
{
    indexVal=sender.tag;
    
    if(apdl_detail.net == 0)
    {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:apdl_detail.alertTTL message:apdl_detail.alertMSG preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    else if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
        
        
        NSMutableDictionary *selectedItemDict=[_itemsListArr objectAtIndex:indexVal];
        
        
        if ([[selectedItemDict objectForKey:@"is_in_wishlist"] integerValue] == 1)
        {
            
//            [self callRemoveFromWishListService:[[_itemsListArr objectAtIndex:indexVal] objectForKey:@"item_id"]];
            UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"This Product is already in your wish list" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];

            
        }
        else
        {
            
            [self callAddToWishListService:[[_itemsListArr objectAtIndex:indexVal] objectForKey:@"entity_id"]];
            
        }
        
        
        
        
    }
    else
    {
        
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"Failed" message:@"Please login before adding item to your wishlist" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
    
    [self.Detail_collecVW reloadData];
    
    
}



- (IBAction)btnMenuClicked:(id)sender
{
    ECSlidingViewController *slidingViewController = self.slidingViewController;
    if (slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight) {
        [slidingViewController resetTopViewAnimated:YES];
    } else {
        [slidingViewController anchorTopViewToRightAnimated:YES];
    }
    
}

- (IBAction)btnBackClicked:(id)sender {
    
    if ([_WSConstScreenValue isEqualToString:@"Home"] || [_WSConstScreenValue isEqualToString:@"Offers"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeTabBarController"];
        [self.slidingViewController resetTopViewAnimated:YES];
    }
    
}
-(void)btnVirtualShopping:(id)sender
{
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VirtualShoppingVC"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)btnSearchClicked:(id)sender
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnFilterClicked:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FiltersViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)btnCartClicked:(id)sender
{
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
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self.navigationController pushViewController:vc animated:YES];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}

-(BOOL)checkCartIsEmpty
{
    
    Cart *cart = [Cart singleInstance];
    
    if (cart.positions.count>0) {
        return YES;
        
    }
    
    
    return NO;
}


-(void)CheckCart
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
        AP_barbutton2.badgeValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"CartCount"];
        
    }
    else {
        AP_barbutton2.badgeValue = 0;
    }
    
}




#pragma  mark - UIScrollView Delegate Method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([_WSConstScreenValue isEqualToString:@"Home"]) {
        
        
        if(self.Detail_collecVW.contentOffset.y >= (self.Detail_collecVW.contentSize.height - self.Detail_collecVW.bounds.size.height))
        {
            
            NSLog(@"scroll did reached down");
            if(isPageRefreshing==NO){
                isPageRefreshing=YES;
                page=page+1;
                
                [self callProductListServiceWithPage:_WSConstSelectedCategoryID page:page];
                
                NSLog(@"called %lu",page);
                
            }
        }
    }
}

#pragma  mark - ServiceConnection Methods


-(void)sortProductListAction:(NSNotification *)findStr
{
   
    NSString *userInfo = [findStr object];
    NSString *order ;
    NSString *direction;
    
    if ([userInfo isEqualToString:@"Price - High to Low"]) {
        
        order = @"price";
        direction  = @"desc";
    }
    else if ([userInfo isEqualToString:@"Price - Low to High"])
    {
        order = @"price";
        direction  = @"asc";
    }
    else if ([userInfo isEqualToString:@"Position"])
    {
        order = @"position";
        direction  = @"desc";
    }
    

    
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack];
    // Dispatch a block of code to a background queue
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        // Do initialisation in the background
        /*dispatch_sync(dispatch_get_main_queue(), ^{
         // Set progress indicator to complete?
         [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack];
         });
         
         */
        
        
        //  NSLog(@" call product list:%@",   )
        
        NSLog(@"selected category id:%@", _WSConstSelectedCategoryID);
        // Call back to the main queue if you want to update any UI when you are done
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self callProductListService:_WSConstSelectedCategoryID];
            
            [self callSortProductListService:_WSConstSelectedCategoryID order:order dir:direction];
            // Set progress indicator to complete?
            [_Detail_collecVW reloadData];
            [SVProgressHUD dismiss];
        });
    });
    
    
//    if(userInfo.("Price - High to Low")){
//        Intent intent = new Intent(SortingListActivity.this, ProductList.class);
//        intent.putExtra("dir", "desc");
//        intent.putExtra("order", "price");
//        intent.putExtra("prodId", prodId);
//        startActivity(intent);
//    }else if(sortSelection.equalsIgnoreCase("Price - Low to High")){
//        Intent intent = new Intent(SortingListActivity.this, ProductList.class);
//        intent.putExtra("dir", "asc");
//        intent.putExtra("order", "price");
//        intent.putExtra("prodId", prodId);
//        startActivity(intent);
//    }else if(sortSelection.equalsIgnoreCase("Position")){
//        Intent intent = new Intent(SortingListActivity.this, ProductList.class);
//        intent.putExtra("order", "position");
//        intent.putExtra("dir", "desc");
//        intent.putExtra("prodId", prodId);
//        startActivity(intent);
//    }
    
    
}

-(void)callVirtualDetailsService :(NSString *)ProductId
{
    
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceConn = [[ServiceConnection alloc]init];
    serviceConn.delegate = self;
    serviceType=@"Virtual_Shopping";
    [serviceConn GetVirtualImage:ProductId];
    
}


-(void)callProductListService :(NSString *)CategoryId
{
    
    if(apdl_detail.net == 0)
    {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:apdl_detail.alertTTL message:apdl_detail.alertMSG preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        return;
    }
    
    
    NSString *url_str1=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/index/getCategoryProductsList?id=%@&sid=%@",CategoryId,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSString *url_str = [url_str1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:url_str];
    
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    NSError *error;
    NSMutableDictionary *resultsDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    
    avaulable_filter_Dict = resultsDict;
    
   /* avaulable_filter_Dict =[resultsDict objectForKey:@"avaulable_filters"];
    NSDictionary *filtersarr=[resultsDict valueForKeyPath:@"avaulable_filters.price"];
    
    NSLog(@"=====%@====",[filtersarr valueForKey:@"label"]);
    
    NSArray *optionsArray = [[resultsDict valueForKeyPath:@"avaulable_filters.vesbrand"] valueForKey:@"options"];
    
    */

    NSMutableArray *productsarr=[resultsDict objectForKey:@"products"];
    
    _itemsListArr=[[NSMutableArray alloc]init];
    [_itemsListArr addObjectsFromArray:productsarr];
   
    
    
}

-(void)callSortProductListService :(NSString *)prodId order :(NSString *)order dir :(NSString *)dir
{
   // intent.putExtra("dir", "asc");
   // intent.putExtra("order", "price");
   // intent.putExtra("prodId", prodId);
    if(apdl_detail.net == 0)
    {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:apdl_detail.alertTTL message:apdl_detail.alertMSG preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        return;
    }
    
    
    NSString *url_str1=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/index/getCategoryProductsList?id=%@&sid=%@&order=%@&dir=%@",prodId,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"],order,dir];
    
    NSString *url_str = [url_str1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:url_str];
    
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    NSError *error;
    NSMutableDictionary *resultsDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    
    //   NSMutableArray *filtersarr=[resultsDict objectForKey:@"avaulable_filters"];
    NSMutableArray *productsarr=[resultsDict objectForKey:@"products"];
    
    _itemsListArr=[[NSMutableArray alloc]init];
    [_itemsListArr addObjectsFromArray:productsarr];
    
}




-(void)callProductListServiceWithPage :(NSString *)CategoryId page:(NSUInteger)loadpage
{
    if(apdl_detail.net == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:apdl_detail.alertTTL message:apdl_detail.alertMSG delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
        return;
    }
    
    
    
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    NSString *sessionid=[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"];
    
    
    NSString *url_str1=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/index/getCategoryProductsList?id=%@&page=%ld&limit=10&order=&dir=&SID=%@",CategoryId,loadpage,sessionid];
    
    url_str1=[url_str1 stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *url=[NSURL URLWithString:url_str1];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if( theConnection )
    {
        
        
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
    
    // Using Blocks
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSLog(@"%@",response);
         NSDictionary * jsonDict;
         if (data)
         {
             jsonDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
             
             NSMutableArray *productsarr=[jsonDict objectForKey:@"products"];
             
             
             isPageRefreshing=NO;
             if (![productsarr isEqual:[NSNull null]]) {
                 [_itemsListArr addObjectsFromArray:productsarr];
             }
             
             
             [_Detail_collecVW reloadData];
         }
         
         [SVProgressHUD dismiss];
         
         //   if ([data length] > 0 && error == nil)
         //   [self.delegate jsonData:jsonDict];
     }];
    
}


-(void)callGetProductListService:(NSString *)CategoryId
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceConn = [[ServiceConnection alloc]init];
    serviceConn.delegate = self;
    serviceType=@"ProductList";
    [serviceConn GetProductList:CategoryId];
}



-(void)callAddToWishListService:(NSString *)ProductId
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    
    NSString * post = [[NSString alloc]initWithFormat:@"SID=%@&product=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"],ProductId];
    
    
    serviceConn = [[ServiceConnection alloc]init];
    serviceConn.delegate = self;
    serviceType=@"AddToWishList";
    [serviceConn AddToWishList:post];
}


-(void)callRemoveFromWishListService:(NSString *)ProductId
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    NSString * post = [[NSString alloc]initWithFormat:@"SID=%@&product=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"],ProductId];
    
    
    serviceConn = [[ServiceConnection alloc]init];
    serviceConn.delegate = self;
    serviceType=@"RemoveFromWishList";
    [serviceConn RemoveFromWishList:post];
}

-(void)callProductDetailsService :(NSString *)ProductId
{
    
    if(apdl_detail.net == 0)
    {
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:apdl_detail.alertTTL message:apdl_detail.alertMSG preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceConn = [[ServiceConnection alloc]init];
    serviceConn.delegate = self;
    serviceType=@"Details";
    [serviceConn GetProductDetails:ProductId];
    
}



#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    NSLog(@"JSON Dict is:%@",jsonDict);
    
    
    
    if ([serviceType isEqualToString:@"RemoveFromWishList"]) {
        
        
        
        if ([[jsonDict objectForKey:@"status"] isEqualToString:@"SUCCESS"]) {
            
            NSMutableDictionary *itemDict=[[_itemsListArr objectAtIndex:indexVal] mutableCopy];
            [itemDict setObject:@"0" forKey:@"is_in_wishlist"];
            [_itemsListArr replaceObjectAtIndex:indexVal withObject:itemDict];
            
            [self.Detail_collecVW reloadData];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        
    }
    else if ([serviceType isEqualToString:@"AddToWishList"]) {
        
        
        if ([[jsonDict objectForKey:@"status"] isEqualToString:@"SUCCESS"]) {
            
            NSMutableDictionary *itemDict=[[_itemsListArr objectAtIndex:indexVal] mutableCopy];
            [itemDict setObject:@"1" forKey:@"is_in_wishlist"];
            [_itemsListArr replaceObjectAtIndex:indexVal withObject:itemDict];
            
            [self.Detail_collecVW reloadData];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        
        
    }
    
    else if ([serviceType isEqualToString:@"ProductList"]) {
        
        NSMutableArray *filtersarr=[jsonDict objectForKey:@"avaulable_filters"];
        //        NSLog(@"%@",filtersarr);
        
        NSMutableArray *productsarr=[jsonDict objectForKey:@"products"];
        
        _itemsListArr=[[NSMutableArray alloc]init];
        [_itemsListArr addObjectsFromArray:productsarr];
        [_Detail_collecVW reloadData];
        
        
    }
    else if ([serviceType isEqualToString:@"Details"]) {
        
        
        _selectedProductDict = [jsonDict mutableCopy];
        
        
        NSArray *attributeArr = (NSArray *)[_selectedProductDict objectForKey:@"configurable_attributes"];
        
     /*    if ([attributeArr count] == 0 || [attributeArr count] == 2) {
            [self performSegueWithIdentifier:@"ProductDetail" sender:self];
        }else{
            
             [self performSegueWithIdentifier:@"ProductDetail1" sender:self];
        }
      */
        
       if ([attributeArr count]>0) {
            [self performSegueWithIdentifier:@"ProductDetail1" sender:self];
            
        }
        else {
            [self performSegueWithIdentifier:@"ProductDetail" sender:self];
        }
       
      
    }
    else if ([serviceType isEqualToString:@"Virtual_Shopping"]){
        
        
        
        for (UIViewController *controller in self.navigationController.viewControllers)
        {
            if ([controller isKindOfClass:[VirtualDetailsVC class]])
            {
                
                NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
                [notificationCenter postNotificationName:@"virtualShopping"
                                                  object:nil
                                                userInfo:jsonDict];
                
                [self.navigationController popToViewController:controller animated:YES];
                
                break;
            }
        }
        
    }
    
    [SVProgressHUD dismiss];
}


- (void)errorMessage:(NSString *)errMsg
{
    [SVProgressHUD dismiss];
}




@end
