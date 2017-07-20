//
//  VirtualShoppingVC.m
//  FingoShop
//
//  Created by Perumal on 21/04/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import "VirtualShoppingVC.h"
#import "VirtualDetailsVC.h"
#import <QuartzCore/QuartzCore.h>
@interface VirtualShoppingVC ()
{
    NSArray *addImages;
    int flag ;
}
@end

@implementation VirtualShoppingVC
@synthesize imageArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //MARK:-pan &pinch geasters method
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    [self.view addGestureRecognizer:panGesture];
    //
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchWithGestureRecognizer:)];
    [self.view addGestureRecognizer:pinchGestureRecognizer];
    self.movingView.hidden=true;

    
    
    flag = 0 ;
    
    
    
}
- (void)moveImage:(UIPanGestureRecognizer *)recognizer
{
    CGPoint newCenter = [recognizer translationInView:self.bagRoundImage];
    
    if([recognizer state] == UIGestureRecognizerStateBegan) {
        
        beginX = self.movingView.center.x;
        beginY = self.movingView.center.y;
    }
    
    newCenter = CGPointMake(beginX + newCenter.x, beginY + newCenter.y);
   // NSLog(@"%f",beginX);
    //NSLog(@"%f",beginY);
    
    
    [self.movingView setCenter:newCenter];
    //    [self.bagRoundImage addSubview:self.movingView];
    
}
-(void)handlePinchWithGestureRecognizer:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    self.movingView.transform = CGAffineTransformScale(self.movingView.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    
    pinchGestureRecognizer.scale = 1.0;
    
    
    
    
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK:- BUTTON ACTIONS
- (IBAction)takeaPictureButtonAction:(id)sender {
    
    if (! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *deviceNotFoundAlert = [[UIAlertView alloc] initWithTitle:@"No Device" message:@"Camera is not available"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"exit"
                                                            otherButtonTitles:nil];
        [deviceNotFoundAlert show];
        
    }
    else
    {
//        
//        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
//        cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        cameraPicker.delegate =self;
//        // Show image picker
//        [self presentViewController:cameraPicker animated:YES completion:nil];
        
        imagePickerController =[[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (IBAction)selectaPictureButtonAction:(id)sender {
    
    
    
    imagePickerController =[[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}




- (IBAction)save:(id)sender {
    
    
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
    // UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
    //                [imageArray addObject:viewImage];
    //    imageArray =[[NSMutableArray alloc]initWithObjects:viewImage, nil];
    [imageArray addObject:viewImage];
    int x =0;
    for (int i=0; i<imageArray.count; i++) {
        self.ScrollimageView=[[UIImageView alloc]initWithFrame:CGRectMake(x, 0,45 , 85)];
        _ScrollimageView.image=[imageArray objectAtIndex:i];
        x=x+45;
        
    }
    
    _bagRoundImage.image = viewImage;
    [self.contentView addSubview:self.ScrollimageView];
    
    
    
}

- (IBAction)newImageAction:(id)sender {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@""
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"CAMERA" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
    }] ;// UIAlertActionStyleCancel
    
    UIAlertAction *photoLibrarey = [UIAlertAction actionWithTitle:@"PHOTO LIBRARY" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
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
    
    
    
    
    
}
- (IBAction)addAction:(id)sender {
    self.movingView.hidden=false;
    //NSArray *arr;
    
    self.movingView.image = [UIImage imageNamed:[addImages objectAtIndex:flag]];
    
    flag ++;
    
    
    
}

//MARK:- ImagePickerController


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _bagRoundImage.image = info[UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    VirtualDetailsVC *virualVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VirtualDetailsVC"];
    virualVC.bag_Image = info[UIImagePickerControllerOriginalImage];
    
   // [self presentViewController:virualVC animated:YES completion:nil];
    
    [self.navigationController pushViewController:virualVC animated:YES];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
