//
//  PersonInfo.m
//  SearchPerson4
//
//  Created by DolBy on 13-5-6.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import "PersonInfo.h"

@implementation PersonInfo


-(id)initWithParameters_Source:(NSString *)source
                        andUrl:(NSURL *)url
                       andName:(NSString *)name
                        andAge:(int)age andSex:(NSString *)sex
                        andDes:(NSString *)des andPhone:(NSString *)phone
                    andRemarks:(NSString *)remarks andFound:(int)found
                 andInput_time:(int)input_time
                  andWeiboText:(NSString *)weibotext
                    andLastmod:(NSString *)lastmod
                andUpdate_time:(int)update_time
{
    PersonInfo *person = [[PersonInfo alloc] init];
    person.source = source;
    person.url = url;
    person.name = name;
    person.age =age;
    person.sex = sex;
    person.desc =des;
    person.phone = phone;
    person.remarks = remarks;
    person.found = found;
    person.input_time = input_time;
    person.weibotext = weibotext;
    person.lastmod = lastmod;
    person.update_time = update_time;
    
    return person;

}
@end
