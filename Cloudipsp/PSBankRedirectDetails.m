//
//  PSBankRedirectDetails.m
//  
//
//  Created by Vladimeri Dolidze on 18.04.25.
//

#import <Foundation/Foundation.h>
#import "PSBankRedirectDetails.h"

@implementation PSBankRedirectDetails

- (instancetype)init {
    self = [super init];
    return self;
}

- (instancetype)initWithAction:(NSString *)action
                           url:(NSString *)url
                        target:(NSString *)target
                responseStatus:(NSString *)responseStatus {
    self = [super init];
    if (self) {
        _action = action;
        _url = url;
        _target = target;
        _responseStatus = responseStatus;
    }
    return self;
}

@end
