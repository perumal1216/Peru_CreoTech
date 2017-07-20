//
//  PayUModelPaymentParams.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 28/09/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayUHashes.h"
#import "PayUModelStoredCard.h"

@interface PayUModelPaymentParams : NSObject


// Mandatory Parameters
@property (strong, nonatomic) NSString * key;
@property (strong, nonatomic) NSString * amount;
@property (strong, nonatomic) NSString * productInfo;
@property (strong, nonatomic) NSString * firstName;
@property (strong, nonatomic) NSString * email;
@property (strong, nonatomic) NSString * transactionID;
@property (strong, nonatomic) NSString * SURL;
@property (strong, nonatomic) NSString * FURL;
// For setting Environment
//  0   is for Production
//  1   is for MobileTest
@property (strong, nonatomic) NSString *Environment;
// Hashes
@property (strong, nonatomic) PayUHashes *hashes;



// Other Parameters
@property (strong, nonatomic) NSString * userCredentials;
@property (strong, nonatomic) NSString * phoneNumber;



// Optional Parameters
@property (strong, nonatomic) NSString * address1;
@property (strong, nonatomic) NSString * address2;
@property (strong, nonatomic) NSString * city;
@property (strong, nonatomic) NSString * state;
@property (strong, nonatomic) NSString * country;
@property (strong, nonatomic) NSString * zipcode;
@property (strong, nonatomic) NSString * udf1;
@property (strong, nonatomic) NSString * udf2;
@property (strong, nonatomic) NSString * udf3;
@property (strong, nonatomic) NSString * udf4;
@property (strong, nonatomic) NSString * udf5;
@property (strong, nonatomic) NSString * CURL;
@property (strong, nonatomic) NSString * CODURL;
@property (strong, nonatomic) NSString * dropCategory;
@property (strong, nonatomic) NSString * enforcePayMethod;
@property (strong, nonatomic) NSString * customNote;
@property (strong, nonatomic) NSString * noteCategory;
@property (strong, nonatomic) NSString * apiVersion;
@property (strong, nonatomic) NSString * shippingFirstname;
@property (strong, nonatomic) NSString * shippingLastname;
@property (strong, nonatomic) NSString * shippingAddress1;
@property (strong, nonatomic) NSString * shippingAddress2;
@property (strong, nonatomic) NSString * shippingCity;
@property (strong, nonatomic) NSString * shippingState;
@property (strong, nonatomic) NSString * shippingCountry;
@property (strong, nonatomic) NSString * shippingZipcode;
@property (strong, nonatomic) NSString * shippingPhone;
@property (strong, nonatomic) NSString * offerKey;



// Param for Stored card
@property (strong, nonatomic) PayUModelStoredCard *storedCard;



// Param for CCDC
@property (strong, nonatomic) NSString *cardNumber;
@property (strong, nonatomic) NSString *expMonth;
@property (strong, nonatomic) NSString *expYear;
@property (strong, nonatomic) NSString *CVV;
@property (strong, nonatomic) NSString *nameOnCard;
@property (strong, nonatomic) NSString *storeCardName;
@property (strong, nonatomic) NSString *saveStoreCard;



// Param for NetBanking
@property (strong, nonatomic) NSString *bankCode;

@end
