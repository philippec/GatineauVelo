//
//  GVOpenDataLicenseViewController.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVOpenDataLicenseViewController.h"

@interface GVOpenDataLicenseViewController ()

@end

@implementation GVOpenDataLicenseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString* path = [[NSBundle mainBundle] pathForResource:@"open_data_license" ofType:@"html"];
    NSString* baseString = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString: baseString];
    NSString* str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

    [self.webView loadHTMLString:str baseURL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
