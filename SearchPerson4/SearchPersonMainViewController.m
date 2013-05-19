//
//  SearchPersonMainViewController.m
//  SearchPerson4
//
//  Created by DolBy on 13-5-4.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import "SearchPersonMainViewController.h"
#import "Reachability.h"
#import "Config.h"
#import "AFSPClient.h"


@interface SearchPersonMainViewController ()
@property(nonatomic,strong) NSArray *imgArray;

@end

@implementation SearchPersonMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = BG_COLOR;
    
//    网络检测
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    reach.reachableBlock = ^(Reachability *reachability){
        dispatch_async(dispatch_get_main_queue(), ^{
            debugLog(@"网络联通，正在加载数据，解析最新数据");
            [Config instance].isNetWorking = YES;
    [MBHUDView hudWithBody:@"呵呵 网络已通" type:MBAlertViewHUDTypeCheckmark hidesAfter:1.0 show:YES];
        });
    };
    reach.unreachableBlock = ^(Reachability *reachability){
        dispatch_async(dispatch_get_main_queue(), ^{
            debugLog(@"提示信息");
    [Config instance].isNetWorking = NO;
//  MBAlertView 提示动画
    [MBHUDView hudWithBody:@"哎呀 网络不给力!" type:MBAlertViewHUDTypeExclamationMark hidesAfter:1.0 show:YES];
        });
    };
    [reach startNotifier];
    
//    加载动画
    [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];

    _imgArray = [NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpeg",@"4.jpeg",@"5.jpeg",@"6.jpeg",@"7.jpeg",@"8.jpeg",@"9.jpeg", nil];
    [self AdImg:_imgArray];
    [self setCurrentPage:_page.currentPage];
}

#pragma mark - 5秒换图片
- (void) handleTimer: (NSTimer *) timer
{
    if (_TimeNum % 5 == 0 ) {
        
        if (!_Tend) {
            self.page.currentPage++;
            if (self.page.currentPage==self.page.numberOfPages-1) {
                _Tend=YES;
            }
        }else{
            self.page.currentPage--;
            if (_page.currentPage==0) {
                _Tend=NO;
            }
        }
        
        [UIView animateWithDuration:0.7 //速度0.7秒
                         animations:^{//修改坐标
                             _sv.contentOffset = CGPointMake(_page.currentPage*320,0);
                         }];
        
        
    }
    _TimeNum ++;
}

-(void)AdImg:(NSArray*)arr{
    [_sv setContentSize:CGSizeMake(320*[arr count], 189)];
    
    
    _page.numberOfPages = [arr count];
    
    for (int i=0; i<[arr count]; i++) {
        NSString *str = [arr objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 00, 320, 180)];
        [imgView setImage:[UIImage imageNamed:str]];
        [_sv addSubview:imgView];
        
    }
    
}

#pragma mark - scrollView && page
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.page.currentPage=scrollView.contentOffset.x/320;
    [self setCurrentPage:self.page.currentPage];
    
    
}
- (void) setCurrentPage:(NSInteger)secondPage {
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.page.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.page.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 24/2;
        size.width = 24/2;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
        if (subviewIndex == secondPage) [subview setImage:[UIImage imageNamed:@"a.png"]];
        else [subview setImage:[UIImage imageNamed:@"d.png"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
