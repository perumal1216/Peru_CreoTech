//
//  ProductDetailNewVC.m
//  FingoShop
//
//  Created by SkoopView on 29/08/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import "ProductDetailNewVC.h"
#import "ProductImageCell.h"
#import "SimilarProductCell.h"
#import "Product.h"
#import "Cart.h"
#import "AppDelegate.h"
#import "UIView+Toast.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "UIBarButtonItem+Badge.h"
#import "Constants.h"
#import "GGFullscreenImageViewController.h"
#import "AddToCartViewController.h"

@interface ProductDetailNewVC ()
{
    NSArray *productsArr;
    NSMutableArray *productGalleryArr;
    NSMutableDictionary *productOtherDetail;
    UIBarButtonItem *AP_barbutton2,*AP_barbutton1,*AP_barbutton4;
    NSMutableArray *sizesArray;
    NSArray *sizeKeysArr;
    NSInteger sizeIndexVal;
    NSString *selectedSize;
    NSString *optionID;
    int quantity;
    
    
    NSString *optionColorID;
    NSArray *sizesColorArray;
    NSMutableArray *sizesArray1;
    NSString *CompareString;
    NSInteger sizeIndexVal1;
    NSString *selectedSize1;
    
    NSString *super_attributeStr;
}
@property (weak, nonatomic) IBOutlet UILabel *lblSimilarProducts;
@property (weak, nonatomic) IBOutlet UIButton *colorButton;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSeller;
@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@property (weak, nonatomic) IBOutlet UIScrollView *detailsScroll;
@property (weak, nonatomic) IBOutlet UILabel *lblFinalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblOldPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblDiscount;
@property (weak, nonatomic) IBOutlet UICollectionView *productsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *similarProductsCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *productsImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblSpecLine;
@property (weak, nonatomic) IBOutlet UILabel *lblShipLine;
@property (weak, nonatomic) IBOutlet UILabel *lblPaymentLine;
@property (weak, nonatomic) IBOutlet UILabel *lblReturnLine;
@property (weak, nonatomic) IBOutlet UIView *returnsView;
@property (weak, nonatomic) IBOutlet UIView *paymentsView;
@property (weak, nonatomic) IBOutlet UIView *shippingView;
@property (weak, nonatomic) IBOutlet UIView *specificationView;
@property (weak, nonatomic) IBOutlet UITextField *txtfldPinCode;
@property (weak, nonatomic) IBOutlet UILabel *lblSizeDynamic;
@property (weak, nonatomic) IBOutlet UILabel *lblSizeStatic;
@property (weak, nonatomic) IBOutlet UILabel *lblAvailability;
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnCartClicked:(id)sender;
- (IBAction)btnAddToCartClicked:(id)sender;
- (IBAction)btnSpecificationClicked:(id)sender;
- (IBAction)btnShippingClicked:(id)sender;
- (IBAction)btnPaymentsClicked:(id)sender;
- (IBAction)btnReturnsClicked:(id)sender;
- (IBAction)btnBuyClicked:(id)sender;
- (IBAction)btnCheckClicked:(id)sender;
- (IBAction)btnSizeClicked:(id)sender;
- (void)btnproductDetailsCartClicked:(id)sender;
- (IBAction)btnLikeClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *lblSKU;
@property (weak, nonatomic) IBOutlet UILabel *lblWeight;
@property (weak, nonatomic) IBOutlet UILabel *lblBrand;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblColor;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle0;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle1;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle2;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle3;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle4;

- (IBAction)plusBtnAction:(id)sender;
- (IBAction)minusBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

@end

@implementation ProductDetailNewVC
@synthesize productDetailsDict,productDetailsDict1;
AppDelegate *apdl_product1;

- (void)viewDidLoad {
    [super viewDidLoad];
    quantity = 0;
    productGalleryArr = [[NSMutableArray alloc] init];
    _lblSizeStatic.layer.borderWidth = 1;
    _lblSizeStatic.layer.cornerRadius = 3;
    _lblSizeStatic.clipsToBounds = YES;
    _lblSizeDynamic.hidden = YES;
    
    _colorButton.layer.borderWidth = 1;
    _colorButton.layer.cornerRadius = 2;
    _colorButton.layer.borderColor = [[UIColor blackColor] CGColor];
    
//    sizesArray = @[@"S",@"M",@"L",@"XL",@"XXL"];
    sizesArray = [NSMutableArray new];
    sizesArray1 = [NSMutableArray new];
    NSArray *tempArr = [[_selectedProductDict objectForKey:@"configurable_attributes"] allKeys];
    
   
    if ([tempArr count] >1) {
        
        
        NSString *optionidCompare = [NSString stringWithFormat:@"%@",[tempArr objectAtIndex:0]];
        
        if ([optionidCompare isEqualToString:@"134"]) {
            
            optionColorID = [tempArr objectAtIndex:0];
            optionID = [tempArr objectAtIndex:1];
            
        }
        else{
            optionColorID = [tempArr objectAtIndex:1];
            optionID = [tempArr objectAtIndex:0];
        }

      //  optionColorID = [tempArr objectAtIndex:0];
       NSDictionary *sizeDict1 = [[_selectedProductDict objectForKey:@"configurable_attributes"] objectForKey:optionColorID];
        sizesColorArray = [sizeDict1 allKeys];
        sizesColorArray = [sizesColorArray sortedArrayUsingSelector: @selector(compare:)];
        for (int i=0; i< [sizesColorArray count]; i++) {
            [sizesArray1 addObject:[sizeDict1 objectForKey:[sizesColorArray objectAtIndex:i]]];
        }
       // optionID = [tempArr objectAtIndex:1];
        [_colorButton setHidden:NO];
        super_attributeStr = @"super_attribute";
       
    }
    else{
        optionID = [tempArr objectAtIndex:0];
        [_colorButton setHidden:YES];
        super_attributeStr = @"";
    }
    
    
    NSDictionary *sizeDict = [[_selectedProductDict objectForKey:@"configurable_attributes"] objectForKey:optionID];
    
    sizeKeysArr = [sizeDict allKeys];
    sizeKeysArr = [sizeKeysArr sortedArrayUsingSelector: @selector(compare:)];
    for (int i=0; i< [sizeKeysArr count]; i++) {
        [sizesArray addObject:[sizeDict objectForKey:[sizeKeysArr objectAtIndex:i]]];
    }
    

    NSString *urlString =[NSString stringWithFormat:@"%@",[productDetailsDict objectForKey:@"image_small_url"]];
    
    urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"prof img is %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    [_productsImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotification) name:@"logoutNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginNotification) name:@"loginNotification" object:nil];
    
    apdl_product1=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.txtfldPinCode.layer.borderWidth = 1;
    [_detailsScroll setContentSize:CGSizeMake(self.view.frame.size.width, 1300)];
    
    if ([[productDetailsDict objectForKey:@"is_in_wishlist"] integerValue] == 1)
    {
        [_btnLike setSelected:YES];
    }
    
    _lblName.text=[productDetailsDict objectForKey:@"name"];
    _lblFinalPrice.text=[NSString stringWithFormat:@"₹%@",[productDetailsDict objectForKey:@"final_price"]];
    _lblOldPrice.text=[NSString stringWithFormat:@"₹%@",[productDetailsDict objectForKey:@"price"]];
    
    //_lblSeller.text=[NSString stringWithFormat:@"Seller: %@",[productDetailsDict objectForKey:@"seller_info"]];
    _lblSeller.text=[NSString stringWithFormat:@"%@",[productDetailsDict objectForKey:@"seller_info"]];
    _lblDiscount.text=[NSString stringWithFormat:@"%@ off",[productDetailsDict objectForKey:@"discount"]];
    
    if ([[productDetailsDict1 objectForKey:@"is_in_stock"] intValue]== 1) {
        _lblAvailability.text=[NSString stringWithFormat:@"In Stock"];
    }
    else
    {
        _lblAvailability.text=@"Sold out";
        
    }

    
    NSDictionary *additionalDict = [productDetailsDict1 objectForKey:@"additional"];
    NSArray *keysArr = [additionalDict allKeys];
   
    switch (keysArr.count) {
        case 1:
            _lblSKU.text = [[additionalDict objectForKey:[keysArr objectAtIndex:0]] objectForKey:@"value"];
            
            _lblTitle0.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:0]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            _lblWeight.hidden = YES;
            _lblBrand.hidden = YES;
            _lblTitle.hidden = YES;
            _lblColor.hidden = YES;
            _lblTitle1.hidden = YES;
            _lblTitle2.hidden = YES;
            _lblTitle3.hidden = YES;
            _lblTitle4.hidden = YES;
            
            break;
        case 2:
            _lblSKU.text = [[additionalDict objectForKey:[keysArr objectAtIndex:0]] objectForKey:@"value"];
            _lblWeight.text = [[additionalDict objectForKey:[keysArr objectAtIndex:1]] objectForKey:@"value"];
            
            _lblTitle0.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:0]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            _lblTitle1.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:1]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            _lblBrand.hidden = YES;
            _lblTitle.hidden = YES;
            _lblColor.hidden = YES;
            
            _lblTitle2.hidden = YES;
            _lblTitle3.hidden = YES;
            _lblTitle4.hidden = YES;
            break;
        case 3:
            _lblSKU.text = [[additionalDict objectForKey:[keysArr objectAtIndex:0]] objectForKey:@"value"];
            _lblWeight.text = [[additionalDict objectForKey:[keysArr objectAtIndex:1]] objectForKey:@"value"];
            _lblBrand.text = [[additionalDict objectForKey:[keysArr objectAtIndex:2]] objectForKey:@"value"];
            
            _lblTitle0.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:0]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            _lblTitle1.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:1]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            _lblTitle2.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:2]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            _lblTitle.hidden = YES;
            _lblColor.hidden = YES;
            
            _lblTitle3.hidden = YES;
            _lblTitle4.hidden = YES;
            break;
        case 4:
            _lblSKU.text = [[additionalDict objectForKey:[keysArr objectAtIndex:0]] objectForKey:@"value"];
            _lblWeight.text = [[additionalDict objectForKey:[keysArr objectAtIndex:1]] objectForKey:@"value"];
            _lblBrand.text = [[additionalDict objectForKey:[keysArr objectAtIndex:2]] objectForKey:@"value"];
            _lblTitle.text = [[additionalDict objectForKey:[keysArr objectAtIndex:3]] objectForKey:@"value"];
            
            _lblTitle0.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:0]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            _lblTitle1.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:1]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            _lblTitle2.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:2]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            _lblTitle3.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:3]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            _lblColor.hidden = YES;
            
            _lblTitle4.hidden = YES;
            break;
        default:
            _lblSKU.text = [[additionalDict objectForKey:[keysArr objectAtIndex:0]] objectForKey:@"value"];
            _lblWeight.text = [[additionalDict objectForKey:[keysArr objectAtIndex:1]] objectForKey:@"value"];
            _lblBrand.text = [[additionalDict objectForKey:[keysArr objectAtIndex:2]] objectForKey:@"value"];
            _lblTitle.text = [[additionalDict objectForKey:[keysArr objectAtIndex:3]] objectForKey:@"value"];
            _lblColor.text = [[additionalDict objectForKey:[keysArr objectAtIndex:4]] objectForKey:@"value"];
            
            _lblTitle0.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:0]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            _lblTitle1.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:1]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            _lblTitle2.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:2]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            _lblTitle3.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:3]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            _lblTitle4.text = [[[[additionalDict objectForKey:[keysArr objectAtIndex:4]] objectForKey:@"label"] stringByReplacingOccurrencesOfString:@"Product" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            break;
    }
    
    
    
//    _lblSKU.text = [[additionalDict objectForKey:@"sku"] objectForKey:@"value"];
//    _lblWeight.text = [[additionalDict objectForKey:@"weight"] objectForKey:@"value"];
//    _lblBrand.text = [[additionalDict objectForKey:@"vesbrand"] objectForKey:@"value"];
//    _lblTitle.text = [[additionalDict objectForKey:@"product_title"] objectForKey:@"value"];
//    _lblColor.text = [[additionalDict objectForKey:@"ves_color"] objectForKey:@"value"];
    
    
    NSAttributedString * title =
    [[NSAttributedString alloc] initWithString:_lblOldPrice.text
                                    attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
    [_lblOldPrice setAttributedText:title];
    
    if ([[productDetailsDict objectForKey:@"rating_summary"] isEqual:[NSNull null]]) {
        _lblRating.text=@"0.0";
        
    }
    else
    {
        _lblRating.text=[productDetailsDict objectForKey:@"rating_summary"];
        
    }
    
    
    
    
    
    self.lblSpecLine.hidden = NO;
    self.lblShipLine.hidden = YES;
    self.lblPaymentLine.hidden = YES;
    self.lblReturnLine.hidden = YES;
    
    self.specificationView.hidden = NO;
    self.shippingView.hidden = YES;
    self.paymentsView.hidden = YES;
    self.returnsView.hidden = YES;
    
    
    
    
    UIImage *abuttonImage2 = [UIImage imageNamed:@"ic_cart.png"];
    UIButton *aaButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton2 setImage:abuttonImage2 forState:UIControlStateNormal];
    aaButton2.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    AP_barbutton2 = [[UIBarButtonItem alloc] initWithCustomView:aaButton2];
    [aaButton2 addTarget:self action:@selector(btnproductDetailsCartClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *abuttonImage3 = [UIImage imageNamed:@"ic_search_white_1x.png"];
    UIButton *aaButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton3 setImage:abuttonImage3 forState:UIControlStateNormal];
    aaButton3.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    UIBarButtonItem *AP_barbutton3 = [[UIBarButtonItem alloc] initWithCustomView:aaButton3];
    [aaButton3 addTarget:self action:@selector(btnSearchClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *abuttonImage4 = [UIImage imageNamed:@"ic_vs.png"];
    UIButton *aaButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [aaButton4 setImage:abuttonImage4 forState:UIControlStateNormal];
    aaButton4.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    AP_barbutton4 = [[UIBarButtonItem alloc] initWithCustomView:aaButton4];
    [aaButton4 addTarget:self action:@selector(btnVirtualShopping:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItems =
    [NSArray arrayWithObjects:AP_barbutton2,AP_barbutton4,AP_barbutton3,nil];
    
    [self callProductGalleryService:[_selectedProductDict objectForKey:@"entity_id"]];
    _descriptionTextView.text = [_selectedProductDict objectForKey:@"description"];
    [self callSimilarProductsService:[_selectedProductDict objectForKey:@"entity_id"]];

    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagehandleOneTap:)];
    [oneTap setDelegate:self];
    oneTap.numberOfTapsRequired = 1;
    oneTap.numberOfTouchesRequired = 1;
    [_productsImageView addGestureRecognizer:oneTap];
    
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(doneButtonPressed)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    self.txtfldPinCode.inputAccessoryView = keyboardToolbar;


}

-(void)doneButtonPressed
{
    [self.view endEditing:YES];
}

- (void)imagehandleOneTap:(UITapGestureRecognizer *)tapGesture
{
    NSUInteger myViewTag = tapGesture.view.tag;
    NSLog(@"%lu",(unsigned long)myViewTag);
    
    GGFullscreenImageViewController *vc = [[GGFullscreenImageViewController alloc] init];
    vc.liftedImageView=_productsImageView;
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self CheckCart];
}

-(void)loginNotification {
    [self CheckCart];
    
}

-(void)logoutNotification {
    [self CheckCart];
    
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


#pragma mark - UICollectionView Delegate Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.productsCollectionView == collectionView)
    {
        return productGalleryArr.count;
    }
    else
    {
        return productsArr.count;
    }
    
    
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.productsCollectionView == collectionView)
    {
        ProductImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"productImageCell" forIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[ProductImageCell alloc]initWithFrame:CGRectZero];
        }
        
        NSMutableDictionary *gallDict=[productGalleryArr objectAtIndex:indexPath.row];
        NSString *urlString =[NSString stringWithFormat:@"%@",[gallDict objectForKey:@"url"]];
        
        urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSLog(@"prof img is %@",urlString);
        NSURL *url = [NSURL URLWithString:urlString];
        [cell.productImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
        
        return cell;
    }
    else
    {
        SimilarProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SimilarProductCell" forIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[SimilarProductCell alloc]initWithFrame:CGRectZero];
        }
        
        cell.similarProductsImage.image = [UIImage imageNamed:[productsArr objectAtIndex:indexPath.row]];
        return cell;
        
    }
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.productsCollectionView == collectionView)
    {
        
        NSMutableDictionary *gallDict=[productGalleryArr objectAtIndex:indexPath.row];
        NSString *urlString =[NSString stringWithFormat:@"%@",[gallDict objectForKey:@"url"]];
        urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSLog(@"prof img is %@",urlString);
        NSURL *url = [NSURL URLWithString:urlString];
        [_productsImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
        
        
    }
    else
    {
        
    }
}


#pragma mark - Button Action Methods


- (IBAction)btnAddToCartClicked:(id)sender
{
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
        
        if (selectedSize) {
            
            if ([super_attributeStr isEqualToString:@"super_attribute"] ) {
                
                if (selectedSize1) {
                    //NSString *qty = [NSString stringWithFormat:@"%d",quantity];
                    [self callAddToCartService:@"1"];
                    /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     AddToCartViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Cart"];
                     [self.navigationController pushViewController:vc animated:YES];
                     
                     */
                    
                }
                else {
                    UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Please select color for product" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                    }]];
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }
            else{
                
                 [self callAddToCartService:@"1"];
            }
            
            
           
        }
        else {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"FINGOSHOP"
                                         message:@"Please select size for product"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                        }];
            
            
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
          //  [self performSegueWithIdentifier:@"cart" sender:self];
        }
        
        
        
        
        //        self.navigationItem.rightBarButtonItem.badgeValue = [NSString stringWithFormat:@"%lu",cart.positions.count];
        
        
    }
    else
    {
        
        
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Login to Proceed" preferredStyle:UIAlertControllerStyleAlert];
        
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
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"CartCount"];
    if (str == nil || [str isEqualToString:@"0"]) {
        NSLog(@"%@",str);
        return NO;
        
    }
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"CartCount"]);
    return YES;

}

- (IBAction)btnSpecificationClicked:(id)sender
{
    self.lblSpecLine.hidden = NO;
    self.lblShipLine.hidden = YES;
    self.lblPaymentLine.hidden = YES;
    self.lblReturnLine.hidden = YES;
    
    self.specificationView.hidden = NO;
    self.shippingView.hidden = YES;
    self.paymentsView.hidden = YES;
    self.returnsView.hidden = YES;
}

- (IBAction)btnShippingClicked:(id)sender
{
    self.lblSpecLine.hidden = YES;
    self.lblShipLine.hidden = NO;
    self.lblPaymentLine.hidden = YES;
    self.lblReturnLine.hidden = YES;
    
    self.specificationView.hidden = YES;
    self.shippingView.hidden = NO;
    self.paymentsView.hidden = YES;
    self.returnsView.hidden = YES;
}

- (IBAction)btnPaymentsClicked:(id)sender
{
    self.lblSpecLine.hidden = YES;
    self.lblShipLine.hidden = YES;
    self.lblPaymentLine.hidden = NO;
    self.lblReturnLine.hidden = YES;
    
    self.specificationView.hidden = YES;
    self.shippingView.hidden = YES;
    self.paymentsView.hidden = NO;
    self.returnsView.hidden = YES;
}

- (IBAction)btnReturnsClicked:(id)sender
{
    self.lblSpecLine.hidden = YES;
    self.lblShipLine.hidden = YES;
    self.lblPaymentLine.hidden = YES;
    self.lblReturnLine.hidden = NO;
    
    self.specificationView.hidden = YES;
    self.shippingView.hidden = YES;
    self.paymentsView.hidden = YES;
    self.returnsView.hidden = NO;
}

- (IBAction)btnBuyClicked:(id)sender {
    
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
        
        if (selectedSize) {
            
            if ([super_attributeStr isEqualToString:@"super_attribute"] ) {
                
                if (selectedSize1) {
                    //NSString *qty = [NSString stringWithFormat:@"%d",quantity];
                    [self callAddToCartService:@"1"];
                    /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     AddToCartViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Cart"];
                     [self.navigationController pushViewController:vc animated:YES];
                     
                     */
                    
                }
                else {
                    UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Please select color for product" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                    }]];
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }
            else{
                
                [self callAddToCartService:@"1"];
            }
            
            
            
        }
        else {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"FINGOSHOP"
                                         message:@"Please select size for product"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"ok"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           //Handle your yes please button action here
                                       }];
            
            
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
            //  [self performSegueWithIdentifier:@"cart" sender:self];
        }
        
        
        
        
        //        self.navigationItem.rightBarButtonItem.badgeValue = [NSString stringWithFormat:@"%lu",cart.positions.count];
        
        
    }
    else
    {
        
        
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Login to Proceed" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
    
//}

    
}
- (IBAction)btnColorClicked:(id)sender {
    
    CompareString = @"ColorPicker";
    pickerView1 = [UIPickerView new];
    pickerView1.delegate = self;
    pickerView1.dataSource = self;
    pickerView1.showsSelectionIndicator = YES;
    pickerView1.frame= CGRectMake(0,self.view.frame.size.height-250,self.view.frame.size.width,250);
    
    pickerView1.backgroundColor = [UIColor whiteColor];
    
    toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-250,self.view.frame.size.width,44)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *barButtonTitle = [[UIBarButtonItem alloc] initWithTitle:@"Select Color"
                                                                       style:UIBarButtonItemStylePlain target:self action:nil];
    
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStylePlain target:self action:@selector(btnColorDoneClikced)];
    toolBar.items = @[barButtonTitle,flexible,barButtonDone];
    
    barButtonDone.tintColor=[UIColor whiteColor];
    
    
    [self.view addSubview: pickerView1];
    [self.view addSubview:toolBar];
}

- (IBAction)btnCheckClicked:(id)sender {
    
    if ([self.txtfldPinCode.text length]>0) {
        
        [self callCashOnDeliveryAvailability:self.txtfldPinCode.text];
    }
    else {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"FINGOSHOP"
                                      message:@"Please enter pin code"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }

}

- (IBAction)btnSizeClicked:(id)sender {
    CompareString = @"";
    
    pickerView = [UIPickerView new];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.frame= CGRectMake(0,self.view.frame.size.height-250,self.view.frame.size.width,250);
    
    pickerView.backgroundColor = [UIColor whiteColor];
    
    toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-250,self.view.frame.size.width,44)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
   
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *barButtonTitle = [[UIBarButtonItem alloc] initWithTitle:@"Select Size"
                                                                      style:UIBarButtonItemStylePlain target:self action:nil];

    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStylePlain target:self action:@selector(btnDoneClikced)];
    toolBar.items = @[barButtonTitle,flexible,barButtonDone];
    
    barButtonDone.tintColor=[UIColor whiteColor];
    

    [self.view addSubview: pickerView];
    [self.view addSubview:toolBar];

    
}

-(void)btnDoneClikced {
    
    _lblSizeDynamic.text = [sizesArray objectAtIndex:sizeIndexVal];
    selectedSize = [sizeKeysArr objectAtIndex:sizeIndexVal];
    _lblSizeDynamic.hidden = NO;
    [pickerView removeFromSuperview];
    [toolBar removeFromSuperview];
    
}
-(void)btnColorDoneClikced
{
    
    [_colorButton setTitle:[NSString stringWithFormat:@"%@",[sizesArray1 objectAtIndex:sizeIndexVal1]] forState:UIControlStateNormal];
   
   // _lblSizeDynamic.text = [sizesArray1 objectAtIndex:sizeIndexVal1];
    selectedSize1 = [sizesColorArray objectAtIndex:sizeIndexVal1];
    //_lblSizeDynamic.hidden = NO;
    [pickerView1 removeFromSuperview];
    [toolBar removeFromSuperview];
}
- (IBAction)btnBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnFilterClicked:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FiltersViewController"];
    [self.navigationController pushViewController:vc animated:YES];
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


- (void)btnproductDetailsCartClicked:(id)sender {
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
        if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"CartCount"] integerValue] > 0) {
            
            [self performSegueWithIdentifier:@"cartSegue1" sender:self];
            
            
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
    
    
    
    //    if ([self checkCartIsEmpty]) {
    //        [self performSegueWithIdentifier:@"cartSegue" sender:self];
    //    }
    //    else
    //    {
    //        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Add atleast one Product to your cart" preferredStyle:UIAlertControllerStyleAlert];
    //
    //        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    //        }]];
    //
    //        [self presentViewController:alertController animated:YES completion:nil];
    //
    //    }
    //
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField)
        [textField resignFirstResponder];
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == self.txtfldPinCode)
    {
        NSInteger oldLength = [textField.text length];
        NSInteger newLength = oldLength + [string length] - range.length;
        if(newLength >= 7){
            return NO;
        }
        else{
            return YES;
        }
        
    }
    else{
        return YES;
    }
    
    
    
}


#pragma mark - UIPickerView Delegate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if ([CompareString isEqualToString:@"ColorPicker"]) {
        return sizesArray1.count;
    }
    else{
        return sizesArray.count;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if ([CompareString isEqualToString:@"ColorPicker"]) {
       return [sizesArray1 objectAtIndex:row];
    }
    else{
        return [sizesArray objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if ([CompareString isEqualToString:@"ColorPicker"]) {
        sizeIndexVal1 = row;
    }
    else{
        sizeIndexVal = row;
    }
    
}

#pragma mark - button Actions

- (IBAction)tollFreeButtonAction:(id)sender
{
    NSString *URLString = [@"tel://" stringByAppendingString:@"18003139899"];
    
    NSURL *URL = [NSURL URLWithString:URLString];
    
    [[UIApplication sharedApplication] openURL:URL];
}


#pragma mark - ServiceConnection Methods

-(void)callProductDetailsService :(NSString *)ProductId
{
    
    if(apdl_product1.net == 0)
    {
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:apdl_product1.alertTTL message:apdl_product1.alertMSG preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"Details";
    [serviceconn GetProductDetails:ProductId];
    
}

-(void)callSimilarProductsService :(NSString *)ProductId
{
    
    if(apdl_product1.net == 0)
    {
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:apdl_product1.alertTTL message:apdl_product1.alertMSG preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"SimilarProducts";
    [serviceconn GetSimilarProductDetails:ProductId];
    
}


-(void)callCashOnDeliveryAvailability :(NSString *)pinCode
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"CashOnDelivery";
    
    [serviceconn cashOnDeliveyAvailability:pinCode];
}

-(void)callProductGalleryService :(NSString *)ProductId
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"Gallery";
    
    [serviceconn GetProductImages:ProductId];
}

-(void)callAddToCartService:(NSString*)qty
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"AddtoCart";
    
   /* if ([optionColorID isEqualToString:@""]) {
        [serviceconn AddToCart:[productDetailsDict objectForKey:@"entity_id"] qty:qty option:optionID size:selectedSize];
    }
    else
    {
        
    }
    */
    
    [serviceconn AddToCart:[productDetailsDict objectForKey:@"entity_id"] qty:qty option:optionID size:selectedSize option1:optionColorID size1:selectedSize1 compareStr:super_attributeStr];
    
}


-(void)callGetCartInfoService
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"GetCartInfo";
    [serviceconn GetCartInfo];
}




#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    
    [SVProgressHUD dismiss];
    
    if ([ServiceType isEqualToString:@"Gallery"]) {
        
        
        productGalleryArr=(NSMutableArray *)jsonDict;
        NSLog(@"%@",productGalleryArr);
        
        if ([productGalleryArr count]>0) {
            NSString *urlString =[NSString stringWithFormat:@"%@",[[productGalleryArr objectAtIndex:0] objectForKey:@"url"]];
            
            urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"prof img is %@",urlString);
            NSURL *url = [NSURL URLWithString:urlString];
            [_productsImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
            
            [self.productsCollectionView reloadData];

        }
        
        
    }
    else if([ServiceType isEqualToString:@"SimilarProducts"])
    {
        if (jsonDict.count == 0) {
            _similarProductsCollectionView.hidden = YES;
            _lblSimilarProducts.hidden = YES;
        }
        NSLog(@"%@",jsonDict);
        [_similarProductsCollectionView reloadData];
        
        
        
    }
    else if([ServiceType isEqualToString:@"AddtoCart"])
    {
        if ([[jsonDict objectForKey:@"result"] isEqualToString:@"success"]) {
            //            [self.view makeToast:@"Item added to cart"
            //                        duration:1.0
            //                        position:CSToastPositionTop];
            
            [self callGetCartInfoService];
            
            
            
        }
        else if ([[jsonDict objectForKey:@"result"] isEqualToString:@"error"]) {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"FINGOSHOP"
                                         message:[jsonDict objectForKey:@"message"]
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
    else if([ServiceType isEqualToString:@"GetCartInfo"])
    {
        
        NSDictionary *itemsDict = [jsonDict objectForKey:@"cart_info"];
        NSArray *cartInfoArray = [itemsDict objectForKey:@"cart_items"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu",(unsigned long)cartInfoArray.count]  forKey:@"CartCount"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        AP_barbutton2.badgeValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"CartCount"];
        
        NSLog(@"Cart Count: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"CartCount"]);
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"Item added to cart" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            AddToCartViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Cart"];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];

        
    }
    else if([ServiceType isEqualToString:@"CashOnDelivery"])
    {
        
        
        
        NSString *message =[jsonDict objectForKey:@"message"];
        
        message = [message stringByReplacingOccurrencesOfString:@"<br/>"
                                                     withString:@"  "];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        NSLog(@"%@",jsonDict);
        
    }
    else if ([ServiceType isEqualToString:@"AddToWishList"]) {
        
        
        if ([[jsonDict objectForKey:@"status"] isEqualToString:@"SUCCESS"]) {
            
            [_btnLike setSelected:YES];
            [productDetailsDict setObject:@"1" forKey:@"is_in_wishlist"];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:[jsonDict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }
    
}


- (void)errorMessage:(NSString *)errMsg
{
    [SVProgressHUD dismiss];
}

- (IBAction)btnLikeClicked:(UIButton *)sender {
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"email"] && ![[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] isEqualToString:@""]) {
        
        
        if ([[productDetailsDict objectForKey:@"is_in_wishlist"] integerValue] == 1)
        {
            
            UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FINGOSHOP" message:@"This Product is already in your wish list" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        else
        {
            
            [self callAddToWishListService:[productDetailsDict objectForKey:@"entity_id"]];
            
        }
        
    }
    else
    {
        
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"Failed" message:@"Please login before adding item to your wishlist" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

-(void)callAddToWishListService:(NSString *)ProductId
{
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    
    NSString * post = [[NSString alloc]initWithFormat:@"SID=%@&product=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"],ProductId];
    
    
    serviceconn = [[ServiceConnection alloc]init];
    serviceconn.delegate = self;
    ServiceType=@"AddToWishList";
    [serviceconn AddToWishList:post];
}

- (IBAction)plusBtnAction:(id)sender {
    quantity++;
    _quantityLabel.text = [NSString stringWithFormat:@"%d",quantity];
    
}

- (IBAction)minusBtnAction:(id)sender {
    if (quantity == 0) {
        
    }
    else{
        quantity--;
    }
    _quantityLabel.text = [NSString stringWithFormat:@"%d",quantity];
    
}



@end
