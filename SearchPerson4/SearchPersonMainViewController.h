//
//  SearchPersonMainViewController.h
//  SearchPerson4
//
//  Created by DolBy on 13-5-4.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchPersonMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *sv;

@property (weak, nonatomic) IBOutlet UIPageControl *page;
@property(nonatomic) int TimeNum;
@property(nonatomic) BOOL Tend;
@property(strong,nonatomic) NSArray *arry;
@end
