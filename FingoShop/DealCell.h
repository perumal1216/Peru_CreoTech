//
//  DealCell.h
//  Kart
//
//  Created by SkoopView on 13/06/16.
//  Copyright © 2016 SkoopView. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblCategoryTitle;
@property(nonatomic,strong)IBOutlet UIImageView *imageVW;
@property (weak, nonatomic) IBOutlet UILabel *discount_lbl;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice_lbl;
@property (weak, nonatomic) IBOutlet UILabel *finalPrice_lbl;



@end
