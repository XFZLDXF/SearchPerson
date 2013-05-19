//
//  AdviceViewController.m
//  SearchPerson4
//
//  Created by DolBy on 13-5-5.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import "AdviceViewController.h"

@interface AdviceViewController ()

@end

@implementation AdviceViewController

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
    self.navigationController.navigationBar.tintColor = BG_COLOR;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)achieved:(id)sender {
}
@end
