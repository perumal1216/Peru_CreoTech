//
//  PayUModelStoredCard.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 09/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayUModelStoredCard : NSObject

@property (nonatomic, strong) NSString * cardBin;
@property (nonatomic, strong) NSString * cardBrand;
@property (nonatomic, strong) NSString * cardCVV;
@property (nonatomic, strong) NSString * cardMode;
@property (nonatomic, strong) NSString * cardName;
@property (nonatomic, strong) NSString * cardNo;
@property (nonatomic, strong) NSString * cardToken;
@property (nonatomic, strong) NSString * cardType;
@property (nonatomic, strong) NSString * expiryMonth;
@property (nonatomic, strong) NSString * expiryYear;
@property (nonatomic, strong) NSString * isDomestic;
@property (nonatomic, strong) NSString * isExpired;
@property (nonatomic, strong) NSString * issuingBank;
@property (nonatomic, strong) NSString * nameOnCard;
@end

/*
 {
 "card_bin" = 512345;
 "card_brand" = MASTERCARD;
 "card_cvv" = 0;
 "card_mode" = CC;
 "card_name" = test;
 "card_no" = 512345XXXXXX2346;
 "card_token" = 4d23a61848547b1263291ab6dbb5efa34f1efd6e;
 "card_type" = CC;
 "expiry_month" = 10;
 "expiry_year" = 2015;
 isDomestic = Y;
 "is_expired" = 0;
 issuingBank = HDFC;
 "name_on_card" = test;
 }
*/