//
//  Config.m
//  SearchPerson4
//
//  Created by DolBy on 13-5-6.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import "Config.h"
#import "SearchPersonMainViewController.h"

@implementation Config

 static Config *instance = nil;
+(Config *)instance
{
    @synchronized(self){
        if (nil == instance) {
            instance = [[Config alloc] init];
        }
    }
    return instance;
}
@end
