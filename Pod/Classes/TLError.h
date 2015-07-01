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
    TLBadRequestError,
    TLServerError
};

@interface TLError : NSObject

@end
