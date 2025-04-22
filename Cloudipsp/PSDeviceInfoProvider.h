//
//  Header.h
//  
//
//  Created by Vladimeri Dolidze on 18.04.25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PSDeviceInfoProvider : NSObject

- (instancetype)init;
- (NSString *)getEncodedDeviceFingerprint;

@end

