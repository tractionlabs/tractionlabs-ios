//
//  NSMutableDictionary+TractionLabs.m
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 7/1/15.
//
//

#import "NSMutableDictionary+TractionLabs.h"

@implementation NSMutableDictionary (TractionLabs)

- (void)safeSetObject:(id)object forKey:(id<NSCopying>)key {
    if( object ) {
        [self setObject:object forKey:key];
    }
}

@end
