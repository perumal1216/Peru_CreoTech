//
//  PayUSAGetHashes.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUSAGetHashes.h"


@implementation PayUSAGetHashes


-(void) generateHashFromServer:(PayUModelPaymentParams *) paymentParam withCompletionBlock:(hashRequestCompletionBlock)completionBlock{
    void(^serverResponseForHashGenerationCallback)(PayUHashes *hashes, NSString *errorString) = completionBlock;
  /*
    NSString *hashURL1=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/checkout/getHashes?sid=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSString *url_str = [hashURL1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:url_str];
    
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    NSError *error;
    NSMutableDictionary *resultsDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    */
    
    
    
    //    NSURL *hashURL = [NSURL URLWithString:@"https://payu.herokuapp.com/get_hash"];
    NSURL *hashURL = [NSURL URLWithString:@"https://www.fingoshop.com/restconnect/checkout/getHashes"];
    
     
    // create the request
    NSMutableURLRequest *hashRequest=[NSMutableURLRequest requestWithURL:hashURL
                                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
    // Specify that it will be a POST request
    hashRequest.HTTPMethod = @"POST";
    NSString *postParam = [NSString stringWithFormat:@"offerKey=%@&key=%@&hash=hash&email=%@&amount=%@&firstname=%@&txnid=%@&user_credentials=%@&udf1=%@&udf2=%@&udf3=%@&udf4=%@&udf5=%@&productinfo=%@&cardBin=cardBin",[self checkParamaterForNil:paymentParam.offerKey],[self checkParamaterForNil:paymentParam.key],[self checkParamaterForNil:paymentParam.email],[self checkParamaterForNil:paymentParam.amount],[self checkParamaterForNil:paymentParam.firstName],[self checkParamaterForNil:paymentParam.transactionID],[self checkParamaterForNil:paymentParam.userCredentials],[self checkParamaterForNil:paymentParam.udf1],[self checkParamaterForNil:paymentParam.udf2],[self checkParamaterForNil:paymentParam.udf3],[self checkParamaterForNil:paymentParam.udf4],[self checkParamaterForNil:paymentParam.udf5],[self checkParamaterForNil:paymentParam.productInfo]];
    
   // NSString *postParam = [NSString stringWithFormat:@"SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
        NSLog(@"-->>Hash generation Post Param = %@",postParam);
    //set request content type we MUST set this value.
    [hashRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //set post data of request
    [hashRequest setHTTPBody:[postParam dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:hashRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            serverResponseForHashGenerationCallback(nil ,error.localizedDescription);
        }
        else
        {
            NSDictionary *hashDictionary = [NSDictionary new];
            NSError *serializationError;
            hashDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&serializationError];
            
            if (serializationError) {
                serverResponseForHashGenerationCallback(nil ,error.localizedDescription);
            }//[[hashDictionary valueForKey:@"status"] isEqualToString:@"0"]
            //            else if([[hashDictionary valueForKey:@"message"] isEqualToString:@"successfully generated hash"]){
            PayUHashes *payUHashes = [PayUHashes new];
            NSMutableDictionary *dict=[hashDictionary objectForKey:@"result"];
            
            if ([dict valueForKey:@"payment_hash"]) {
                payUHashes.paymentHash = [dict valueForKey:@"payment_hash"];
                
            }
            if ([dict valueForKey:@"payment_related_details_for_mobile_sdk_hash"]) {
                payUHashes.paymentRelatedDetailsHash = [dict valueForKey:@"payment_related_details_for_mobile_sdk_hash"];
                
            }if ([dict valueForKey:@"vas_for_mobile_sdk_hash"]) {
                payUHashes.VASForMobileSDKHash = [dict valueForKey:@"vas_for_mobile_sdk_hash"];
                
            }if ([dict valueForKey:@"delete_user_card_hash"]) {
                payUHashes.deleteUserCardHash = [dict valueForKey:@"delete_user_card_hash"];
                
            }if ([dict valueForKey:@"edit_user_card_hash"]) {
                payUHashes.editUserCardHash = [dict valueForKey:@"edit_user_card_hash"];
                
            }if ([dict valueForKey:@"save_user_card_hash"]) {
                payUHashes.saveUserCardHash = [dict valueForKey:@"save_user_card_hash"];
                
            }if ([dict valueForKey:@"get_user_cards_hash"]) {
                payUHashes.getUserCardHash = [dict valueForKey:@"get_user_cards_hash"];
                
            }if ([dict valueForKey:@"check_offer_status_hash"]) {
                payUHashes.offerHash = [dict valueForKey:@"check_offer_status_hash"];
                
            }
            
            
            
            
            serverResponseForHashGenerationCallback(payUHashes ,nil);
            //            }
            //            else{
            //                serverResponseForHashGenerationCallback(nil,[hashDictionary valueForKey:@"message"]);
            //            }
        }
        
    }] resume];
    
}
-(NSString *)checkParamaterForNil:(NSString *) parameter{
    if (parameter == nil) {
        return @"";
    }
    else{
        return parameter;
    }
}

@end
