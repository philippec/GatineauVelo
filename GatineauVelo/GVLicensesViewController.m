//
//  GVLicensesViewController.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVLicensesViewController.h"
#import "GVWebViewDelegate.h"

@implementation GVLicensesViewController

- (void)dealloc
    {
        self.webDelegate = nil;
        self.webView = nil;
    }
    
- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString* path = [[NSBundle mainBundle] pathForResource:@"licenses" ofType:@"html"];
    NSString* baseString = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
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
