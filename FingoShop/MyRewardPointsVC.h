//
//  MyRewardPointsVC.h
//  FingoShop
//
//  Created by Perumal on 01/05/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"

@interface MyRewardPointsVC : UIViewController<ServiceConnectionDelegate>
{
    ServiceConnection *seviceconn;
}
@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;

@end
