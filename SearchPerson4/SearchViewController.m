//
//  SearchViewController.m
//  SearchPerson4
//
//  Created by DolBy on 13-5-4.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import "SearchViewController.h"
#import "DataCell.h"
#import "AFSPClient.h"
#import "Config.h"
#import "TBXML.h"
#import "ParserData.h"
#import "Tool.h"
#import "Load.h"


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
    allCount = 0;
    results = [[NSMutableArray alloc] initWithCapacity:20];
    self.tableResult.separatorColor = BG_COLOR;
    self.tableResult.hidden = YES;


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
      
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)doSearch
{
    
    isLoading = YES;
    if ([Config instance].isNetWorking) {
        debugLog(@"网络 %d",[Config instance].isNetWorking);
        int pageIndex = allCount/20;
        self.array = [[NSMutableArray alloc] initWithCapacity:0];
        NSString *url = [NSString stringWithFormat:@"%@%@&from_mid=1&rn=%d&pn=%d",BAIDU_SEARCHPERSON_SEARCH_API,[self encodeToPercentEscapeString:self.searchBar.text],20,pageIndex];
          __weak Load *load = [[Load alloc] initWithLoading:self];
        [[AFSPClient sharedInstance] postPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            debugLog(@"加载成功");
            self.tableResult.hidden = NO;
            isLoading = NO;
            allCount +=20;
            NSString *response = operation.responseString;
            @try {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                   数据处理区
                      results = [ParserData parserXmlData:response];
                    if (results) {
                        isLoadOver = YES;
//                        debugLog(@"results = %@",[[results objectAtIndex:3] objectForKey:@"name"]);
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                      
//                  主线程  界面处理区域
                       [self.tableResult reloadData];
                    });
                });
               
                
//                debugLog(@"results = %@",results);
      
            }
            @catch (NSException *exception) {
                [Tool TakeException:exception];
                debugLog(@"catch 异常%@",exception.description);
            }
            @finally {
                debugLog(@"finally");
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            debugLog(@"加载出错,请检查网络");
        }];
        
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




#pragma mark UITableViewDelegate Methods
#pragma mark - Refresh and load more methods

- (void) refreshTable
{
    /*
     
     Code to actually refresh goes here.  刷新代码放在这
     
     */
    self.tableResult.pullLastRefreshDate = [NSDate date];
    self.tableResult.pullTableIsRefreshing = NO;
}

- (void) loadMoreDataToTable
{
    /*
     
     Code to actually load more data goes here.  加载更多实现代码放在在这
     
     */
    self.tableResult.pullTableIsLoadingMore = NO;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isLoadOver) {
        return results.count == 0 ? 1 : results.count;
    }
    
    else
        return [results count] +1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dicData = [NSDictionary dictionary];
    
    static NSString *CellIdentify =@"Cell";
    self.tableResult = tableView;
    //    DataCell *cell = [self.tableResult dequeueReusableCellWithIdentifier:CellIdentify];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil) {
        //        cell = [[DataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify];
    }
    
    debugLog(@"lkfjsffns  %d",[results count]);
    
    if ([results count] > 0) {
        NSLog(@"----%@",[[results objectAtIndex:indexPath.row] valueForKey:@"name"]);
        cell.textLabel.text =[[results objectAtIndex:indexPath.row] valueForKey:@"name"] ;
    }
    //    NSLog(@"----%@",[results objectAtIndex:indexPath.row]);
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLoading) {
        return results.count == 0 ? 62 : 50;
    }
    return indexPath.row < results.count ? 62:50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableResult deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
}
@end
