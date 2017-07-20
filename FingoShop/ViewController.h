//
//  ViewController.h
//  Kart
//
//  Created by SkoopView on 13/06/16.
//  Copyright © 2016 SkoopView. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnection.h"
#import "KIImagePager.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    ServiceConnection *serviceconn;

}
@property (weak, nonatomic) IBOutlet UIScrollView *main_scrollview;
@property (weak, nonatomic) IBOutlet UICollectionView *top_category_collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *offers_collectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *mensFashion_collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *womenfashion_collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *electronic_collView_Vertical;
@property (weak, nonatomic) IBOutlet UICollectionView *electronic_collView_horizental;
@property (weak, nonatomic) IBOutlet UICollectionView *art_collectionView;


@end

