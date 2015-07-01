//
//  TractionLabs.m
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 6/30/15.
//
//

#import "TractionLabs.h"
#import "TLConfiguration.h"

@implementation TractionLabs

+ (instancetype)sharedInstance {
    static TractionLabs* tractionLabs;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tractionLabs = [[TractionLabs alloc] init];
    });
    return tractionLabs;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    TLConfiguration* configuration = [TLConfiguration sharedInstance];
    if (![configuration getApplicationId]) {
        NSLog(@"[TractionLabs Warning] Please enter your tractionlabs_application_id in the plist!");
        return NO;
    }
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return YES;
}

- (void)configureWithApplicationId:(NSString*)applicationId {
    
}

@end
