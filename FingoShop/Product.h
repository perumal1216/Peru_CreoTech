//
//  Product.h
//  FingoShop
//
//  Created by kushal mandala on 15/07/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property NSString *image;
@property NSString *name;
@property NSString *oldprice;
@property NSString *newprice;
@property NSString *rating;
@property NSString *productId;
@property NSString *seller;
@property NSString *Discount;
@property NSString *qty;


-(id)initWithName:(NSString *)name image:(NSString *)image oldPrice:(NSString *)oldprice newPrice:(NSString *)newprice rating:(NSString *)rating productId:(NSString *)productId seller:(NSString *)seller Discount:(NSString *)Discount qty:(NSString *)qty;


@end
