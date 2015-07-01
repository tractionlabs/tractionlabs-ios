//
//  TLRequestQueue+TLOpenRequest.m
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 7/1/15.
//
//

#import "TLRequestQueue+TLOpenRequest.h"
#import "TLOpenRequest.h"

@implementation TLRequestQueue (TLOpenRequest)

- (void)enqueueOpenRequest {
    TLOpenRequest* openRequest = [[TLOpenRequest alloc] init];
    [self enqueue:openRequest];
    [self process];
}

@end
