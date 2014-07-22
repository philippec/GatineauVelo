//
//  GVFlipsideViewController.m
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVFlipsideViewController.h"

@interface GVFlipsideViewController ()

@property (strong) UINavigationController *navigationController;

@end

@implementation GVFlipsideViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *childVCs = [self childViewControllers];

    if ([childVCs.firstObject isKindOfClass:[UINavigationController class]])
    {
        self.navigationController = childVCs.firstObject;
        self.navigationController.delegate = self;
    }

    // Back button starts disabled
    self.backButton.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.backButton.enabled = navigationController.viewControllers.count > 1;
}

@end
