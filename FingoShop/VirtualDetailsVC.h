//
//  VirtualDetailsVC.h
//  FingoShop
//
//  Created by Perumal on 21/04/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"

@interface VirtualDetailsVC : UIViewController<ServiceConnectionDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    CGFloat beginX;
    CGFloat beginY;
    UIImagePickerController *imagePickerController;
    
    UIImage *viewImage;
    ServiceConnection *serviceConn;
    NSString *serviceType;
    UIButton *imageClickButton;
}
@property(nonatomic,strong) NSMutableArray*imageArray;
@property (strong, nonatomic) IBOutlet UIImageView *ScrollimageView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIImageView *movingView;
@property (strong, nonatomic) IBOutlet UIImageView *bagRoundImage;
@property (nonatomic,strong) UIImage *bag_Image;
@property (weak, nonatomic) IBOutlet UIView *popUpImageView;
@property (weak, nonatomic) IBOutlet UIImageView *image_PopUpview;

@end
