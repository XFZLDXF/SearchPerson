//
//  Config.h
//  SearchPerson4
//
//  Created by DolBy on 13-5-6.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchPersonMainViewController;

@interface Config : NSObject


@property(nonatomic) BOOL isNetWorking;
+(Config *)instance;
@end
