//
//  AmountDetailsCell.h
//  FingoShop
//
//  Created by Rambabu Mannam on 25/05/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AmountDetailsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblDelivery;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalAmount;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectShipment;
@property (weak, nonatomic) IBOutlet UILabel *lblShippingMethod;
@property (weak, nonatomic) IBOutlet UIButton *continue_button;

@end
