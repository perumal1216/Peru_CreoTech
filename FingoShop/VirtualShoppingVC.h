//
//  VirtualShoppingVC.h
//  FingoShop
//
//  Created by Perumal on 21/04/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface VirtualShoppingVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    CGFloat beginX;
    CGFloat beginY;
    UIImagePickerController *imagePickerController;
    
    UIImage *viewImage;

}

@property(nonatomic,strong) NSMutableArray*imageArray;
@property (strong, nonatomic) IBOutlet UIImageView *ScrollimageView;
- (IBAction)addAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIImageView *movingView;
- (IBAction)save:(id)sender;
- (IBAction)newImageAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *bagRoundImage;

@end
