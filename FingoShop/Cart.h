//
//  Cart.h
//  FingoShop
//
//  Created by kushal mandala on 15/07/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface Cart : NSObject
@property NSMutableArray *positions;

+(Cart *) singleInstance;

-(BOOL)checkItemInCart:(Product *) sellingItem;

-(void)addToCart:(Product *)sellingItem;
-(void)updateToCart:(Product *)sellingItem atIndex:(NSUInteger)index;

@end
