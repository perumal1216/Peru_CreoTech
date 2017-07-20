//
//  ComplexItem.h
//  YUTableViewDemo
//
//  Created by Yücel Uzun on 04/02/14.
//  Copyright (c) 2014 Yücel Uzun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplexItem : NSObject

@property (nonatomic, strong) NSString * name1,*name2;
@property (nonatomic, strong) NSString * explenation,*explenation1;
@property (nonatomic, strong) NSArray  * randomSubitems,* randomSubitems1;

- (id) initWithTypeKids: (NSString *) typeKids;
- (id) initWithTypeArts: (NSString *) typeArts;
- (id) initWithTypeWomen: (NSString *) typeWomen;
- (id) initWithTypeSports: (NSString *) typeSports;
- (id) initWithTypeBooks: (NSString *) typeBooks;
- (id) initWithTypeHome: (NSString *) typeHome;
- (id) initWithTypeMen: (NSString *) typeMen;
- (id) initWithTypeElectronics: (NSString *) typeElectronics;
- (id) initWithTypeOffers: (NSString *) typeOffers;

@end
