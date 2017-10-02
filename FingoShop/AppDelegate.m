//
//  AppDelegate.m
//  FingoShop
//
//  Created by fis on 25/06/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import "AppDelegate.h"
#import "ReachabilityTM.h"
#import "ReachabilityManagerTM.h"
#define tagForCustomLoader          9100
#import "CustomLoader.h"
#import "FingoShopTags.pch"
#import <HockeySDK/HockeySDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize net,alertMSG,alertTTL;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //*********** Hockey app Starts Here **************
    
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"982551b3f8e44e1b9b87da0a5f303c13"];
    // Do some additional configuration if needed here
    [[BITHockeyManager sharedHockeyManager] startManager];
    [[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation]; // This line is obsolete in the crash only builds
   
    
    //*********** Internet Starts Here **************
    
    net = -1;
    
    
    [ReachabilityManagerTM sharedManager];
    
    
    // Initialize Reachability
    ReachabilityTM *reachability = [ReachabilityTM reachabilityWithHostname:@"www.google.com"];
    
    reachability.reachableBlock = ^(ReachabilityTM *reachability) {
        
        NSLog(@" APP Network is reachable.");
        
        NetworkStatus internetStatus = [reachability currentReachabilityStatus];
        switch (internetStatus)
        {
                case ReachableViaWiFi:
            {
                NSLog(@" APP The internet is working via WIFI");
                net = 1;
                break;
            }
                
                case ReachableViaWWAN:
            {
                NSLog(@" APP The internet is working via WWAN!");
                net = 1;
                break;
            }
        }
    };
    
    reachability.unreachableBlock = ^(ReachabilityTM *reachability) {
        
        NSLog(@"APP Network is unreachable.");
        
        NetworkStatus internetStatus = [reachability currentReachabilityStatus];
        if(internetStatus == NotReachable)
        {
            NSLog(@"APP The internet is down.");
            net = 0;
        }
    };
    
    
    // Start Monitoring
    [reachability startNotifier];
    alertTTL = @"Please Make Sure you are connected to Internet";
    
    alertMSG = @"We're sorry, but this version of the app requires an Internet connection. The next version will allow more off-line functionality";
    
    //*********** Internet Ends Here **************
    
    
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"])
    {
        
        NSString *url_str=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/"];
        
        
        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:url_str]];
        
        NSError *error;
        NSDictionary *Respose_dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"Respose_dic arr......%@",Respose_dic);
        
        [[NSUserDefaults standardUserDefaults] setObject:[Respose_dic objectForKey:@"sessionid"] forKey:@"sessionid"];
        
        
    }
    
    
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [GIDSignIn sharedInstance].clientID =@"101647739636-brud409mdn2c7srmfkdehr5kef1877lc.apps.googleusercontent.com";
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    NSString *urlString=[url absoluteString];
    if ([[urlString substringToIndex:17]isEqualToString:@"fb933245113454337"])
    {
        
        
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation];
    }
    else
    {
        return [[GIDSignIn sharedInstance] handleURL:url
                                   sourceApplication:sourceApplication
                                          annotation:annotation];
    }
    
    
    // Add any custom logic here.
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
    //    serviceconn = [[ServiceConnection alloc]init];
    //    serviceconn = nil;
    //  NSURLConnection * conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    //[conn st]
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "VAMSI.FingoShop" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FingoShop" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FingoShop.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// MARK:- Custom Loader

//Loader Methods
-(void)showCustomLoader:(UIViewController *)senderController
{
    if( [self.window viewWithTag:tagForCustomLoader])
        [[self.window viewWithTag:tagForCustomLoader] removeFromSuperview];
    
    CustomLoader *custLoader=[[CustomLoader alloc]initWithFrame:self.window.frame];
    custLoader.tag=tagForCustomLoader;
    [custLoader loadView];
    
    //    windowObj = [UIApplication sharedApplication].keyWindow;
    //    if (!windowObj) {
    //        windowObj = [[UIApplication sharedApplication].windows objectAtIndex:0];
    //    }
    [self.window insertSubview:custLoader aboveSubview:senderController.view];
    [self.window bringSubviewToFront:custLoader];
    // [senderController.view addSubview:custLoader];
    custLoader=nil;
}
-(void)removeCustomLoader:(UIViewController *)senderController
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if([self.window viewWithTag:tagForCustomLoader])
                [[self.window viewWithTag:tagForCustomLoader] removeFromSuperview];
        });
    });
}

//-(void)showCustomLoader:(UIViewController *)senderController
//{
//    if ([senderController.view viewWithTag:tagForCustomLoader] != nil) {
//        [senderController.view viewWithTag:tagForCustomLoader].removeFromSuperview;
//    }
//    
//}
//
//func showCustomLoaderForBottom(_ senderController: UIViewController) {
//    if (senderController.view!.viewWithTag(tagForCustomLoader) != nil) {
//        senderController.view!.viewWithTag(tagForCustomLoader)!.removeFromSuperview()
//    }
//    
//    
//    
//    let winodBoud : CGRect! = CGRect(x: 0.0, y: 0.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
//    let custLoader: CustomLoader = CustomLoader(frame:winodBoud)
//    custLoader.tag = tagForCustomLoader
//    custLoader.loadViewForPresentViewControllers()
//    senderController.view!.addSubview(custLoader)
//    //custLoader.removeFromSuperview()
//}
//
//func showCustomLoader(_ senderController: UIViewController) {
//    if (senderController.view!.viewWithTag(tagForCustomLoader) != nil) {
//        senderController.view!.viewWithTag(tagForCustomLoader)!.removeFromSuperview()
//    }
//    
//    let winodBoud : CGRect! = CGRect(x: 0.0, y: 0.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
//    let custLoader: CustomLoader = CustomLoader(frame:winodBoud)
//    custLoader.tag = tagForCustomLoader
//    custLoader.loadView()
//    senderController.view!.addSubview(custLoader)
//    //custLoader.removeFromSuperview()
//}
//
//func removeCustomLoader(_ senderController: UIViewController) {
//    DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {() -> Void in
//        DispatchQueue.main.async(execute: {() -> Void in
//            if (senderController.view!.viewWithTag(self.tagForCustomLoader) != nil) {
//                senderController.view!.viewWithTag(self.tagForCustomLoader)!.removeFromSuperview()
//            }
//        })
//    })
//}




@end
