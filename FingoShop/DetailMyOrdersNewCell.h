//
//  DetailMyOrdersNewCell.h
//  FingoShop
//
//  Created by Rambabu Mannam on 03/06/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailMyOrdersNewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblProductCost;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblQuantity;
@property (weak, nonatomic) IBOutlet UILabel *lblSoldby;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;

@end
