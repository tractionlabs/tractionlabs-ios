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
        /*
        NSLog( @"%@", [TLApplicationHelper getDeviceArchitecture] );
        NSLog( @"%@", [TLApplicationHelper getDeviceName] );
        NSLog( @"%@", [TLApplicationHelper getDeviceModel] );
        NSLog( @"%@", [TLApplicationHelper getOS] );
        NSLog( @"%@", [TLApplicationHelper getOSVersion] );
        NSLog( @"%li", (long)[TLApplicationHelper getScreenWidth] );
        NSLog( @"%li", (long)[TLApplicationHelper getScreenHeight] );
        NSLog( @"%f", [TLApplicationHelper getScreenScale] );
        NSLog( @"%@", [TLApplicationHelper getVendorUUID] );
        NSLog( @"%@", [TLApplicationHelper getDeviceUUID] );
        NSLog( @"%@", [TLApplicationHelper getAppVersion] );
        NSLog( @"%@", [TLApplicationHelper getBundleID] );
        NSLog( @"%@", [TLApplicationHelper getCarrier] );
         */
    }
    return self;
}

- (void)sendWithCompletion:(TLRequestCompletion)completion {
    NSMutableDictionary* json = [NSMutableDictionary new];
    
    [json safeSetObject:[TLApplicationHelper getDeviceUUID] forKey:TRACTIONLABS_EVENT_DEVICE_UUID_KEY];
    [json safeSetObject:[TLApplicationHelper getDeviceUUID] forKey:TRACTIONLABS_EVENT_PLATFORM_KEY];
    
    [self postWithDictionary:json completion:completion];
}

@end
