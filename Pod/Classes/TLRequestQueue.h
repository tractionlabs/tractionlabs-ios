//
//  TLRequestQueue.h
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 6/30/15.
//
//

#import <Foundation/Foundation.h>

@class TLServerRequest;

@interface TLRequestQueue : NSObject

+ (instancetype)sharedQueue;

- (void)enqueue:(TLServerRequest*)request;
- (TLServerRequest*)dequeue;
- (TLServerRequest*)peek;
- (NSInteger)size;

@end
