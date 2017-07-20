//
//  SortViewController.h
//  FingoShop
//
//  Created by rizenew on 5/17/17.
//  Copyright © 2017 fis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *sortTableView;
@property(nonatomic,retain) NSString *filterFlag;
@property(nonatomic,strong) NSArray *sortOptionsArray;
@property(nonatomic,strong) NSMutableDictionary *available_filterDict;
@end
