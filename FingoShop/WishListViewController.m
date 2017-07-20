//
//  WishListViewController.m
//  FingoShop
//
//  Created by Rambabu Mannam on 25/04/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import "WishListViewController.h"
#import "WishListCell.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"
#import "ProductDetailVC.h"
#import "AppDelegate.h"
#import "ProductDetailNewVC.h"
#import "ItemCell.h"
#import "UIView+Toast.h"
#import "Cart.h"
#import "UIViewController+ECSlidingViewController.h"


#define IS_IPHONE5 ( [ [ UIScreen mainScreen ] bounds ].size.height == 568 )
#define IS_IPHONE6 ( [ [ UIScreen mainScreen ] bounds ].size.height == 667 )
#define IS_IPHONE6S ( [ [ UIScreen mainScreen ] bounds ].size.height == 736 )

@interface WishListViewController ()
{
    NSMutableArray *boolArray;
    NSMutableArray *WishListArr;
    //NSString *serviceType;
     NSDictionary *selectedProduct;
    
}
- (IBAction)btnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *wishlist_CV;

@end

@implementation WishListViewController
AppDelegate *apdl_detail2;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"wishlist array is:%@",WishListArr);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
     apdl_detail2=(AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    [layout setSectionInset:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
    [layout setMinimumInteritemSpacing:5.0];
    
    
    [self.wishlist_CV setCollectionViewLayout:layout];
    
    
    [self callGetWishListService];
    

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"wishlistArr %@",WishListArr);

    return WishListArr.count;
    //NSLog(@"wishlistArr %@",WishListArr);
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
            WishListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wishListCell" forIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[WishListCell alloc]initWithFrame:CGRectZero];

        }
    
    NSMutableDictionary *wishListDict=[WishListArr objectAtIndex:indexPath.row];
    cell.Name_lbl.text=[wishListDict objectForKey:@"name"];
    cell.lblSeller.text=[wishListDict objectForKey:@"seller_info"];
    NSLog(@" wishlist is %@", WishListArr);
    cell.newprice_lbl.text=[NSString stringWithFormat:@"₹%@",[wishListDict objectForKey:@"final_price"]];
    cell.oldPrice_lbl.text=[NSString stringWithFormat:@"₹%@",[wishListDict objectForKey:@"price"]];
    cell.off_lbl.text=[NSString stringWithFormat:@"%@ off",[wishListDict objectForKey:@"discount"]];
    
    NSAttributedString * title =
    [[NSAttributedString alloc] initWithString:cell.oldPrice_lbl.text
                                    attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
    [cell.oldPrice_lbl setAttributedText:title];
    
    
    if ([[wishListDict objectForKey:@"reviews_count"] isEqual:[NSNull null]]) {
        cell.lblReviewsCount.text=@"( 0 )";
        
    }
    else
    {
        cell.lblReviewsCount.text=[NSString stringWithFormat:@"( %@ )",[wishListDict objectForKey:@"reviews_count"]];
        
    }
    
    if ([[wishListDict objectForKey:@"is_in_stock"] isEqual:[NSNull null]]) {
        
        cell.lblAvailability.text=@"N/A";

    }
    
    else if ([[wishListDict objectForKey:@"is_in_stock"] isEqualToString:@"true"]) {
        cell.lblAvailability.text=@"In Stock";
        
    }
    else
    {
        cell.lblAvailability.text=@"Sold out";
        
    }
    

    NSString *urlString =[NSString stringWithFormat:@"%@",[wishListDict objectForKey:@"image_small_url"]];
    
    urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"prof img is %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    [cell.imageVW sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
    
    [cell.btnLike addTarget:self action:@selector(btnLikeClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnLike.tag = indexPath.item;

    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    _selectedWishListItemDict=[WishListArr objectAtIndex:indexPath.row];
//    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    ProductDetailVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"ProductDetail"];
//    [vc.productDetailsDict removeAllObjects];
//  //  [vc.productDetailsDict1 removeAllObjects];
//  //  vc.productDetailsDict1=_selectedWishListItemDict;
//    vc.productDetailsDict=_selectedWishListItemDict;
//    
//    
//
//    vc.btnLike.hidden = true;
//    
//    
//    
//    
//    
//    
//    
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    
  //  [self callProductDetailsService:<#(NSString *)#>]
    
    
    [self callProductDetailsService:[[WishListArr objectAtIndex:indexPath.row] objectForKey:@"entity_id"]];
    selectedProduct = [WishListArr objectAtIndex:indexPath.row];
    NSLog(@"selected Product is %@",selectedProduct);

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



-(void)callGetProductListService:(NSString *)CategoryId
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceConn = [[ServiceConnection alloc]init];
    serviceConn.delegate = self;
    serviceType=@"ProductList";
    [serviceConn GetProductList:CategoryId];
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
-(void)callProductListServiceWithPage :(NSString *)CategoryId page:(NSUInteger)loadpage
{
    if(apdl_detail2.net == 0)
    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:apdl_detail2.alertTTL message:apdl_detail2.alertMSG delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        
//        [alert show];
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
             
             
           //  isPageRefreshing=NO;
             if (![productsarr isEqual:[NSNull null]]) {
                 [WishListArr addObjectsFromArray:productsarr];
             }
             
             
            // [_Detail_collecVW reloadData];
         }
         
         [SVProgressHUD dismiss];
         
         //   if ([data length] > 0 && error == nil)
         //   [self.delegate jsonData:jsonDict];
     }];
    
}
-(void)callProductDetailsService :(NSString *)ProductId
{
    
    if(apdl_detail2.net == 0)
    {
//        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:apdl_detail2.alertTTL message:apdl_detail2.alertMSG preferredStyle:UIAlertControllerStyleAlert];
//        
//        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        }]];
//        
//        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceConn = [[ServiceConnection alloc]init];
    serviceConn.delegate = self;
    serviceType=@"Details";
    [serviceConn GetProductDetails:ProductId];
    
}

//-(void)callAddToCartService:(NSString*)qty
//{
//    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
//    
//    serviceconn = [[ServiceConnection alloc]init];
//    serviceconn.delegate = self;
//    ServiceType=@"AddtoCart";
//    [serviceconn AddToCart:[productDetailsDict objectForKey:@"entity_id"] qty:qty option:optionID size:selectedSize];
//}
//
//
//-(void)callGetCartInfoService
//{
//    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
//    
//    serviceconn = [[ServiceConnection alloc]init];
//    serviceconn.delegate = self;
//    ServiceType=@"GetCartInfo";
//    [serviceconn GetCartInfo];
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)btnLikeClicked:(UIButton*)sender {
    NSMutableDictionary *wishListDict=[WishListArr objectAtIndex:sender.tag];
    NSString *productID = [wishListDict objectForKey:@"item_id"];
    [self callRemoveFromWishListService:productID];
}

- (IBAction)btnBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)callRemoveFromWishListService:(NSString *)ProductId
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress

    serviceConn = [[ServiceConnection alloc]init];
    serviceConn.delegate = self;
    serviceType=@"RemoveFromWishList";
    [serviceConn RemoveFromWishList:ProductId];
}


-(void)callGetWishListService
{
    
    NSString * post = [[NSString alloc]initWithFormat:@"SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];

    
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    serviceType=@"GetWishList";
    serviceConn = [[ServiceConnection alloc]init];
    serviceConn.delegate = self;
    [serviceConn GetWishList:post];
    
}

-(void)callProductListService :(NSString *)CategoryId
{
    
    if(apdl_detail2.net == 0)
    {
//        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:apdl_detail2.alertTTL message:apdl_detail2.alertMSG preferredStyle:UIAlertControllerStyleAlert];
//        
//        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        }]];
//        
//        [self presentViewController:alertController animated:YES completion:nil];
        
        
        return;
    }
    
    
    NSString *url_str1=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/index/getCategoryProductsList?id=%@&sid=%@",CategoryId,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSString *url_str = [url_str1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:url_str];
    
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    NSError *error;
    NSMutableDictionary *resultsDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    
    //   NSMutableArray *filtersarr=[resultsDict objectForKey:@"avaulable_filters"];
    NSMutableArray *productsarr=[resultsDict objectForKey:@"products"];
    
    WishListArr=[[NSMutableArray alloc]init];
    [WishListArr addObjectsFromArray:productsarr];
    
}
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"ProductDetail"]) {
//        ProductDetailVC *mvc=[segue destinationViewController];
//        mvc.productDetailsDict = [_selectedProductDict mutableCopy];
//        
//        mvc.productDetailsDict1 = [_selectedProductDict mutableCopy];
//    }
//    else if ([segue.identifier isEqualToString:@"ProductDetail1"]) {
//        ProductDetailNewVC *mvc=[segue destinationViewController];
//        mvc.productDetailsDict = [_selectedProductDict mutableCopy];
//        mvc.productDetailsDict1 = [_selectedProductDict mutableCopy];
//    }
//    
//    
//    
//}



#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
  //  [SVProgressHUD dismiss];
     if ([serviceType isEqualToString:@"Details"]) {
        
        _selectedProductDict = [jsonDict mutableCopy];
        NSArray *attributeArr = (NSArray *)[_selectedProductDict objectForKey:@"configurable_attributes"];
        if ([attributeArr count]>0) {
            [self performSegueWithIdentifier:@"ProductDetail1" sender:self];
            
        }
        else {
            [self performSegueWithIdentifier:@"ProductDetail" sender:self];
        }
    }
    

    
    if ([serviceType isEqualToString:@"GetWishList"]) {
    
        if ([jsonDict count]>0) {
            WishListArr=[jsonDict objectForKey:@"items"];
            NSLog(@"%@",WishListArr);
            if ([WishListArr count] == 0) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FING0SHOP" message:@"Your wish list is empty" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertController addAction:okAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
            [_wishlist_CV reloadData];
        }

    }
    else {
        if (jsonDict != nil) {
            if ([[jsonDict objectForKey:@"status"] isEqualToString:@"SUCCESS"]) {
                
               // UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FING0SHOP" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                
               // UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style://UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self callGetWishListService];
                //}];
                //[alertController addAction:okAction];
                
                //[self presentViewController:alertController animated:YES completion:nil];
            }
            else {
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FING0SHOP" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
//                
//                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    
//                }];
//                [alertController addAction:okAction];
//                
//                [self presentViewController:alertController animated:YES completion:nil];
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
