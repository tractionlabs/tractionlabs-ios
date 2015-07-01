//
//  TLRequestQueue.m
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 6/30/15.
//
//

#import "TLRequestQueue.h"
#import "TLServerRequest.h"

@interface TLRequestQueue()

@property (nonatomic, strong) NSMutableArray* queue;

@end

@implementation TLRequestQueue

+ (instancetype)sharedQueue {
    static TLRequestQueue* sharedQueue;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedQueue = [[TLRequestQueue alloc] init];
    });
    
    return sharedQueue;
}

- (instancetype)init {
    self = [super init];
    if( self ) {
        _queue = [NSMutableArray new];
    }
    return self;
}

- (void)enqueue:(TLServerRequest*)request {
    @synchronized(self.queue) {
        if( request ) {
            [self.queue addObject:request];
        }
    }
}


- (TLServerRequest*)dequeue {
    TLServerRequest* request = nil;
    
    @synchronized(self.queue) {
        if( self.queue.count ) {
            request = [self.queue objectAtIndex:0];
            [self.queue removeObjectAtIndex:0];
        }
    }
    
    return request;
}

- (TLServerRequest*)peek {
    TLServerRequest* request = nil;

    @synchronized(self.queue) {
        if( self.queue.count ) {
            request = [self.queue objectAtIndex:0];
        }
    }

    return request;
}

- (NSInteger)size {
    return self.queue.count;
}

- (void)process {
    TLServerRequest* request = [self peek];
    if( request ) {
        
    }
}

@end
