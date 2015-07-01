//
//  TLError.h
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 6/30/15.
//
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const TLErrorDomain;

typedef NS_ENUM(NSInteger, TLErrorCode) {
    TLSendWithCompletionNotImplementedError, // TLSRequest implementation does not override sendWithCompletion
    TLBadRequestError,
    TLServerError
};

FOUNDATION_EXPORT NSString * const TLErrorCode_toString[];

@interface TLError : NSObject

@end
