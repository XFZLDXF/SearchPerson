//
//  SearchViewController.h
//  SearchPerson4
//
//  Created by DolBy on 13-5-4.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML.h"
@interface SearchViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *results;
    BOOL isLoading;
    BOOL isLoadOver;
    
    int allCount;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableResult;

-(void)doSearch;
-(void)clear;
@end
