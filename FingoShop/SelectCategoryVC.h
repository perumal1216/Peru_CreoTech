//
//  SelectCategoryVC.h
//  FingoShop
//
//  Created by Perumal on 22/04/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface SelectCategoryVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property(nonatomic,strong) NSString * categoryFlag;
@end
