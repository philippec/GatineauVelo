//
//  GVLicensesViewController.h
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GVWebViewDelegate;

@interface GVLicensesViewController : UIViewController

@property (strong) GVWebViewDelegate *webDelegate;
@property (strong) IBOutlet UIWebView *webView;

@end
