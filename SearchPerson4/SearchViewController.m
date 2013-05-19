//
//  SearchViewController.m
//  SearchPerson4
//
//  Created by DolBy on 13-5-4.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import "SearchViewController.h"
#import "PersonInfo.h"
#import "AFSPClient.h"
#import "Config.h"
#import "TBXML.h"

#define BAIDU_SEARCHPERSON_SEARCH_API @"http://opendata.baidu.com/api.php?resource_id=6109&format=xml&ie=utf-8&oe=utf-8&query="
@interface SearchViewController ()
@property(nonatomic,strong)  NSMutableArray *array;
@end

@implementation SearchViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.searchBar.tintColor = BG_COLOR;
    [self.searchBar becomeFirstResponder];
    self.searchBar.showsCancelButton=YES;


}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton=YES;
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    debugMethod();
    [self.searchBar resignFirstResponder];
    self.searchBar.showsCancelButton=NO;

}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
   
    debugMethod();
    if (self.searchBar.text.length == 0) {
        [MBHUDView hudWithBody:@"输入为空噢!" type:MBAlertViewHUDTypeActivityIndicator hidesAfter:0.75 show:YES];
        return;
    }
    [self.searchBar resignFirstResponder];
    self.searchBar.showsCancelButton=NO;
    [self clear];
    [self doSearch];
    for (int i = 0;i< [self.array count];i++) {
        debugLog(@"/////////////////////");
        
        debugLog(@"AGE = %@",[self.array objectAtIndex:i]);
    }
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//http://opendata.baidu.com/api.php?resource_id=6109&format=xml&ie=utf-8&oe=utf-8&query=%E6%9D%8E%E7%BA%A2&from_mid=1&rn=20&pn=0


-(void)doSearch
{
//   http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx/getRegionProvince
    isLoading = YES;
    if ([Config instance].isNetWorking) {
        debugLog(@"网络 %d",[Config instance].isNetWorking);
        int pageIndex = allCount/20;
        _array = [[NSMutableArray alloc] initWithCapacity:0];
        NSString *url = [NSString stringWithFormat:@"%@%@&from_mid=1&rn=%d&pn=%d",BAIDU_SEARCHPERSON_SEARCH_API,[self encodeToPercentEscapeString:self.searchBar.text],20,pageIndex];
        
        [[AFSPClient sharedInstance] postPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            debugLog(@"加载成功");
           
            isLoading = NO;
            allCount +=20;
            NSString *response = operation.responseString;
            debugLog(@"加载成功111111111");
            @try {
//                PersonInfo *p = [[PersonInfo alloc] init];
                
                TBXML *xml = [[TBXML alloc] initWithXMLString:response];
//                debugLog(@"response = %@",response);
                TBXMLElement *root = xml.rootXMLElement;
                if (root) {
                    TBXMLElement *dataElement = [TBXML childElementNamed:@"data" parentElement:root];
                    TBXMLElement *resNum = [TBXML childElementNamed:@"resNum" parentElement:dataElement];
                    TBXMLElement *dispNum = [TBXML childElementNamed:@"dispNum" parentElement:dataElement];
                    NSLog(@"------------%d  %d",[[TBXML textForElement:resNum] intValue],[[TBXML textForElement:dispNum] intValue]);
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
                             NSLog(@"---===%@",[TBXML textForElement:input_time]);
                            TBXMLElement *weibotext = [TBXML childElementNamed:@"weibotext" parentElement:dataElement];
//                            NSString *string = [[NSString alloc] initWithString:[TBXML textForElement:weibotext]];
//                            NSLog(@"name = %@",string);

                            TBXMLElement *update_time = [TBXML childElementNamed:@"_update_time" parentElement:dataElement];
                            TBXMLElement *lastmod = [TBXML childElementNamed:@"lastmod" parentElement:dataElement];
                            /*
                            PersonInfo *p = [[PersonInfo alloc] initWithParameters_Source:[TBXML textForElement:source]
                                                                                   andUrl:[NSURL URLWithString:[TBXML textForElement:url]]
                                                                                  andName:[TBXML textForElement:name]
                                                                                   andAge:[[TBXML textForElement:age] intValue]
                                                                                   andSex:[TBXML textForElement:sex]
                                                                                   andDes:[TBXML textForElement:desc]
                                                                                 andPhone:[TBXML textForElement:phone]
                                                                               andRemarks:[TBXML textForElement:remarks]
                                                                                 andFound:[[TBXML textForElement:found] intValue]
                                                                            andInput_time:[[TBXML textForElement:input_time] intValue]
                                                                             andWeiboText:[TBXML textForElement:weibotext]
                                                                               andLastmod:[TBXML textForElement:lastmod]
                                                                           andUpdate_time:[[TBXML textForElement:update_time] intValue]];
                            */
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
                            /*
                            
//                            p.source = [TBXML textForElement:sourceElement];
                            p.source = [TBXML textForElement:source];
                            p.url = [NSURL URLWithString:[TBXML textForElement:url]];
                            p.age = [[TBXML textForElement:age] intValue];
                            p.des = [TBXML textForElement:desc];
                             */
                            
//                            debugLog(@"=======%@",self.array);
//                            debugLog(@"url = %@",p.source);
//                            p = nil;
                            dataElement = [TBXML nextSiblingNamed:@"data" searchFromElement:dataElement];
                            [_array addObject:dic];
                            
                        }
                    }
                }
                debugLog(@"NSArray = %@",self.array);
      
            }
            @catch (NSException *exception) {
                debugLog(@"catch %@",exception.description);
            }
            @finally {
                debugLog(@"finally");
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            debugLog(@"加载出错,请检查网络");
        }];
        
        debugLog(@"array = %@",self.array);
    }
    [self.tableResult reloadData];

}

-(void)clear
{

}

//UTF8  转码
-(NSString *)encodeToPercentEscapeString:(NSString *)input
{
    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)input, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    return outputStr;
}



#pragma mark -
#pragma mark UITableViewDelegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify =@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify];
    }
    PersonInfo *p = [[PersonInfo alloc] init];
     p =[self.array objectAtIndex:indexPath.row];
    cell.textLabel.text = p.weibotext;
    debugLog(@"text = %@",p.weibotext);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableResult deselectRowAtIndexPath:indexPath animated:YES];
   
}
@end
