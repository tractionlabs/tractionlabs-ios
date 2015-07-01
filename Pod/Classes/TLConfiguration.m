//
//  TLConfiguration.m
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 6/30/15.
//
//

#import "TLConfiguration.h"

NSString * const TRACTIONLABS_APPLICATION_ID_KEY = @"tractionlabs_application_id";

@interface TLConfiguration()

@property (copy, nonatomic) NSString *applicationId;

@end

@implementation TLConfiguration

+ (instancetype)sharedInstance {
    static TLConfiguration* configuration;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        configuration = [[TLConfiguration alloc] init];
    });
    
    return configuration;
}

- (instancetype)init {
    self = [super init];
    if( self ) {
        
    }
    return self;
}

- (NSString*)getApplicationId {
    if( !_applicationId ) {
        id applicationId = [[[NSBundle mainBundle] infoDictionary] objectForKey:TRACTIONLABS_APPLICATION_ID_KEY];
        if (applicationId) {
            if ([applicationId isKindOfClass:[NSString class]]) {
                _applicationId = applicationId;
            }
        }
    }
    return _applicationId;
}

@end
