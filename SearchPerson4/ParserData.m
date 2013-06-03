//
//  ParserData.m
//  SearchPerson4
//
//  Created by DolBy on 13-5-19.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import "ParserData.h"
#import "TBXML.h"
@implementation ParserData

+(NSMutableArray *)parserXmlData:(NSString *)response
{
    NSMutableArray *array = [NSMutableArray array];
    TBXML *xml = [[TBXML alloc] initWithXMLString:response];
    
    TBXMLElement *root = xml.rootXMLElement;
    if (root) {
        TBXMLElement *dataElement = [TBXML childElementNamed:@"data" parentElement:root];
        TBXMLElement *resNum = [TBXML childElementNamed:@"resNum" parentElement:dataElement];
        TBXMLElement *dispNum = [TBXML childElementNamed:@"dispNum" parentElement:dataElement];
        
        TBXMLElement *disp_dataElement = [TBXML childElementNamed:@"disp_data" parentElement:dataElement];
        if (disp_dataElement) {
            TBXMLElement * dataElement = [TBXML childElementNamed:@"data" parentElement:disp_dataElement];
            while (dataElement) {
                
                TBXMLElement *source = [TBXML childElementNamed:@"from" parentElement:dataElement];
                
                TBXMLElement *url = [TBXML childElementNamed:@"url" parentElement:dataElement];
                
                TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:dataElement];
                
                TBXMLElement *age = [TBXML childElementNamed:@"age" parentElement:dataElement];
                
                TBXMLElement *sex = [TBXML childElementNamed:@"sex" parentElement:dataElement];
                
                TBXMLElement *desc = [TBXML childElementNamed:@"desc" parentElement:dataElement];
                TBXMLElement *phone = [TBXML childElementNamed:@"phone" parentElement:dataElement];
                TBXMLElement *remarks = [TBXML childElementNamed:@"remarks" parentElement:dataElement];
                TBXMLElement *found = [TBXML childElementNamed:@"found" parentElement:dataElement];
                
                TBXMLElement *input_time = [TBXML childElementNamed:@"input_time" parentElement:dataElement];
                
                TBXMLElement *weibotext = [TBXML childElementNamed:@"weibotext" parentElement:dataElement];
                TBXMLElement *update_time = [TBXML childElementNamed:@"_update_time" parentElement:dataElement];
                TBXMLElement *lastmod = [TBXML childElementNamed:@"lastmod" parentElement:dataElement];
                
                NSLog(@"========%@",[TBXML textForElement:phone]);
                NSDictionary *dic = @{@"resNum ": [TBXML textForElement:resNum],
                @"disp": [TBXML textForElement:dispNum],
                @"source" : [TBXML textForElement:source],
                @"url": [TBXML textForElement:url],
                @"name": [TBXML textForElement:name],
                @"age": [TBXML textForElement:age],
                @"sex": [TBXML textForElement:sex],
                @"desc": [TBXML textForElement:desc],
                @"<phone": [TBXML textForElement:phone],
                @"remarks": [TBXML textForElement:remarks],
                @"found": [TBXML textForElement:found] ,
                @"input_time": [TBXML textForElement:input_time] ,
                @"weibotext": [TBXML textForElement:weibotext],
                @"lastmod": [TBXML textForElement:lastmod],
                @"update_time": [TBXML textForElement:update_time]};
                
                dataElement = [TBXML nextSiblingNamed:@"data" searchFromElement:dataElement];
                [array addObject:dic];
            }

        }
    }
    return array;
}

@end
