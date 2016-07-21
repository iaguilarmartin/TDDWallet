//
//  ControllerTests.m
//  TDDWallet
//
//  Created by Ivan Aguilar Martin on 21/7/16.
//  Copyright © 2016 Ivan Aguilar Martin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "WalletTableViewController.h"
#import "Wallet.h"

@interface ControllerTests : XCTestCase
@property (nonatomic, strong) ViewController *simpleVC;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) WalletTableViewController *walletVC;
@property (nonatomic, strong) Wallet * wallet;
@end

@implementation ControllerTests

- (void)setUp {
    [super setUp];
    
    // Creamos el entorno de laboratorio
    self.simpleVC = [[ViewController alloc] initWithNibName:nil bundle:nil];
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setTitle:@"Hola" forState:UIControlStateNormal];
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.simpleVC.displayLabel = self.label;
    
    self.wallet = [[Wallet alloc] initWithAmount:1 currency:@"USD"];
    [self.wallet plus:[Money euroWithAmount:1]];
    self.walletVC = [[WalletTableViewController alloc] initWithModel: self.wallet];
}

- (void)tearDown {
    [super tearDown];
    
    self.simpleVC = nil;
    self.button = nil;
    self.label = nil;
    
    self.walletVC = nil;
    self.wallet = nil;
}

- (void)testThatTextOnlabelIsEqualToTextOnButton {
    
    // mandamos el mensaje
    [self.simpleVC displayText: self.button];
    
    // comprobamos que etiqueta y boton tienen el mismo text
    XCTAssertEqualObjects(self.button.titleLabel.text, self.label.text, @"Button and label should have the same text");
}

-(void) testThatTableHasOneSection {
    NSInteger sections = [self.walletVC numberOfSectionsInTableView: nil];
    XCTAssertEqual(sections, 1, @"There can be only one");
}

-(void) testThatNumberOfCellsIsNumberOfMoneysPlusOne {
    XCTAssertEqual(self.wallet.count + 1, [self.walletVC tableView:nil numberOfRowsInSection:0], @"Number of cells is the number of moneys plus 1");
}

@end
