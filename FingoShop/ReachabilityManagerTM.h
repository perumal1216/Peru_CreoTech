//
//  ReachabilityManagerTM.h
//  ReachabilityTM
//
//  Created by Bart Jacobs on 28/06/13.
//  Copyright (c) 2013 Mobile Tuts. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ReachabilityTM;

@interface ReachabilityManagerTM : NSObject

@property (strong, nonatomic) ReachabilityTM *reachability;

#pragma mark -
#pragma mark Shared Manager
+ (ReachabilityManagerTM *)sharedManager;

#pragma mark -
#pragma mark Class Methods
+ (BOOL)isReachable;
+ (BOOL)isUnreachable;
+ (BOOL)isReachableViaWWAN;
+ (BOOL)isReachableViaWiFi;

@end
