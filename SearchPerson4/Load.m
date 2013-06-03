//
//  Load.m
//  SearchPerson4
//
//  Created by DolBy on 13-5-26.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import "Load.h"
#import "SearchPersonMainViewController.h"
@implementation Load

-(id)initWithLoading:(SearchPersonMainViewController *)s
{
    self = [super init];
    if (self != nil) {
        [s addObserver:self forKeyPath:@"isLoading" options:NSKeyValueObservingOptionNew context:nil];
//        [s addObserver:self forKeyPath:@"isLoadOver" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(void )observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (keyPath == @"YES") {
        [MBHUDView hudWithBody:@"Loading..." type:MBAlertViewHUDTypeActivityIndicator hidesAfter:2.0 show:YES];
    }
    NSLog(@"change: %@",change);
}
@end
