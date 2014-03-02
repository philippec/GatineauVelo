//
//  GVAboutViewController.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVAboutViewController.h"

@interface GVAboutViewController ()

@end

@implementation GVAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString* path = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
    NSString* baseString = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString: baseString];
    NSMutableString* str = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

    NSString* versionStr = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
    [str replaceOccurrencesOfString:@"{VersionNum}" withString:versionStr options:NSCaseInsensitiveSearch range:NSMakeRange(0, [str length])];

    [self.webView loadHTMLString:str baseURL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.webView setNeedsUpdateConstraints];
}

@end
