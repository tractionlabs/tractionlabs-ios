//
//  TLRequest.h
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 6/30/15.
//
//

#import <Foundation/Foundation.h>

typedef void (^TLRequestCompletion)(id responseObject, NSError* error);

FOUNDATION_EXPORT NSString * const TRACTIONLABS_RESPONSE_ERROR_KEY;
FOUNDATION_EXPORT NSString * const TRACTIONLABS_RESPONSE_ERROR_MESSAGE_KEY;

FOUNDATION_EXPORT NSString * const TRACTIONLABS_EVENT_DEVICE_UUID_KEY;
FOUNDATION_EXPORT NSString * const TRACTIONLABS_EVENT_PLATFORM_KEY;

@interface TLRequest : NSObject

- (instancetype)initWithAction:(NSString*)action;

- (void)sendWithCompletion:(TLRequestCompletion)completion;
- (void)postWithDictionary:(NSDictionary*)dictionary completion:(TLRequestCompletion)completion;

@end
