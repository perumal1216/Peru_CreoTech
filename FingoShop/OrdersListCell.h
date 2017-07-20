//
//  OrdersListCell.h
//  FingoShop
//
//  Created by kushal mandala on 27/08/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblOrderNo;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblDeliveryEstimate;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *ProductTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblQty;
@property (weak, nonatomic) IBOutlet UILabel *lblSoldby;
@property (weak, nonatomic) IBOutlet UILabel *lblGrandTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalItems;


@end
