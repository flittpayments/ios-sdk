//
//  Header.h
//  
//
//  Created by Vladimeri Dolidze on 18.04.25.
//


#import <Foundation/Foundation.h>

@interface PSBank : NSObject

@property (nonatomic, strong) NSString *bankId;
@property (nonatomic, assign) NSInteger countryPriority;
@property (nonatomic, assign) NSInteger userPriority;
@property (nonatomic, assign) BOOL quickMethod;
@property (nonatomic, assign) BOOL userPopular;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *bankLogo;
@property (nonatomic, strong) NSString *alias;

- (instancetype)initWithBankId:(NSString *)bankId
               countryPriority:(NSInteger)countryPriority
                  userPriority:(NSInteger)userPriority
                   quickMethod:(BOOL)quickMethod
                   userPopular:(BOOL)userPopular
                          name:(NSString *)name
                       country:(NSString *)country
                     bankLogo:(NSString *)bankLogo
                        alias:(NSString *)alias;

@end
