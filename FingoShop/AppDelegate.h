//
//  AppDelegate.h
//  FingoShop
//
//  Created by fis on 25/06/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "ServiceConnection.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,GIDSignInDelegate>{
     ServiceConnection *serviceconn;
}
@property int net;
@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) UIViewController *paymentOptionVC;

@property(nonatomic, strong) NSString *alertTTL, *alertMSG, *appBU;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// comited from perumal macbook pro .... date is 5/3/2017 time is 9 AM

@end

