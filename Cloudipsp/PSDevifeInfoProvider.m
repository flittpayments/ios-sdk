//
//  PSDevifeInfoProvider.m
//  
//
//  Created by Vladimeri Dolidze on 18.04.25.
//

#import "PSDeviceInfoProvider.h"
#import <UIKit/UIKit.h>

@implementation PSDeviceInfoProvider {
    NSString *_deviceId;
}

static NSString *const kPrefsKeyDeviceId = @"ps_device_id";

- (instancetype)init {
    self = [super init];
    if (self) {
        _deviceId = [self loadOrGenerateDeviceId];
    }
    return self;
}

// If you ever want to reintroduce context
- (instancetype)initWithContext:(UIViewController *)context {
    return [self init]; // context is no longer used, fall back to default init
}

- (NSString *)getEncodedDeviceFingerprint {
    @try {
        NSDictionary *fingerprint = [self createDeviceFingerprint];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:fingerprint options:0 error:nil];
        return [jsonData base64EncodedStringWithOptions:0];
    } @catch (NSException *exception) {
        NSDictionary *minimal = @{@"id": [[NSUUID UUID] UUIDString], @"data": @{}};
        NSData *fallbackData = [NSJSONSerialization dataWithJSONObject:minimal options:0 error:nil];
        return [fallbackData base64EncodedStringWithOptions:0];
    }
}

- (NSDictionary *)createDeviceFingerprint {
    NSMutableDictionary *root = [NSMutableDictionary dictionary];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];

    data[@"user_agent"] = [self getUserAgent];
    data[@"language"] = [self getDeviceLanguage];
    data[@"resolution"] = @[@([self getScreenWidth]), @([self getScreenHeight])];
    data[@"timezone_offset"] = @([self getTimezoneOffset]);
    data[@"platform_name"] = @"ios_sdk";
    data[@"platform_version"] = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] ?: @"1.0.0";
    data[@"platform_os"] = @"ios";
    data[@"platform_product"] = [[UIDevice currentDevice] systemVersion];
    data[@"platform_type"] = [self getDeviceType];

    root[@"id"] = _deviceId ?: @"unknown_device_id";
    root[@"data"] = data;

    return root;
}

- (NSString *)loadOrGenerateDeviceId {
    NSString *deviceId = [[NSUserDefaults standardUserDefaults] stringForKey:kPrefsKeyDeviceId];
    if (!deviceId || [deviceId isEqualToString:@""]) {
        deviceId = [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [[NSUserDefaults standardUserDefaults] setObject:deviceId forKey:kPrefsKeyDeviceId];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return deviceId;
}

- (NSString *)getUserAgent {
    return [NSString stringWithFormat:@"ios/%@", [[UIDevice currentDevice] systemVersion]];
}

- (NSString *)getDeviceLanguage {
    return [[NSLocale preferredLanguages] firstObject] ?: @"en";
}

- (NSInteger)getScreenWidth {
    return (NSInteger)[UIScreen mainScreen].bounds.size.width;
}

- (NSInteger)getScreenHeight {
    return (NSInteger)[UIScreen mainScreen].bounds.size.height;
}

- (NSInteger)getTimezoneOffset {
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    return [timeZone secondsFromGMT] / 60 * -1;
}

- (NSString *)getDeviceType {
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPad:
            return @"tablet";
        case UIUserInterfaceIdiomPhone:
        default:
            return @"mobile";
    }
}

@end
