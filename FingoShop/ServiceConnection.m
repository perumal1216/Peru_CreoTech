//
//  ServiceConnection.m
//  Fingo Shop
//
//  Created by apple on 06/07/16.
//  Copyright © 2016 kushal. All rights reserved.
//

#import "ServiceConnection.h"
#import "Constants.h"

@implementation ServiceConnection



#pragma mark - ServiceConnection Methods

-(void)submitPayUResponse:(NSString *)Post
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/checkout/processPayUResponse?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self postRequestForUrl:url postBody:Post];
    
    
}

-(void)GetVirtualImage:(NSString *)productId
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/products/getVirtualPic?product=%@",productId];
    
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
    
}

-(void)GetShipmentDetails
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/checkout/getShippingRates?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
    
}

-(void)SaveShipmentDetails:(NSString *)method
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/checkout/saveShipping?shipping_method=%@&SID=%@",method,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
    
}

-(void)getPaymentMethods {
    NSString *url_Method=[NSString stringWithFormat:@"http://swadeshcabs.com/restconnect/checkout/getPaymentMethods?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
}


-(void)savePayment:(NSString *)paymentMethod
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/checkout/savePayment?method=%@&SID=%@",paymentMethod,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    url_Method = [url_Method stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
    
}
-(void)sendOTP:(NSString *)url_Method
{
    
   // NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/sendotpcod?telephone=%@",params];
   NSString *urlPath = [url_Method stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSURL *url=[NSURL URLWithString:urlPath];
    
    [self startRequestForUrl:url];
    
    
}

-(void)submitOrder
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/checkout/submitOrder?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
    
}

-(void)cancelOrder:(NSString*)orderID
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/cancelOrder?order_id=%@&SID=%@",orderID,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
    
}



-(void)destroyCartItems
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/cart/destroy?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
    
}



-(void)GetMainMenu
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/index/menu?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];

    
}

-(void)GetMainBannerImages
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/index/getHomePageBanners?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    [self startRequestForUrl:url];
    
    
}


-(void)GetHomePageCategories
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/index/getHomePageCategories?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    [self startRequestForUrl:url];

    
}

-(void)GetProductList:(NSString *)categoryId{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/index/getCategoryProductsList?id=2&SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];

    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];


    
}

-(void)GetProductDetails:(NSString *)productId
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/products/getproductdetail?productid=%@&SID=%@",productId,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];

    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];


}

-(void)GetSimilarProductDetails:(NSString *)productId
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/index/getRelatedProducts?product_id=%@&SID=%@",productId,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
    
}


-(void)GetProductImages:(NSString *)productId
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/products/getPicLists?product=%@&SID=%@",productId,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];

    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];


}

-(void)performLogin:(NSMutableDictionary *)loginDict
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/login?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];

    
    NSURL *url=[NSURL URLWithString:url_Method];

}

-(void)performSignup:(NSMutableDictionary *)signupDict
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/register?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];

    
    NSURL *url=[NSURL URLWithString:url_Method];

}

-(void)performForgotpwd:(NSString *)email
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/forgotpwd?Email=%@&SID=%@",email,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];


}

-(void)GetUserInfo
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/getCustomerInfo?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];

    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];


}

-(void)performLogout
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/logout?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];

    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];


}

-(void)GetSearchList:(NSString *)Post
{
    //https://www.fingoshop.com/restconnect/search/searchnew?q=fidget
    // NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/search?q=%@&SID=%@",Post,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/search/searchnew?q=%@",Post];
    
    NSString* urlText = url_Method;
//    [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]
    NSString* urlTextEscaped =[urlText stringByAddingPercentEscapesUsingEncoding:
                               NSUTF8StringEncoding];
    //[urlText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSURL *main_url = [NSURL URLWithString: urlTextEscaped];
    NSLog(@"urlText:        '%@'", urlText);
    NSLog(@"urlTextEscaped: '%@'", urlTextEscaped);
    NSLog(@"url:            '%@'", main_url);
    

   // NSURL *url=[NSURL URLWithString:main_url];
    
    [self startRequestForUrl:main_url];
    
}

-(void)GetOffersList
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/index/offers?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
}

-(void)GetNotificationsList
{
    
    NSString *url_Method= [NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/index/getNotification"];
    //[NSString stringWithFormat:@"http://www.fingoshop.com/restconnect/index/trackOrder?email=rakesh.akkineni@ctouchproducts.com&order_id=100000004"];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
}


-(void)GetWishList:(NSString *)Post
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/wishlist/getWishlist?%@",Post];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
//    [self postRequestForUrl:url postBody:Post];


}

-(void)AddToWishList:(NSString *)post
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/wishlist/addtowishlist"];

    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self postRequestForUrl:url postBody:post];
    

    
    
  /*  NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/wishlist/addtowishlist?%@",post];
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
*/

   

}

-(void)RemoveFromWishList:(NSString *)productId
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/wishlist/removewishlistitem?id=%@&SID=%@",productId,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];

    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
}

-(void)cashOnDeliveyAvailability:(NSString *)post
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/checkdelivery/index/index/?zipcode=%@",post];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self postRequestForUrl:url postBody:post];
    
    
}


-(void)getAddressList
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/getAddressList?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];

    
    NSURL *url=[NSURL URLWithString:url_Method];
    NSLog(@"getadresslist %@",url);
    [self startRequestForUrl:url];


}

-(void)AddAddress:(NSString *)post
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/createaddress?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];

    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self postRequestForUrl:url postBody:post];
    

}

-(void)UpdateAddress:(NSString *)post
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/updateaddress?id=%@&SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"entity_id"],[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
//     NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/updateaddress"];
    
    
    
    

    NSURL *url=[NSURL URLWithString:url_Method];
    
   [self postRequestForUrl:url postBody:post];


}

-(void)DeleteAddress:(NSString *)addressId
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/deleteaddress?id=%@&SID=%@",addressId,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    NSURL *url=[NSURL URLWithString:url_Method];    
    [self startRequestForUrl:url];


}

-(void)SaveAddress:(NSString *)post
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/checkout/saveAddress?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    NSURL *url=[NSURL URLWithString:url_Method];
    [self postRequestForUrl:url postBody:post];
    
    
}


-(void)GetCustomerOrders

{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/getCustomerOrders?page=1&limit=10&SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];

}
-(void)GetPointsBalance
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/cart/getPointBalance?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
}


-(void)GetCustomerAccount
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/getAccountInfo?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];
    
}


-(void)UpdateAccountDetails:(NSString *)post
{
    
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/customer/setAccountInfo?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];

    
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self postRequestForUrl:url postBody:post];
    
    
}


-(void)AddToCart:(NSString *)PoductID qty:(NSString *)qty
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/cart/add?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
     NSString *post = [NSString stringWithFormat:@"product=%@&qty=%@",PoductID,qty];
    
   // NSString *post = [NSString stringWithFormat:@"product=%@&qty=%@&super_attribute=%@",PoductID,qty];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    [self postRequestForUrl:url postBody:post];
    
}

-(void)AddToCart:(NSString *)PoductID qty:(NSString *)qty option:(NSString *)optionId size:(NSString *)size option1:(NSString *)optionId1 size1:(NSString *)size1 compareStr:(NSString *)compareStr

//-(void)AddToCart:(NSString *)PoductID qty:(NSString *)qty option:(NSString *)optionId size:(NSString *)size
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/cart/add?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:size forKey:optionId];
        
        NSMutableArray *array=[[NSMutableArray alloc] init];
        [array addObject:dict];
    
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:0
                                                     error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    // This will be the json string in the preferred format
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"{" withString:@"("];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"}" withString:@")"];
    NSString *post;

    if ([compareStr isEqualToString:@"super_attribute"]) {
        
         post = [NSString stringWithFormat:@"product=%@&qty=%@&super_attribute[%@]=%@&super_attribute[%@]=%@",PoductID,qty,optionId,size,optionId1,size1];
    }
    else{
         post = [NSString stringWithFormat:@"product=%@&qty=%@&super_attribute[%@]=%@",PoductID,qty,optionId,size];
    }
    
   
    
   
    
    
//    NSMutableDictionary *dict = [NSMutableDictionary new];
//    NSMutableDictionary *dict1 = [NSMutableDictionary new];
//    [dict1 setObject:size forKey:optionId];
//    [dict setObject:PoductID forKey:@"product"];
//    [dict setObject:qty forKey:@"qty"];
//    [dict setObject:dict1 forKey:@"super_attribute"];
//    NSString *post = [NSString stringWithFormat:@"%@",dict];
//    post = [post stringByReplacingOccurrencesOfString:@";" withString:@":"];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    [self postRequestForUrl:url postBody:post];
    
}



-(void)GetCartInfo
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/cart/getCartInfo?SID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];

}

-(void)RemoveItemFromcart:(NSString *)post
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/cart/remove?cart_item_id=%ld&SID=%@",(long)[post integerValue],[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];

}
-(void)ApplyCoupon:(NSString *)post
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/cart/postCoupon?coupon_code=%@&SID=%@",post,[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];

}
-(void)UpdateCartWithItemId:(NSString *)itemId andQuantity:(NSString *)qty
{
    NSString *url_Method=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/cart/update?cart_item_id=%ld&qty=%ld&SID=%@",(long)[itemId integerValue],(long)[qty integerValue],[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]];
    
    NSURL *url=[NSURL URLWithString:url_Method];
    
    [self startRequestForUrl:url];


}





/* HTTP service calls */

- (void)startRequestForUrl:(NSURL *)url
{
    //NSURLRequest * request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0];
   // NSURLConnection *conn = [NSURLConnection connectionWithRequest:request
                                                          //delegate:self];
    
//    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    if( theConnection )
//    {
//        _webData = [NSMutableData data];
//    }
//    else
//    {
//        NSLog(@"theConnection is NULL");
//    }
   // [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:ourBlock];

        
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSLog(@"%@",response);
        NSDictionary * jsonDict;
        
        
        
        if (data) {
            jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        }
        
        if ([data length] > 0 && error == nil)
            [self.delegate jsonData:jsonDict];
        else if ([data length] == 0 && error == nil)
            [self.delegate errorMessage:@"No Data"];
        else if (error != nil && error.code == kCFURLErrorTimedOut)
            [self.delegate errorMessage:@"The Connection Timed Out!"];
        else if (error != nil && error.code == kCFURLErrorCannotConnectToHost)
            [self.delegate errorMessage:@"No Internet Connection"];
        else if(error != nil)
            [self.delegate errorMessage:@"Some thing wrong! Please try again."];
    }];
    
}

//- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
//    return nil;
//}
#pragma mark - Post

- (void)postRequestForUrl:(NSURL *)url postBody:(NSString *)post
{
    
    
    NSData  * postData   = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString * postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    request.timeoutInterval=120;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            NSLog(@"%@",response);
            NSDictionary * jsonDict;
    
            if (data) {
                jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            }
    
            if ([data length] > 0 && error == nil)
                [self.delegate jsonData:jsonDict];
            else if ([data length] == 0 && error == nil)
                [self.delegate errorMessage:@"No Data"];
            else if (error != nil && error.code == kCFURLErrorTimedOut)
                [self.delegate errorMessage:@"The Connection Timed Out!"];
            else if (error != nil && error.code == kCFURLErrorCannotConnectToHost)
                [self.delegate errorMessage:@"No Internet Connection"];
            else if(error != nil)
                [self.delegate errorMessage:@"Some thing wrong! Please try again."];
        }];
    
}

#pragma  mark - NSURLConnection Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%@",response);
    
    [_webData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_webData appendData:data];
}

//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    NSLog(@"ERROR with theConenction");
//    
//    if (error != nil && error.code == kCFURLErrorTimedOut)
//        [self.delegate errorMessage:@"The Connection Timed Out!"];
//    else if (error != nil && error.code == kCFURLErrorCannotConnectToHost)
//        [self.delegate errorMessage:@"No Internet Connection"];
//    else if(error != nil)
//        [self.delegate errorMessage:@"Some thing wrong! Please try again."];
//    else
//        [self.delegate errorMessage:@"Some thing wrong! Please try again."];
//    
//}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[_webData length]);
    
    NSDictionary * jsonDict;
    
    jsonDict = [NSJSONSerialization JSONObjectWithData:_webData options:NSJSONReadingAllowFragments error:nil];
    [self.delegate jsonData:jsonDict];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR with theConenction");
    
    if (error != nil && error.code == kCFURLErrorTimedOut)
        [self.delegate errorMessage:@"The Connection Timed Out!"];
    else if (error != nil && error.code == kCFURLErrorCannotConnectToHost)
        [self.delegate errorMessage:@"No Internet Connection"];
    else if(error != nil)
        [self.delegate errorMessage:@"Some thing wrong! Please try again."];
    else
        [self.delegate errorMessage:@"Some thing wrong! Please try again."];
    
}

//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
//}
@end
