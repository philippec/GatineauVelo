//
//  GVWebViewDelegate.m
//  GatineauVelo
//
//  Created by Philippe on 17-04-03.
//  Copyright © 2017 Philippe Casgrain. All rights reserved.
//

#import "GVWebViewDelegate.h"

@implementation GVWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        [UIApplication.sharedApplication openURL:request.URL];
        return false;
    }
    
    return true;
}

@end
