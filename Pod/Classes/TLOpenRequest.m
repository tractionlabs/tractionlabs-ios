//
//  TLOpenRequest.m
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 7/1/15.
//
//

#import "TLOpenRequest.h"
#import "TLApplicationHelper.h"
#import "NSMutableDictionary+TractionLabs.h"

@implementation TLOpenRequest

- (instancetype)init {
    self = [super initWithAction:@"open"];
    if( self ) {
    }
    return self;
}

- (void)sendWithCompletion:(TLRequestCompletion)completion {
    NSMutableDictionary* json = [NSMutableDictionary new];
    [json safeSetObject:[TLApplicationHelper getDeviceUUID] forKey:TRACTIONLABS_EVENT_DEVICE_UUID_KEY];
    [json safeSetObject:[TLApplicationHelper getVendorUUID] forKey:TRACTIONLABS_EVENT_VENDOR_UUID_KEY];
    [json safeSetObject:[TLApplicationHelper getOS] forKey:TRACTIONLABS_EVENT_PLATFORM_KEY];
    [json safeSetObject:[TLApplicationHelper getOSVersion] forKey:TRACTIONLABS_EVENT_OS_VERSION_KEY];
    
    [json safeSetObject:@([TLApplicationHelper getScreenWidth]) forKey:TRACTIONLABS_EVENT_SCREEN_WIDTH_KEY];
    [json safeSetObject:@([TLApplicationHelper getScreenHeight]) forKey:TRACTIONLABS_EVENT_SCREEN_HEIGHT_KEY];
    [json safeSetObject:@([TLApplicationHelper getColorDepth]) forKey:TRACTIONLABS_EVENT_COLOR_DEPTH_KEY];

    [json safeSetObject:[TLApplicationHelper getAppVersion] forKey:TRACTIONLABS_EVENT_APP_VERSION_KEY];
    [json safeSetObject:[TLApplicationHelper getBundleID] forKey:TRACTIONLABS_EVENT_BUNDLE_ID_KEY];
    [json safeSetObject:[TLApplicationHelper getCarrier] forKey:TRACTIONLABS_EVENT_CARRIER_KEY];
    [json safeSetObject:[TLApplicationHelper getLanguage] forKey:TRACTIONLABS_EVENT_LANGUAGE_KEY];
    [json safeSetObject:@([TLApplicationHelper getTimeZoneOffset]) forKey:TRACTIONLABS_EVENT_TIME_ZONE_OFFSET_KEY];
    [self postWithDictionary:json completion:completion];
}

@end
