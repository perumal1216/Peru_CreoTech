//
//  MyOrdersCell.h
//  FingoShop
//
//  Created by Rambabu Mannam on 25/04/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrdersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *deliveredDate;

@end
