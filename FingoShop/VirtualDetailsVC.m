//
//  VirtualDetailsVC.m
//  FingoShop
//
//  Created by Perumal on 21/04/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import "VirtualDetailsVC.h"
#import "SelectCategoryVC.h"
#import "UIImageView+WebCache.h"
//#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "ProductDetailVC.h"
#import "ProductDetailNewVC.h"
#import <QuartzCore/QuartzCore.h>
@interface VirtualDetailsVC ()
{
   
    bool flagVal;
    NSDictionary * selectedProduct;
    CGFloat lastRotation;
}
@end

@implementation VirtualDetailsVC
@synthesize imageArray,bag_Image;
//AppDelegate *apdl_detail;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //MARK:-pan &pinch geasters method
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    [self.view addGestureRecognizer:panGesture];
    
    
    
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [rotationRecognizer setDelegate:self];
    [self.bagRoundImage addGestureRecognizer:rotationRecognizer];
    
    
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchWithGestureRecognizer:)];
    [self.bagRoundImage addGestureRecognizer:pinchGestureRecognizer];
    self.bagRoundImage.userInteractionEnabled = YES;
    self.movingView.hidden=true;
    self.movingView.contentMode = UIViewContentModeCenter;
    self.bagRoundImage.contentMode = UIViewContentModeCenter;
    self.bagRoundImage.image = bag_Image;
    imageArray =[[NSMutableArray alloc]init];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageEditingMethod:) name:@"virtualShopping" object:nil];
    
    self.popUpImageView.backgroundColor = [UIColor whiteColor];
    //[[UIColor blackColor]colorWithAlphaComponent:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rotate:(id)sender {
    
    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = 0.0 - (lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    
    CGAffineTransform currentTransform = self.movingView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [self.movingView setTransform:newTransform];
    lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
}

-(void)imageEditingMethod :(NSNotification *)notification
{
    flagVal = true;
    self.movingView.hidden = false;
    NSDictionary *dict = [notification userInfo];
    
    NSString *urlString = [dict objectForKey:@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    [self.movingView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place"]];
    
}


- (void)moveImage:(UIPanGestureRecognizer *)recognizer
{
    CGPoint newCenter = [recognizer translationInView:self.view];
    
    if([recognizer state] == UIGestureRecognizerStateBegan) {
        
        beginX = self.movingView.center.x;
        beginY = self.movingView.center.y;
    }
    
    newCenter = CGPointMake(beginX + newCenter.x, beginY + newCenter.y);
    NSLog(@"%f",beginX);
    NSLog(@"%f",beginY);
    
    
    [self.movingView setCenter:newCenter];
    //    [self.bagRoundImage addSubview:self.movingView];
    
}
-(void)handlePinchWithGestureRecognizer:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    self.movingView.transform = CGAffineTransformScale(self.movingView.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    
    pinchGestureRecognizer.scale = 1.0;
}

//MARK:-Button actions
- (IBAction)closeButtonAction:(id)sender {
    
    [self.view sendSubviewToBack:self.popUpImageView];
}

- (IBAction)addButtonAction:(id)sender {
    
    self.movingView.hidden= false;
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Product for Men or Women?"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Men" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        SelectCategoryVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCategoryVC"];
        vc.categoryFlag = @"Men";
            [self.navigationController pushViewController:vc animated:YES];
 
    }] ;// UIAlertActionStyleCancel
    
    UIAlertAction *photoLibrarey = [UIAlertAction actionWithTitle:@"Women" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        SelectCategoryVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCategoryVC"];
        vc.categoryFlag = @"Women";
            [self.navigationController pushViewController:vc animated:YES];
        
    }] ;
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }] ;
    [alertController addAction:camera];
    [alertController addAction:cancel];
    [alertController addAction:photoLibrarey];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (IBAction)saveButtonAction:(id)sender {
    
    
    // UIImageWriteToSavedPhotosAlbum(_bagRoundImage.image, nil, nil, nil);
    
    CGRect grabRect = CGRectMake(self.bagRoundImage.frame.origin.x,self.bagRoundImage.frame.origin.y,self.bagRoundImage.frame.size.width,self.bagRoundImage.frame.size.height);
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(grabRect.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(grabRect.size);
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, -grabRect.origin.x, -grabRect.origin.y);
    [self.view.layer renderInContext:ctx];
    viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
   //  UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
     UIImageWriteToSavedPhotosAlbum(viewImage, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
    /*
    
    //                [imageArray addObject:viewImage];
    //    imageArray =[[NSMutableArray alloc]initWithObjects:viewImage, nil];
    
   
    
    
    [imageArray addObject:viewImage];
    int x =0;
    for (int i=0; i<imageArray.count; i++) {
        self.ScrollimageView=[[UIImageView alloc]initWithFrame:CGRectMake(x, 0,45 , 65)];
        _ScrollimageView.image=[imageArray objectAtIndex:i];
        
        imageClickButton = [[UIButton alloc]init];
        [imageClickButton addTarget:selectedProduct action:@selector(imageClickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        imageClickButton.frame = CGRectMake(x, 0,45 , 65);
        imageClickButton.tag = i;
       // imageClickButton.backgroundColor = [UIColor redColor];
        self.ScrollimageView.userInteractionEnabled  = true;
        [self.ScrollimageView addSubview:imageClickButton];
        x=x+60;

   
        
    }
    
   // _bagRoundImage.image = viewImage;
    [self.contentView addSubview:self.ScrollimageView];
   
   */
}

- (void)   savedPhotoImage:(UIImage *)image
  didFinishSavingWithError:(NSError *)error
               contextInfo:(void *)contextInfo
{
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"This image has been saved to your photo album"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }] ;
    [alertController addAction:okAction];
   
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

-(void)imageClickButtonAction :(UIButton *)sender
{
    
   // [self.view bringSubviewToFront:self.popUpImageView];
    
   // self.image_PopUpview.image = [imageArray objectAtIndex:sender.tag];
    
    
    
   // self.bagRoundImage.image = [imageArray objectAtIndex:sender.tag];
    
    
}
- (IBAction)selectNewImageButtonAction:(id)sender
{

    
    self.movingView.hidden=true;
    imagePickerController =[[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    //imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
      //UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
  /*
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@""
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        //
        
        if (! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertView *deviceNotFoundAlert = [[UIAlertView alloc] initWithTitle:@"No Device" message:@"Camera is not available"
                                                                         delegate:nil
                                                                cancelButtonTitle:@"exit"
                                                                otherButtonTitles:nil];
            [deviceNotFoundAlert show];
            
        }
        else
        {

        
        imagePickerController =[[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];
            self.movingView.hidden=YES;
            
        }
        
    }] ;// UIAlertActionStyleCancel
    
    UIAlertAction *photoLibrarey = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        imagePickerController =[[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        self.movingView.hidden=YES;
    }] ;
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }] ;
    [alertController addAction:camera];
    [alertController addAction:cancel];
    [alertController addAction:photoLibrarey];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
*/
    
    
}


- (IBAction)buyButtonAction:(id)sender {
    
//    productID
    
   // [self callProductDetailsService:[[_itemsListArr objectAtIndex:indexPath.row] objectForKey:@"entity_id"]];
    
    
    
    //selectedProduct = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedProduct"];
    
    if(flagVal == false)
    {
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"FingShop" message:@"Please add a product to buy" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    else{
        
        //flagVal = false;
        
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedProduct"];
        selectedProduct = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        [self callProductDetailsService:[NSString stringWithFormat:@"%@",[selectedProduct objectForKey:@"entity_id"]]];
    }

}


-(void)callProductDetailsService :(NSString *)ProductId
{
//    
//    if(apdl_detail.net == 0)
//    {
//        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:apdl_detail.alertTTL message:apdl_detail.alertMSG preferredStyle:UIAlertControllerStyleAlert];
//        
//        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        }]];
//        
//        [self presentViewController:alertController animated:YES completion:nil];
//        return;
//    }
//    
    [SVProgressHUD showWithStatus:@"Please wait" maskType:SVProgressHUDMaskTypeBlack]; // Progress
    
    serviceConn = [[ServiceConnection alloc]init];
    serviceConn.delegate = self;
    serviceType=@"Details";
    [serviceConn GetProductDetails:ProductId];
    
}

//MARK:- ImagePickerController


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    _bagRoundImage.image = chosenImage;
     [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ServiceConnection Delegate Methods

- (void)jsonData:(NSDictionary *)jsonDict
{
    NSLog(@"JSON Dict is:%@",jsonDict);

     if ([serviceType isEqualToString:@"Details"]) {
        
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
   /* else if ([serviceType isEqualToString:@"Virtual_Shopping"]){
        
        
        
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
    */
    
    [SVProgressHUD dismiss];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
