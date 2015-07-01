//
//  TLRequestQueue.h
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 6/30/15.
//
//

#import <Foundation/Foundation.h>

@class TLRequest;

@interface TLRequestQueue : NSObject

+ (instancetype)sharedQueue;

- (void)enqueue:(TLRequest*)request;
- (TLRequest*)dequeue;
- (TLRequest*)peek;
- (NSInteger)size;

- (void)process;

@end
