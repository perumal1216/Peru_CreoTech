//
//  CartCell.h
//  FingoShop
//
//  Created by fis on 07/07/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSeller;
@property (weak, nonatomic) IBOutlet UILabel *lblQuantity;
@property (weak, nonatomic) IBOutlet UILabel *lblFinalPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imgProductImage;
@property (weak, nonatomic) IBOutlet UILabel *lblDiscount;
@property (weak, nonatomic) IBOutlet UIButton *btnQuantity;


@end
