//
//  Cart.m
//  FingoShop
//
//  Created by kushal mandala on 15/07/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import "Cart.h"

@implementation Cart
+(Cart *) singleInstance
{
    static Cart *instance = nil;
    @synchronized(self) {
        if (instance == nil) {
            instance = [[Cart alloc] init];
        }
    }
    return instance;
}

-(BOOL)checkItemInCart:(Product *) sellingItem
{
    if (self.positions != nil) {
        
        for(id cartItem in self.positions) {
            
            if (sellingItem == cartItem) {
                return YES;
                
            }
        }
    }
    return NO;
}

-(void)addToCart:(Product *)sellingItem
{
    if (self.positions == nil) {
        self.positions = [NSMutableArray new];
    }
    [self.positions addObject:sellingItem];
}

-(void)updateToCart:(Product *)sellingItem atIndex:(NSUInteger)index
{
    
    [self.positions replaceObjectAtIndex:index withObject:sellingItem];
    
    
}


@end
