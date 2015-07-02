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
+ (NSString *)getLanguage;
+ (NSInteger)getTimeZoneOffset;
+ (NSString*)getOS;
+ (NSString*)getOSVersion;
+ (NSInteger)getScreenWidth;
+ (NSInteger)getScreenHeight;
+ (NSInteger)getColorDepth;
+ (CGFloat)getScreenScale;
+ (NSString *)getVendorUUID;
+ (NSString *)getDeviceUUID;
+ (NSString *)getAppVersion;
+ (NSString *)getBundleID;
+ (NSString *)getCarrier;

@end
