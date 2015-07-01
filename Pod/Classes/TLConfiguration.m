//
//  TLConfiguration.m
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 6/30/15.
//
//

#import "TLConfiguration.h"

NSString * const TRACTIONLABS_API_BASE_URL = @"https://api.tractionlabs.com/api/1.0";
NSString * const TRACTIONLABS_API_LOCALHOST_BASE_URL = @"http://localhost:8080/api/1.0";
NSString * const TRACTIONLABS_API_DEVELOPMENT_BASE_URL = @"http://dev.tractionlabs.com/api/1.0";
NSString * const TRACTIONLABS_API_QA_BASE_URL = @"https://qa.tractionlabs.com/api/1.0";

NSString * const TRACTIONLABS_ENVIRONMENT_LOCALHOST = @"localhost";
NSString * const TRACTIONLABS_ENVIRONMENT_DEVELOPMENT = @"development";
NSString * const TRACTIONLABS_ENVIRONMENT_QA = @"qa";
NSString * const TRACTIONLABS_ENVIRONMENT_PRODUCTION = @"production";

NSString * const TRACTIONLABS_APPLICATION_ID_KEY = @"tractionlabs_application_id";
NSString * const TRACTIONLABS_ENVIRONMENT_KEY = @"tractionlabs_environment";

@interface TLConfiguration()

@property (copy, nonatomic) NSString *applicationId;
@property (copy, nonatomic) NSString *environment;

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

- (NSString*)getEnvironment {
    if( !_environment ) {
        id environment = [[[NSBundle mainBundle] infoDictionary] objectForKey:TRACTIONLABS_ENVIRONMENT_KEY];
        if (environment) {
            if ([environment isKindOfClass:[NSString class]]) {
                _environment = [environment lowercaseString];
            }
        }
    }
    
    if( !_environment ) {
        _environment = TRACTIONLABS_ENVIRONMENT_PRODUCTION;
    }
    
    return _environment;
}

- (BOOL)isLocalhost {
    return [TRACTIONLABS_ENVIRONMENT_LOCALHOST isEqualToString:[self getEnvironment]];
}

- (BOOL)isDevelopment {
    return [TRACTIONLABS_ENVIRONMENT_DEVELOPMENT isEqualToString:[self getEnvironment]];
}

- (BOOL)isQA {
    return [TRACTIONLABS_ENVIRONMENT_QA isEqualToString:[self getEnvironment]];
}

- (BOOL)isProduction {
    return ![self isLocalhost] && ![self isDevelopment] && ![self isQA];
}

- (NSString*) getBaseUrl {
    if( [self isLocalhost] ) {
        return TRACTIONLABS_API_LOCALHOST_BASE_URL;
    } else if ( [self isDevelopment] ) {
        return TRACTIONLABS_API_DEVELOPMENT_BASE_URL;
    } else if ( [self isQA] ) {
        return TRACTIONLABS_API_QA_BASE_URL;
    } else {
        return TRACTIONLABS_API_BASE_URL;
    }
}

@end
