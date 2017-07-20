//
//  Constants.h
//  Fingo Shop
//
//  Created by apple on 06/07/16.
//  Copyright © 2016 kushal. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSUInteger _WSConstCategoryVal;
extern NSMutableArray *mainCategoriesList;
extern NSString* _WSConstCategoryName;

extern NSMutableArray* _mainCatArr;
extern NSMutableDictionary* _subCatArr;
extern NSMutableDictionary* _childCatArr;
extern NSMutableDictionary* _shipmentAddressDict;
extern NSString* _SelectedShipmentName;
extern NSString* _SelectedShipmentPrice;
extern NSString* _SelectedShipmentCode;
extern NSMutableDictionary* _availableFiltersDict;
extern NSString* _WSConstSelectedCategoryType;
extern NSString* _WSConstScreenValue;
extern NSMutableArray* _searchFiltersProductsArray;
extern NSMutableDictionary* _selectedProductDict;
extern NSString* _WSServiceType;

extern NSString* _WSConstSelectedCategoryID;

extern NSString* _backNavigationName;
extern NSString* _backNavigationName1;
extern NSString* _backNavigationSortOption;
static NSString *const BaseURL = @"https://www.fingoshop.com/restconnect/customer/";




#define FONT(F) [UIFont fontWithName:@"TrebuchetMS" size:F]

@interface Constants : NSObject

@end
