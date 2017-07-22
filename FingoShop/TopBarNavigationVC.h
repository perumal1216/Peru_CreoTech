//
//  TopBarNavigationVC.h
//  FingoShop
//
//  Created by Perumal on 11/06/17.
//  Copyright © 2017 Perumal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"
@interface TopBarNavigationVC : UIViewController<UITextFieldDelegate,ServiceConnectionDelegate>
{
    ServiceConnection *serviceConn;
}
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UILabel *cart_count_lbl;
@property (weak, nonatomic) IBOutlet UIButton *back_button;
@property (weak, nonatomic) IBOutlet UIButton *menu_button;

@end
