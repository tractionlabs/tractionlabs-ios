//
//  TLRequestQueue.m
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 6/30/15.
//
//

#import "TLRequestQueue.h"
#import "TLRequest.h"
#import "TLError.h"

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

- (void)enqueue:(TLRequest*)request {
    @synchronized(self.queue) {
        if( request ) {
            [self.queue addObject:request];
        }
    }
}


- (TLRequest*)dequeue {
    TLRequest* request = nil;
    
    @synchronized(self.queue) {
        if( self.queue.count ) {
            request = [self.queue objectAtIndex:0];
            [self.queue removeObjectAtIndex:0];
        }
    }
    
    return request;
}

- (TLRequest*)peek {
    TLRequest* request = nil;

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
    TLRequest* request = [self peek];
    if( request ) {

        __weak typeof(self) weakSelf = self;
        TLRequestCompletion completion = ^(id responseObject, NSError* error) {
            if( error ) {
                if( [TLErrorDomain isEqualToString:error.domain] ) {
                    id responseError = error.userInfo[TRACTIONLABS_RESPONSE_ERROR_KEY];
                    NSString* message = responseError?responseError[TRACTIONLABS_RESPONSE_ERROR_MESSAGE_KEY]:nil;
                    if( message ) {
                        NSLog(@"[TractionLabs Error] %@(%li) : %@", TLErrorCode_toString[error.code], (long)error.code, message );
                    } else {
                        NSLog(@"[TractionLabs Error] %@(%li)", TLErrorCode_toString[error.code], (long)error.code );
                    }
                }
                return;
            }
            
            [weakSelf dequeue];
            [weakSelf process];
        };
        
        [request sendWithCompletion:completion];
    }
}

@end
