//
//  CardCell.h
//  HotelBooking
//
//  Created by SkoopView on 10/06/16.
//  Copyright © 2016 Kushal Mandala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnCardSelection;
@property (weak, nonatomic) IBOutlet UILabel *lblCardNo1;
@property (weak, nonatomic) IBOutlet UILabel *lblCardNo2;

@end
