//
//  ServiceConnection.h
//  Fingo Shop
//
//  Created by apple on 06/07/16.
//  Copyright © 2016 kushal. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ServiceConnectionDelegate <NSObject>

- (void)jsonData:(NSDictionary *)jsonDict;
- (void)errorMessage:(NSString *)errMsg;

@end

@interface ServiceConnection : NSObject
-(void)startRequestForUrl:(NSURL *)url;
-(void)postRequestForUrl:(NSURL *)url postBody:(NSString *)post;

// ******* Webservices *********//

-(void)GetMainMenu;
-(void)GetHomePageCategories;
-(void)GetProductList:(NSString *)categoryId;
-(void)GetProductDetails:(NSString *)productId;
-(void)GetProductImages:(NSString *)productId;
-(void)performLogin:(NSMutableDictionary *)loginDict;
-(void)performSignup:(NSMutableDictionary *)signupDict;
-(void)performForgotpwd:(NSString *)email;
-(void)GetUserInfo;
-(void)performLogout;
-(void)GetWishList:(NSString *)Post;
-(void)AddToWishList:(NSString *)productId;
-(void)RemoveFromWishList:(NSString *)productId;
-(void)getAddressList;
-(void)AddAddress:(NSString *)post;
-(void)UpdateAddress:(NSString *)post;
-(void)DeleteAddress:(NSString *)addressId;
-(void)GetCustomerOrders;
-(void)GetCartInfo;
-(void)RemoveItemFromcart:(NSString *)post;
-(void)ApplyCoupon:(NSString *)post;
-(void)UpdateCartWithItemId:(NSString *)itemId andQuantity:(NSString *)qty;
-(void)AddToCart:(NSString *)PoductID qty:(NSString *)qty;
-(void)AddToCart:(NSString *)PoductID qty:(NSString *)qty option:(NSString *)optionId size:(NSString *)size option1:(NSString *)optionId1 size1:(NSString *)size1 compareStr:(NSString *)compareStr;
-(void)cashOnDeliveyAvailability:(NSString *)post;
-(void)GetMainBannerImages;
-(void)savePayment:(NSString *)paymentMethod;
-(void)submitOrder;
-(void)SaveAddress:(NSString *)post;
-(void)GetShipmentDetails;
-(void)SaveShipmentDetails:(NSString *)method;
-(void)submitPayUResponse:(NSString *)Post;
-(void)GetSimilarProductDetails:(NSString *)productId;
-(void)GetSearchList:(NSString *)Post;
-(void)GetOffersList;
-(void)GetNotificationsList;
-(void)destroyCartItems;
-(void)getPaymentMethods;
-(void)cancelOrder:(NSString*)orderID;
-(void)GetVirtualImage:(NSString *)productId;
-(void)GetCustomerAccount;
-(void)UpdateAccountDetails:(NSString *)post;
-(void)GetPointsBalance;
-(void)sendOTP:(NSString *)params;

//
//
//-(void)AddtoCart:(NSString *)productId Qty:(NSString *)qty;
//
//-(void)GetCartInfo;
//-(void)SaveAddress:(NSMutableDictionary *)AddressDict;
//-(void)GetShippingRates;
//-(void)SaveShipping;
//-(void)SavePayment;
//-(void)SubmitOrder;
//-(void)GetCustomerOrders:(NSString *)ProductId;
//



@property (strong, nonatomic) id<ServiceConnectionDelegate> delegate;
@property (retain, nonatomic) NSMutableData *webData;

@end
