//
//  GVOpenDataLicenseViewController.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVOpenDataLicenseViewController.h"
#import "GVWebViewDelegate.h"

@implementation GVOpenDataLicenseViewController

- (void)dealloc
{
    self.webDelegate = nil;
    self.webView = nil;
}
    
- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString* path = [[NSBundle mainBundle] pathForResource:@"open_data_license" ofType:@"html"];
    NSString* baseString = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString: baseString];
    NSString* str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

    [self.webView loadHTMLString:str baseURL:url];

    self.webDelegate = [[GVWebViewDelegate alloc] init];
    self.webView.delegate = self.webDelegate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
