//
//  WishListCell.h
//  FingoShop
//
//  Created by Rambabu Mannam on 25/04/1938 Saka.
//  Copyright © 1938 Saka fis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishListCell : UICollectionViewCell

@property(nonatomic,strong)IBOutlet UIImageView *imageVW;
@property(nonatomic,strong)IBOutlet UILabel *Name_lbl;

@property(nonatomic,strong)IBOutlet UILabel *newprice_lbl;
@property(nonatomic,strong)IBOutlet UILabel *oldPrice_lbl;
@property(nonatomic,strong)IBOutlet UILabel*off_lbl;
@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@property (weak, nonatomic) IBOutlet UILabel *lblSeller;
@property (weak, nonatomic) IBOutlet UILabel *lblAvailability;
@property (weak, nonatomic) IBOutlet UILabel *lblReviewsCount;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;



@end
