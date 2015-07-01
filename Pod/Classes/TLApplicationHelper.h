//
//  TLApplicationHelper.h
//  Pods
//
//  Created by Tobin Schwaiger-Hastanan on 7/1/15.
//
//

#import <Foundation/Foundation.h>

@interface TLApplicationHelper : NSObject

+ (NSString *)getDeviceArchitecture;
+ (NSString *)getDeviceModel;
+ (NSString *)getDeviceName;
+ (NSString*)getOS;
+ (NSString*)getOSVersion;
+ (NSInteger)getScreenWidth;
+ (NSInteger)getScreenHeight;
+ (CGFloat)getScreenScale;
+ (NSString *)getVendorUUID;
+ (NSString *)getDeviceUUID;
+ (NSString *)getAppVersion;
+ (NSString *)getBundleID;
+ (NSString *)getCarrier;

@end
