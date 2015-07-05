//
//  TLRequest.m
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 6/30/15.
//
//

#import "TLRequest.h"
#import "TLConfiguration.h"
#import "TLError.h"

NSString * const TRACTIONLABS_RESPONSE_ERROR_KEY = @"tractionLabsErrorData";
NSString * const TRACTIONLABS_RESPONSE_ERROR_MESSAGE_KEY = @"message";

NSString * const TRACTIONLABS_EVENT_DEVICE_UUID_KEY = @"deviceUUID";
NSString * const TRACTIONLABS_EVENT_VENDOR_UUID_KEY = @"vendorUUID";
NSString * const TRACTIONLABS_EVENT_PLATFORM_KEY = @"platform";
NSString * const TRACTIONLABS_EVENT_HARDWARE_IDENTIFIER_KEY = @"hardwareIdentifier";

NSString * const TRACTIONLABS_EVENT_SCREEN_WIDTH_KEY = @"screenWidth";
NSString * const TRACTIONLABS_EVENT_SCREEN_HEIGHT_KEY = @"screenHeight";
NSString * const TRACTIONLABS_EVENT_COLOR_DEPTH_KEY = @"colorDepth";
NSString * const TRACTIONLABS_EVENT_OS_VERSION_KEY = @"osVersion";
NSString * const TRACTIONLABS_EVENT_APP_VERSION_KEY = @"appVersion";
NSString * const TRACTIONLABS_EVENT_BUNDLE_ID_KEY = @"bundleId";
NSString * const TRACTIONLABS_EVENT_CARRIER_KEY = @"carrier";
NSString * const TRACTIONLABS_EVENT_LANGUAGE_KEY = @"language";
NSString * const TRACTIONLABS_EVENT_TIME_ZONE_OFFSET_KEY = @"timeZoneOffset";

NSTimeInterval const TRACTIONLABS_REQUEST_TIMEOUT = 60.0;

@interface TLRequest()

@property(nonatomic,copy) NSString* action;

@end

@implementation TLRequest

- (instancetype)initWithAction:(NSString*)action {
    if( self = [super init] ) {
        _action = action;
    }
    
    return self;
}

- (void)sendWithCompletion:(TLRequestCompletion)completion {
    NSLog( @"[TractionLabs Warning] sendWithCompletion not implemented for %@", [self class] );
    NSError* error = [NSError errorWithDomain:TLErrorDomain
                                         code:TLSendWithCompletionNotImplementedError
                                     userInfo:@{@"TLRequestClass":[self class]}];
    if( completion ) {
        completion(nil, error);
    }
}

- (void)postWithDictionary:(NSDictionary*)dictionary completion:(TLRequestCompletion)completion {
    NSError *error;
    TLConfiguration* config = [TLConfiguration sharedInstance];

    NSString* urlString = [NSString stringWithFormat:@"%@/%@/%@", [config getBaseUrl], self.action, [config getApplicationId]];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:TRACTIONLABS_REQUEST_TIMEOUT];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSData* data = nil;
    if( !(data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error]) ) {
        completion( nil, error );
        return;
    }

    [request setHTTPBody:data];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if( error ) {
            completion( nil, error );
            return;
        }

        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        if( httpResponse.statusCode >= 400 ) {
            NSError* parseError = nil;
            NSInteger errorCode = TLBadRequestError;
            
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
            NSDictionary* userInfo = responseObject?@{TRACTIONLABS_RESPONSE_ERROR_KEY:responseObject}:nil;
            
            error = [NSError errorWithDomain:TLErrorDomain code:errorCode userInfo:userInfo];
            
            completion( nil, error );
            return;
        }
        
        NSError* parseError = nil;
        id responseObject = nil;
        if( (responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError]) ) {
            completion( nil, parseError );
            return;
        }
        
        completion( responseObject, error );
    }];
    
    [task resume];
}

@end
