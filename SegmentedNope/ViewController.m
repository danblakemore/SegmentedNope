//
//  ViewController.m
//  SegmentedNope
//
//  Created by Daniel Blakemore on 10/14/14.
//  Copyright (c) 2014 Pixio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UISegmentedControl * _control;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    _control = [[UISegmentedControl alloc] initWithItems:@[@"Thing 1", @"Thing 2"]];
    [_control setSelectedSegmentIndex:0];
    [_control setTintColor:[UIColor blackColor]];
    [_control setFrame:CGRectMake(100, 100, 300, 50)];
    [_control addTarget:self action:@selector(controlPressed:) forControlEvents:UIControlEventValueChanged];
    [[self view] addSubview:_control];
}

- (void)viewDidAppear:(BOOL)animated
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self nope];
    });
}

- (void)nope
{
    static NSInteger foo = 1;
    foo = (foo + 1) % 2;
    NSLog(@"value about to be changed to %ld", foo);
    
    // setting this programmatically only slightly more than the goggles. (Hint: the goggles do nothing).
    [_control setSelectedSegmentIndex:foo];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self nope];
    });
}

- (void)controlPressed:(UISegmentedControl*)sender
{
    // not called when the value of the sender changes even though this 
    // action was added to the segmented control for the target self and 
    // the event UIControlEventValueChanged
    //
    // TL;DR it not work good
    NSLog(@"value changed: %ld", [sender selectedSegmentIndex]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
