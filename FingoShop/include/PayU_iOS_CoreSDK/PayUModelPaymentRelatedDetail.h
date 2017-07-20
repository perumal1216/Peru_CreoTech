//
//  PayUModelPaymentRelatedDetail.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 09/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayUModelNetBanking.h"
#import "PayUModelStoredCard.h"

@interface PayUModelPaymentRelatedDetail : NSObject

@property (nonatomic, strong) NSMutableArray *netBankingArray;
@property (nonatomic, strong) NSMutableArray *storedCardArray;

@end
