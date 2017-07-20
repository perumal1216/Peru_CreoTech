//
//  PayUValidations.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 01/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayUModelPaymentParams.h"


@interface PayUValidations : NSObject

-(NSMutableString *)validateMandatoryParams: (PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validateStoredCardParams: (PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validateNetbankingParams: (PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validateCCDCParams: (PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validatePaymentRelatedDetailsParam:(PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validateOfferStatusParam:(PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validateDeleteStoredCard: (PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validateVASParams:(PayUModelPaymentParams *) paymentParam;

//Card Validations
-(NSString *)validateCardNumber:(NSString *) cardNumber;
-(NSString *)validateLuhnCheckOnCardNumber:(NSString *) cardNumber;
-(NSString *)getIssuerOfCardNumber:(NSString *) cardNumber;
-(BOOL)validateRegex:(NSString *) regex withCardNumber:(NSString *) cardNumber;

// General Validations
-(BOOL)isNumeric:(NSString *) paramString;
-(BOOL)isAlphabet:(NSString *) paramString;

@end
