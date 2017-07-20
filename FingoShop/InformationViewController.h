//
//  InformationViewController.h
//  HotelBooking
//
//  Created by SkoopView on 20/05/16.
//  Copyright © 2016 Kushal Mandala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"


@interface InformationViewController : UIViewController<ServiceConnectionDelegate,NSURLSessionDataDelegate>
{
    ServiceConnection *serviceconn;
    NSString *ServiceType;

}
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) NSMutableDictionary *addressDict;
@end
