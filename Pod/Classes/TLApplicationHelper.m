//
//  TLApplicationHelper.m
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 7/1/15.
//
//

#import "TLApplicationHelper.h"
#include <sys/utsname.h>

NSString * const TRACTIONLABS_DEVICE_UUID_KEY = @"tractionlabs_device_uuid";


@implementation TLApplicationHelper

+ (BOOL)isSimulator {
    UIDevice *currentDevice = [UIDevice currentDevice];
    return [currentDevice.model rangeOfString:@"Simulator"].location != NSNotFound;
}

+ (NSString *)getDeviceArchitecture {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (NSString *)getDeviceModel {
    UIDevice *device = [UIDevice currentDevice];
    return [device model];
}

+ (NSString *)getDeviceName {
    return [[UIDevice currentDevice] name];
}

+ (NSString *)getLanguage {
    return [[NSLocale preferredLanguages] objectAtIndex:0];
}

+ (NSInteger)getTimeZoneOffset {
    return -[[NSTimeZone localTimeZone] secondsFromGMT]/60;
}

+ (NSString *)getOS {
    UIDevice *device = [UIDevice currentDevice];
    return [[device systemName] isEqualToString:@"iPhone OS"]?@"iOS":[device systemName];
}

+ (NSString *)getOSVersion {
    UIDevice *device = [UIDevice currentDevice];
    return [device systemVersion];
}

+ (NSInteger)getScreenWidth {
    UIScreen *mainScreen = [UIScreen mainScreen];
    return (NSInteger)CGRectGetWidth(mainScreen.bounds);
}

+ (NSInteger)getScreenHeight {
    UIScreen *mainScreen = [UIScreen mainScreen];
    return (NSInteger)CGRectGetHeight(mainScreen.bounds);
}

+ (NSInteger)getColorDepth {
    return 32;
}

+ (CGFloat)getScreenScale {
    UIScreen *mainScreen = [UIScreen mainScreen];
    return mainScreen.scale;
}

+ (NSString *)getVendorUUID {
    if( NSClassFromString(@"UIDevice") ) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    return nil;
}

+ (NSString *)getDeviceUUID {
    NSString *uid = nil;
    
    Class ASIdentifierManagerClass = NSClassFromString(@"ASIdentifierManager");
    if (ASIdentifierManagerClass ) {
        SEL sharedManagerSelector = NSSelectorFromString(@"sharedManager");
        id sharedManager = ((id (*)(id, SEL))[ASIdentifierManagerClass methodForSelector:sharedManagerSelector])(ASIdentifierManagerClass, sharedManagerSelector);
        SEL advertisingIdentifierSelector = NSSelectorFromString(@"advertisingIdentifier");
        NSUUID *uuid = ((NSUUID* (*)(id, SEL))[sharedManager methodForSelector:advertisingIdentifierSelector])(sharedManager, advertisingIdentifierSelector);
        uid = [uuid UUIDString];
    }
    
    if (!uid) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        uid = [defaults stringForKey:TRACTIONLABS_DEVICE_UUID_KEY];
        if(!uid ) {
            uid = [[NSUUID UUID] UUIDString];
            [defaults setObject:uid forKey:TRACTIONLABS_DEVICE_UUID_KEY];
            [defaults synchronize];
        }
    }
    
    return uid;
}


+ (NSString *)getAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getBundleID {
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)getCarrier {
    NSString *carrierName = nil;
    
    Class CTTelephonyNetworkInfoClass = NSClassFromString(@"CTTelephonyNetworkInfo");
    if (CTTelephonyNetworkInfoClass) {
        id networkInfo = [[CTTelephonyNetworkInfoClass alloc] init];
        SEL subscriberCellularProviderSelector = NSSelectorFromString(@"subscriberCellularProvider");
        
        id carrier = ((id (*)(id, SEL))[networkInfo methodForSelector:subscriberCellularProviderSelector])(networkInfo, subscriberCellularProviderSelector);
        if (carrier) {
            SEL carrierNameSelector = NSSelectorFromString(@"carrierName");
            carrierName = ((NSString* (*)(id, SEL))[carrier methodForSelector:carrierNameSelector])(carrier, carrierNameSelector);
        }
    }
    
    return carrierName;
}

@end
