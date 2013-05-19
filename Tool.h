//
//  Tool.h
//  SearchPerson4
//
//  Created by DolBy on 13-5-6.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "PersonInfo.h"
@interface Tool : NSObject

+(PersonInfo *)getSPDetailInfo:(NSString *)response;
@end
