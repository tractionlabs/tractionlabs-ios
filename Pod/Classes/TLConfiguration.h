//
//  TLConfiguration.h
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 6/30/15.
//
//

#import <Foundation/Foundation.h>

@interface TLConfiguration : NSObject

+ (instancetype)sharedInstance;

- (NSString*)getApplicationId;

@end
