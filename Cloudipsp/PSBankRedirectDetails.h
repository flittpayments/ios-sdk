//
//  Header.h
//  
//
//  Created by Vladimeri Dolidze on 18.04.25.
//

#import <Foundation/Foundation.h>

@interface PSBankRedirectDetails : NSObject

@property (nonatomic, strong) NSString *action;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *target;
@property (nonatomic, strong) NSString *responseStatus;

- (instancetype)init;
- (instancetype)initWithAction:(NSString *)action
                           url:(NSString *)url
                        target:(NSString *)target
                responseStatus:(NSString *)responseStatus;

@end

