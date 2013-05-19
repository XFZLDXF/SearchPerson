//
//  PersonInfo.h
//  SearchPerson4
//
//  Created by DolBy on 13-5-6.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfo : NSObject

//显示多少条信息
@property(nonatomic) int resNum;
//总共条数
@property(nonatomic) int dispNum;
@property(nonatomic,copy) NSString *source;
@property(nonatomic,strong) NSURL *url;
@property(nonatomic,copy) NSString *name;
@property(nonatomic) int age;
@property(nonatomic,copy) NSString *sex;
@property(nonatomic,copy) NSString *desc;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *remarks;
@property(nonatomic) int found;  //是否已找到 1表示已近找到；0表示尚未找到
@property(nonatomic) int input_time;
@property(nonatomic,copy) NSString *weibotext;
//最后修改时间
@property(nonatomic,copy) NSString *lastmod;
@property(nonatomic) int  update_time;

-(id)initWithParameters_Source:(NSString *)source
                        andUrl:(NSURL *)url
                       andName:(NSString *)name
                        andAge:(int) age
                        andSex:(NSString *)sex
                        andDes:(NSString *)des
                      andPhone:(NSString *)phone
                    andRemarks:(NSString *)remarks
                      andFound:(int)found
                 andInput_time:(int)input_time
                  andWeiboText:(NSString *)weibotext
                    andLastmod:(NSString *)lastmod
                andUpdate_time:(int)update_time;
@end
