//
//  AFSPClient.m
//  SearchPerson4
//
//  Created by DolBy on 13-5-6.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import "AFSPClient.h"
#define kBAIDU_SP_API @"http://opendata.baidu.com/api"

@implementation AFSPClient

static  AFSPClient *shareInstance = nil;

+(AFSPClient *)sharedInstance
{
    
   
//    @synchronized(self){
//        if (nil == shareInstance) {
//            shareInstance = [[AFSPClient alloc] init];
//        }
//    }
    
  
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[AFSPClient alloc] initWithBaseURL:[NSURL URLWithString:kBAIDU_SP_API]];
    });
    
    return shareInstance;
    
}

- (id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    return self;
}
@end
