//
//  PSBank.m
//  
//
//  Created by Vladimeri Dolidze on 18.04.25.
//

#import <Foundation/Foundation.h>

#import "PSBank.h"

@implementation PSBank

- (instancetype)initWithBankId:(NSString *)bankId
               countryPriority:(NSInteger)countryPriority
                  userPriority:(NSInteger)userPriority
                   quickMethod:(BOOL)quickMethod
                   userPopular:(BOOL)userPopular
                          name:(NSString *)name
                       country:(NSString *)country
                     bankLogo:(NSString *)bankLogo
                        alias:(NSString *)alias {
    self = [super init];
    if (self) {
        _bankId = bankId;
        _countryPriority = countryPriority;
        _userPriority = userPriority;
        _quickMethod = quickMethod;
        _userPopular = userPopular;
        _name = name;
        _country = country;
        _bankLogo = bankLogo;
        _alias = alias;
    }
    return self;
}

@end
