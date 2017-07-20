//
//  ViewController.m
//  Kart
//
//  Created by SkoopView on 13/06/16.
//  Copyright © 2016 SkoopView. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIViewController+HeaderContainer.h"
#import "DealCell.h"
#import "Constants.h"
#import "DetailViewController.h"


@interface ViewController ()<KIImagePagerDelegate, KIImagePagerDataSource>

{
        IBOutlet KIImagePager *_imagePager;
        NSMutableDictionary*datadic;
        NSArray *top_category_imageArray,*top_category_nameArray,*bannerarry_imageArray,*offers_imageArray,*mensFashion_imageArray,*electronic_imageArray;
    }



@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView,*banner_Scroll,*banner_Scroll1,*offerZone_Scroll,*Arrival_Scroll,*brandStore_Scroll;

@property (weak, nonatomic) IBOutlet UIPageControl *bannerPageControl,*offerPagecontroller,*newarraivalpagecontroller,*brandstorePagecontroller;
@property (weak, nonatomic) IBOutlet UICollectionView *Electronics_collecVW,*Womens_collecVW,*Mens_collecVW,*Art_collecVW,*kids_collecVW,*home_kichen_collecVW,*sports_collecVW,*books_collecVW,*bannercol;
@property (strong, nonatomic) IBOutlet UICollectionView *Horizontal_CollectionVW;

@property(nonatomic,strong) NSMutableArray *Electronics_Arr,*Womens_Arr,*Mens_arr,*Art_Arr,*baby_kids_Arr,*home_kichen_Arr,*sports_arr,*books_Arr,*homePageCategoriesArr;


@property (weak, nonatomic) IBOutlet UIButton *btnViewAll1;
@property (weak, nonatomic) IBOutlet UIButton *btnViewAll2;
@property (weak, nonatomic) IBOutlet UIButton *btnViewAll3;
@property (weak, nonatomic) IBOutlet UIButton *btnViewAll4;
@property (weak, nonatomic) IBOutlet UIButton *btnViewAll5;
@property (weak, nonatomic) IBOutlet UIButton *btnViewAll6;
@property (weak, nonatomic) IBOutlet UIButton *btnViewAll7;
@property (weak, nonatomic) IBOutlet UIButton *btnViewAll8;
- (IBAction)btnViewAllClicked1:(id)sender;
- (IBAction)btnViewAllClicked2:(id)sender;
- (IBAction)btnViewAllClicked3:(id)sender;
- (IBAction)btnViewAllClicked4:(id)sender;
- (IBAction)btnViewAllClicked5:(id)sender;
- (IBAction)btnViewAllClicked6:(id)sender;
- (IBAction)btnViewAllClicked7:(id)sender;
- (IBAction)btnViewAllClicked8:(id)sender;
- (IBAction)btnMenuClicked:(id)sender;



@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([_WSConstScreenValue isEqualToString:@"SlideMenu"]) {
        
        [self performSegueWithIdentifier:@"detailSegue" sender:self];
        
    }
    //
    
    // TopBar Navigation
    UIViewController *topVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TopBarNavigationVC"];
    [self displayContentController:topVC];
    
    
    
    top_category_imageArray = [[NSArray alloc]initWithObjects:@"men.png",@"women.png",@"kids.png",@"men.png",@"women.png",@"kids.png", nil];
    offers_imageArray = [[NSArray alloc]initWithObjects:@"card1.png",@"card2.png", nil];
    mensFashion_imageArray = [[NSArray alloc]initWithObjects:@"fashion1.png",@"fashion2.png",@"fashion3.png", nil];
    
    top_category_nameArray = [[NSArray alloc]initWithObjects:@"MEN",@"WOMEN",@"KIDS",@"KITCHEN",@"ART",@"HOME", nil];
    electronic_imageArray = [[NSArray alloc]initWithObjects:@"thumb1.jpg",@"thumb2.jpg",@"thumb3.jpg", nil];
    
    NSURL*url=[NSURL URLWithString:@"https://www.fingoshop.com/restconnect/index/getHomePageBanners?SID=p5i1vm8klt4asns7b3us9fm671"];
    
    
    
    NSData*jsondata=[NSData dataWithContentsOfURL:url];
    NSError*err;
    if (jsondata != nil){
        datadic=[NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&err];
        NSLog(@" the dic sat   %@",datadic);
        // NSError*error;
        
        
        bannerarry_imageArray = [datadic valueForKey:@"source_file"];
        [_imagePager reloadData];
    }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
   // self.main_scrollview.contentSize=CGSizeMake(self.main_scrollview.bounds.size.width, 2300);
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _imagePager.pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    _imagePager.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    _imagePager.slideshowTimeInterval = 4.0f;
    _imagePager.slideshowShouldCallScrollToDelegate = YES;
    
}
- (void)viewDidLayoutSubviews
{
    self.main_scrollview.contentSize=CGSizeMake(self.main_scrollview.bounds.size.width, 2300);
}
#pragma mark - Button Actions

- (IBAction)virtualButtonClicked:(id)sender {
    
    //    DetailViewController * detailsVC =   [self.storyboard instantiateViewControllerWithIdentifier:@"DetailNavigationController"];
    //    [self.navigationController pushViewController:detailsVC animated:YES];
    
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}


#pragma mark - KIImagePager DataSource
#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImages:(KIImagePager*)pager
{
    
    
    return bannerarry_imageArray;
    
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image inPager:(KIImagePager *)pager
{
    return UIViewContentModeScaleToFill;
}
#pragma mark - KIImagePager Delegate
- (void) imagePager:(KIImagePager *)imagePager didScrollToIndex:(NSUInteger)index
{
    //  NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
}

- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{
    // NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
    // NSString *selectedItemID;
    //NSString *selectedItemType;
    
}


#pragma mark - button Actions

- (IBAction)tollFreeButtonAction:(id)sender
{
    NSString *URLString = [@"tel://" stringByAppendingString:@"18003139899"];
    
    NSURL *URL = [NSURL URLWithString:URLString];
    
    [[UIApplication sharedApplication] openURL:URL];
}



#pragma mark - CollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==_top_category_collectionView)
    {
        return top_category_imageArray.count;
    }
    else if (collectionView==_offers_collectionView)
    {
        return offers_imageArray.count;
    }
    else if (collectionView==_mensFashion_collectionView)
    {
        return mensFashion_imageArray.count;
    }
    else if (collectionView==_womenfashion_collectionView)
    {
        return 2;
    }
    else if (collectionView==_electronic_collView_Vertical)
    {
        return electronic_imageArray.count;
    }
    else if (collectionView==_electronic_collView_horizental)
    {
        return 1;
    }
    else if (collectionView==_art_collectionView)
    {
        return mensFashion_imageArray.count;
    }
    
    else
        return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (collectionView==_offers_collectionView)
    {
        CGFloat width = CGRectGetWidth(self.view.frame)/2.0f;
        return CGSizeMake(width - 10,100);
    }
    else if (collectionView == _top_category_collectionView) {
        
        return CGSizeMake(92, 100);
    }
    else if (collectionView == _mensFashion_collectionView) {
        
        CGFloat width = CGRectGetWidth(self.view.frame)/1.0f;
        return CGSizeMake(width - 10,120);
    }
    else if (collectionView == _womenfashion_collectionView) {
        
        CGFloat width = CGRectGetWidth(self.view.frame)/2.0f;
        return CGSizeMake(width - 10,180);    }
    else if (collectionView == _electronic_collView_horizental) {
        
        return CGSizeMake(210, 325);
    }
    else if (collectionView == _electronic_collView_Vertical) {
        
        return CGSizeMake(90, 100);
    }
    else if (collectionView == _art_collectionView) {
        
        CGFloat width = CGRectGetWidth(self.view.frame)/1.0f;
        return CGSizeMake(width - 10,120);
    }
    else
    {
        CGFloat width = CGRectGetWidth(self.view.frame)/1.0f;
        return CGSizeMake(width - 10,120);
    }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *) collectionView
                        layout:(UICollectionViewLayout *) collectionViewLayout
        insetForSectionAtIndex:(NSInteger) section {
    
    if (collectionView==_offers_collectionView)
    {
        
        return UIEdgeInsetsMake(0, 5, 0, 5); // top, left, bottom, right
    }
    else if (collectionView==_womenfashion_collectionView)
    {
        
        return UIEdgeInsetsMake(0, 5, 0, 5); // top, left, bottom, right
    }
    else if (collectionView == _top_category_collectionView) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else if (collectionView==_electronic_collView_horizental)
    {
        
        return UIEdgeInsetsMake(0,0, 0, 0); // top, left, bottom, right
    }
    
    else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (CGFloat)collectionView:(UICollectionView *) collectionView
                   layout:(UICollectionViewLayout *) collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger) section {
    if (collectionView==_offers_collectionView)
    {
        
        return 5.0;
    }
    else if (collectionView==_offers_collectionView)
    {
        
        return 5.0;
    }
    else if (collectionView == _top_category_collectionView) {
        return 10;
    }
    else if (collectionView == _electronic_collView_Vertical) {
        return 5;
    }
    else{
        return 10;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cell;
    if (collectionView==_top_category_collectionView)
    {
        DealCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dealCell" forIndexPath:indexPath];
        
        
        if (cell==nil)
        {
            cell=[[DealCell alloc]initWithFrame:CGRectZero];
        }
        cell.imageVW.image = [UIImage imageNamed:[top_category_imageArray objectAtIndex:indexPath.row]];
        
        cell.lblCategoryTitle.text=[NSString stringWithFormat:@"%@",[top_category_nameArray objectAtIndex:indexPath.row]];
        
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = [[UIColor clearColor]CGColor];
        return cell;
    }
    
    
    else if (collectionView==_offers_collectionView)
    {
        DealCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dealCell" forIndexPath:indexPath];
        
        
        if (cell==nil)
        {
            cell=[[DealCell alloc]initWithFrame:CGRectZero];
        }
        
        // NSString *urlString =[NSString stringWithFormat:@"%@",[[_Electronics_Arr objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
        
        // NSString *urlString =@"http://www.fingoshop.com/media/catalog/category/homedecors.png";
        //urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        // NSLog(@"prof img is %@",urlString);
        // NSURL *url = [NSURL URLWithString:urlString];
        //  [cell.imageVW sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
        
        
        cell.imageVW.image=[UIImage imageNamed:[offers_imageArray objectAtIndex:indexPath.row]];
        ;
        
        // cell.lblCategoryTitle.text=[NSString stringWithFormat:@"%@",[[_Electronics_Arr objectAtIndex:indexPath.row] objectForKey:@"name"]];
        
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = [[UIColor clearColor]CGColor];
        return cell;
    }
    else if (collectionView==_mensFashion_collectionView)
    {
        DealCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dealCell" forIndexPath:indexPath];
        if (cell==nil)
        {
            cell=[[DealCell alloc]initWithFrame:CGRectZero];
        }
        //        NSString *urlString =[NSString stringWithFormat:@"%@",[[_Womens_Arr objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
        //        urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        //        NSLog(@"prof img is %@",urlString);
        //        NSURL *url = [NSURL URLWithString:urlString];
        cell.imageVW.image=[UIImage imageNamed:[mensFashion_imageArray objectAtIndex:indexPath.row]];
        ;
        
        
        // cell.lblCategoryTitle.text=[NSString stringWithFormat:@"%@",[[_Womens_Arr objectAtIndex:indexPath.row] objectForKey:@"name"]];
        
        
        
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = [[UIColor clearColor]CGColor];
        return cell;
    }
    else if (collectionView==_art_collectionView)
    {
        DealCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dealCell" forIndexPath:indexPath];
        if (cell==nil)
        {
            cell=[[DealCell alloc]initWithFrame:CGRectZero];
        }
        //        NSString *urlString =[NSString stringWithFormat:@"%@",[[_Womens_Arr objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
        //        urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        //        NSLog(@"prof img is %@",urlString);
        //        NSURL *url = [NSURL URLWithString:urlString];
        cell.imageVW.image=[UIImage imageNamed:[mensFashion_imageArray objectAtIndex:indexPath.row]];
        ;
        
        
        // cell.lblCategoryTitle.text=[NSString stringWithFormat:@"%@",[[_Womens_Arr objectAtIndex:indexPath.row] objectForKey:@"name"]];
        
        
        
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = [[UIColor clearColor]CGColor];
        return cell;
    }
    else if (collectionView==_womenfashion_collectionView)
    {
        DealCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dealCell" forIndexPath:indexPath];
        if (cell==nil)
        {
            cell=[[DealCell alloc]initWithFrame:CGRectZero];
        }
        //        NSString *urlString =[NSString stringWithFormat:@"%@",[[_Mens_arr objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
        //        urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        //        NSLog(@"prof img is %@",urlString);
        //        NSURL *url = [NSURL URLWithString:urlString];
        //        [cell.imageVW sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
        //
        //
        //        cell.lblCategoryTitle.text=[NSString stringWithFormat:@"%@",[[_Mens_arr objectAtIndex:indexPath.row] objectForKey:@"name"]];
        
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = [[UIColor clearColor]CGColor];
        return cell;
    }
    else if (collectionView==_electronic_collView_horizental)
    {
        DealCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dealCell" forIndexPath:indexPath];
        if (cell==nil)
        {
            cell=[[DealCell alloc]initWithFrame:CGRectZero];
        }
        //        NSString *urlString =[NSString stringWithFormat:@"%@",[[_Art_Arr objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
        //        urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        //        NSLog(@"prof img is %@",urlString);
        //        NSURL *url = [NSURL URLWithString:urlString];
        //        [cell.imageVW sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
        //
        //        cell.lblCategoryTitle.text=[NSString stringWithFormat:@"%@",[[_Art_Arr objectAtIndex:indexPath.row] objectForKey:@"name"]];
        
        
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = [[UIColor clearColor]CGColor];
        return cell;
    }
    else if (collectionView==_electronic_collView_Vertical)
    {
        DealCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dealCell" forIndexPath:indexPath];
        if (cell==nil)
        {
            cell=[[DealCell alloc]initWithFrame:CGRectZero];
        }
        //        NSString *urlString =[NSString stringWithFormat:@"%@",[[_baby_kids_Arr objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
        //        urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        //        NSLog(@"prof img is %@",urlString);
        //        NSURL *url = [NSURL URLWithString:urlString];
        //        [cell.imageVW sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
        //
        //        cell.lblCategoryTitle.text=[NSString stringWithFormat:@"%@",[[_baby_kids_Arr objectAtIndex:indexPath.row] objectForKey:@"name"]];
        
        cell.imageVW.image=[UIImage imageNamed:[electronic_imageArray objectAtIndex:indexPath.row]];
        ;
        
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = [[UIColor clearColor]CGColor];
        return cell;
    }
    /* else if (collectionView==_home_kichen_collecVW)
     {
     DealCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dealCell" forIndexPath:indexPath];
     if (cell==nil)
     {
     cell=[[DealCell alloc]initWithFrame:CGRectZero];
     }
     NSString *urlString =[NSString stringWithFormat:@"%@",[[_home_kichen_Arr objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
     urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
     NSLog(@"prof img is %@",urlString);
     NSURL *url = [NSURL URLWithString:urlString];
     [cell.imageVW sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
     
     cell.lblCategoryTitle.text=[NSString stringWithFormat:@"%@",[[_home_kichen_Arr objectAtIndex:indexPath.row] objectForKey:@"name"]];
     
     cell.layer.borderWidth = 0.3;
     cell.layer.borderColor = [[UIColor clearColor]CGColor];
     return cell;
     }
     else if (collectionView==_sports_collecVW)
     {
     DealCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dealCell" forIndexPath:indexPath];
     if (cell==nil)
     {
     cell=[[DealCell alloc]initWithFrame:CGRectZero];
     }
     NSString *urlString =[NSString stringWithFormat:@"%@",[[_sports_arr objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
     urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
     NSLog(@"prof img is %@",urlString);
     NSURL *url = [NSURL URLWithString:urlString];
     [cell.imageVW sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
     
     
     cell.lblCategoryTitle.text=[NSString stringWithFormat:@"%@",[[_sports_arr objectAtIndex:indexPath.row] objectForKey:@"name"]];
     
     cell.layer.borderWidth = 0.3;
     cell.layer.borderColor = [[UIColor clearColor]CGColor];
     return cell;
     }
     else if (collectionView==_books_collecVW)
     {
     DealCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dealCell" forIndexPath:indexPath];
     if (cell==nil)
     {
     cell=[[DealCell alloc]initWithFrame:CGRectZero];
     }
     NSString *urlString =[NSString stringWithFormat:@"%@",[[_books_Arr objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
     urlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
     NSLog(@"prof img is %@",urlString);
     NSURL *url = [NSURL URLWithString:urlString];
     [cell.imageVW sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
     
     
     cell.lblCategoryTitle.text=[NSString stringWithFormat:@"%@",[[_books_Arr objectAtIndex:indexPath.row] objectForKey:@"name"]];
     
     cell.layer.borderWidth = 0.3;
     cell.layer.borderColor = [[UIColor clearColor]CGColor];
     return cell;
     }
     */
    else
        return nil;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*  NSString *selectedItemID;
     NSString *selectedItemType;
     if (collectionView==_Horizontal_CollectionVW)
     {
     if (indexPath.row == 0) {
     
     UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VirtualShoppingVC"];
     [self.navigationController pushViewController:vc animated:YES];
     
     
     }
     else{
     
     selectedItemID =[NSString stringWithFormat:@"%@",[horizontal_categoryIDArray objectAtIndex:indexPath.row]];
     // selectedItemType = @"Electronics";
     NSLog(@"%@",selectedItemID);
     _WSConstScreenValue = @"Home";
     _WSConstSelectedCategoryID = selectedItemID;
     // _WSConstSelectedCategoryType = selectedItemType;
     [self performSegueWithIdentifier:@"detailSegue" sender:self];
     }
     }
     else if (collectionView==_Electronics_collecVW)
     {
     selectedItemID =[NSString stringWithFormat:@"%@",[[_Electronics_Arr objectAtIndex:indexPath.row] objectForKey:@"id"]];
     selectedItemType = @"Electronics";
     NSLog(@"%@",selectedItemID); _WSConstScreenValue = @"Home";
     _WSConstSelectedCategoryID = selectedItemID;
     _WSConstSelectedCategoryType = selectedItemType;
     [self performSegueWithIdentifier:@"detailSegue" sender:self];
     }
     else if (collectionView==_Womens_collecVW)
     {
     
     selectedItemID =[NSString stringWithFormat:@"%@",[[_Womens_Arr objectAtIndex:indexPath.row] objectForKey:@"id"]];
     selectedItemType = @"Womens";
     NSLog(@"%@",selectedItemID);
     _WSConstScreenValue = @"Home";
     _WSConstSelectedCategoryID = selectedItemID;
     _WSConstSelectedCategoryType = selectedItemType;
     [self performSegueWithIdentifier:@"detailSegue" sender:self];
     
     }
     else if (collectionView==_Mens_collecVW)
     {
     
     selectedItemID =[NSString stringWithFormat:@"%@",[[_Mens_arr objectAtIndex:indexPath.row] objectForKey:@"id"]];
     selectedItemType = @"Mens";
     NSLog(@"%@",selectedItemID); _WSConstScreenValue = @"Home";
     _WSConstSelectedCategoryID = selectedItemID;
     _WSConstSelectedCategoryType = selectedItemType;
     [self performSegueWithIdentifier:@"detailSegue" sender:self];
     
     
     }
     else if (collectionView==_Art_collecVW)
     {
     
     
     selectedItemID =[NSString stringWithFormat:@"%@",[[_Art_Arr objectAtIndex:indexPath.row] objectForKey:@"id"]];
     selectedItemType = @"Art";
     NSLog(@"%@",selectedItemID);
     _WSConstScreenValue = @"Home";
     _WSConstSelectedCategoryID = selectedItemID;
     _WSConstSelectedCategoryType = selectedItemType;
     [self performSegueWithIdentifier:@"detailSegue" sender:self];
     
     }
     else if (collectionView==_kids_collecVW)
     {
     
     selectedItemID =[NSString stringWithFormat:@"%@",[[_baby_kids_Arr objectAtIndex:indexPath.row] objectForKey:@"id"]];
     selectedItemType = @"Kids";
     NSLog(@"%@",selectedItemID);
     _WSConstScreenValue = @"Home";
     _WSConstSelectedCategoryID = selectedItemID;
     _WSConstSelectedCategoryType = selectedItemType;
     [self performSegueWithIdentifier:@"detailSegue" sender:self];
     
     }
     else if (collectionView==_home_kichen_collecVW)
     {
     
     selectedItemID =[NSString stringWithFormat:@"%@",[[_home_kichen_Arr objectAtIndex:indexPath.row] objectForKey:@"id"]];
     selectedItemType = @"Home";
     NSLog(@"%@",selectedItemID);
     _WSConstScreenValue = @"Home";
     _WSConstSelectedCategoryID = selectedItemID;
     _WSConstSelectedCategoryType = selectedItemType;
     [self performSegueWithIdentifier:@"detailSegue" sender:self];
     
     
     }
     else if (collectionView==_sports_collecVW)
     {
     selectedItemID =[NSString stringWithFormat:@"%@",[[_sports_arr objectAtIndex:indexPath.row] objectForKey:@"id"]];
     selectedItemType = @"Sports";
     NSLog(@"%@",selectedItemID);
     _WSConstScreenValue = @"Home";
     _WSConstSelectedCategoryID = selectedItemID;
     _WSConstSelectedCategoryType = selectedItemType;
     [self performSegueWithIdentifier:@"detailSegue" sender:self];
     
     }
     else if (collectionView==_books_collecVW)
     {
     selectedItemID =[NSString stringWithFormat:@"%@",[[_books_Arr objectAtIndex:indexPath.row] objectForKey:@"id"]];
     selectedItemType = @"Books";
     
     NSLog(@"%@",selectedItemID);
     _WSConstScreenValue = @"Home";
     _WSConstSelectedCategoryID = selectedItemID;
     _WSConstSelectedCategoryType = selectedItemType;
     [self performSegueWithIdentifier:@"detailSegue" sender:self];
     
     }
     
     */
    
}


-(void)btnVirtualShopping:(id)sender
{
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VirtualShoppingVC"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
