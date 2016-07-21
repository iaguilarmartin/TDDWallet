//
//  ViewController.m
//  TDDWallet
//
//  Created by Ivan Aguilar Martin on 19/7/16.
//  Copyright © 2016 Ivan Aguilar Martin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)displayText:(id)sender {
    
    UIButton *btn = sender;
    self.displayLabel.text = btn.titleLabel.text;
}
@end
