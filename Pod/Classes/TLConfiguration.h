//
//  TLConfiguration.h
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 6/30/15.
//
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const TRACTIONLABS_ENVIRONMENT_LOCALHOST;
FOUNDATION_EXPORT NSString * const TRACTIONLABS_ENVIRONMENT_DEVELOPMENT;
FOUNDATION_EXPORT NSString * const TRACTIONLABS_ENVIRONMENT_QA;
FOUNDATION_EXPORT NSString * const TRACTIONLABS_ENVIRONMENT_PRODUCTION;

@interface TLConfiguration : NSObject

+ (instancetype)sharedInstance;

- (NSString*)getApplicationId;
- (NSString*)getEnvironment;
- (BOOL)isLocalhost;
- (BOOL)isDevelopment;
- (BOOL)isQA;
- (BOOL)isProduction;
- (NSString*)getBaseUrl;

@end
