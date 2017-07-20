//
//  ProductDetailNewVC.h
//  FingoShop
//
//  Created by SkoopView on 29/08/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"

@interface ProductDetailNewVC : UIViewController<ServiceConnectionDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate>
{
    ServiceConnection *serviceconn;
    NSString *ServiceType;
    UIPickerView *pickerView;
     UIPickerView *pickerView1;
    UIToolbar *toolBar;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property(nonatomic,retain)NSMutableDictionary *productDetailsDict;
@property(nonatomic,retain)NSMutableDictionary *productDetailsDict1;

@end
