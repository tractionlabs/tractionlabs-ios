//
//  NSMutableDictionary+TractionLabs.h
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 7/1/15.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (TractionLabs)

- (void)safeSetObject:(id)object forKey:(id<NSCopying>)key;

@end
