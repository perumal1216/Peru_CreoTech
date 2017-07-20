//
//  NotificationCell.h
//  FingoShop
//
//  Created by Rambabu Mannam on 25/04/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *notificationImageView;
@property (strong, nonatomic) IBOutlet UILabel *offerTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *offerDescriptionLabel;

@end
