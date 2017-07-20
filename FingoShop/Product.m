//
//  Product.m
//  FingoShop
//
//  Created by kushal mandala on 15/07/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import "Product.h"

@implementation Product

-(id)initWithName:(NSString *)name image:(NSString *)image oldPrice:(NSString *)oldprice newPrice:(NSString *)newprice rating:(NSString *)rating productId:(NSString *)productId seller:(NSString *)seller Discount:(NSString *)Discount qty:(NSString *)qty
{
    self = [super init];
    
    id returnValue = self;
    
    if (self) {
        
        Product *item = [[Product alloc] init];
        item.name = name;
        item.image = image;
        item.oldprice = oldprice;
        item.newprice = newprice;
        item.rating = rating;
        item.Discount = Discount;
        item.productId = productId;
        item.seller = seller;
        item.qty=qty;


        
        returnValue = item;
    }
    
    return returnValue;

}

@end
