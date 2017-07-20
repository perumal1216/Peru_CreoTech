//
//  Reachability Manager.m
//  ReachabilityTM
//
//  Created by Bart Jacobs on 28/06/13.
//  Copyright (c) 2013 Mobile Tuts. All rights reserved.
//

#import "ReachabilityManagerTM.h"

#import "ReachabilityTM.h"

@implementation ReachabilityManagerTM

#pragma mark -
#pragma mark Default Manager
+ (ReachabilityManagerTM *)sharedManager {
    static ReachabilityManagerTM *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

#pragma mark -
#pragma mark Memory Management
- (void)dealloc {
    // Stop Notifier
    if (_reachability) {
        [_reachability stopNotifier];
    }
}

#pragma mark -
#pragma mark Class Methods
+ (BOOL)isReachable {
    return [[[ReachabilityManagerTM sharedManager] reachability] isReachable];
}

+ (BOOL)isUnreachable {
    return ![[[ReachabilityManagerTM sharedManager] reachability] isReachable];
}

+ (BOOL)isReachableViaWWAN {
    return [[[ReachabilityManagerTM sharedManager] reachability] isReachableViaWWAN];
}

+ (BOOL)isReachableViaWiFi {
    return [[[ReachabilityManagerTM sharedManager] reachability] isReachableViaWiFi];
}

#pragma mark -
#pragma mark Private Initialization
- (id)init {
    self = [super init];
    
    if (self) {
        // Initialize ReachabilityTM
        self.reachability = [ReachabilityTM  reachabilityWithHostname:@"www.google.com"];
        
        // Start Monitoring
        [self.reachability startNotifier];
    }
    
    return self;
}

@end
