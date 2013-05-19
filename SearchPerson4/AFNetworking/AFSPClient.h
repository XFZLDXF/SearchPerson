//
//  AFSPClient.h
//  SearchPerson4
//
//  Created by DolBy on 13-5-6.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import "AFHTTPClient.h"

@interface AFSPClient : AFHTTPClient
+(AFSPClient *)sharedInstance;
@end
