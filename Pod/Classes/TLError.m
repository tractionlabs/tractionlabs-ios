//
//  TLError.m
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 6/30/15.
//
//

#import "TLError.h"

NSString * const TLErrorDomain = @"com.tractionlabs";

NSString * const TLErrorCode_toString[] = {
    [TLSendWithCompletionNotImplementedError] = @"TLSendWithCompletionNotImplementedError",
    [TLBadRequestError] = @"TLBadRequestError",
    [TLServerError] = @"TLServerError"
};

@implementation TLError

@end
