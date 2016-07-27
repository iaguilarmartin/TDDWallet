//
//  WalletTableViewController.m
//  TDDWallet
//
//  Created by Ivan Aguilar Martin on 21/7/16.
//  Copyright © 2016 Ivan Aguilar Martin. All rights reserved.
//

#import "WalletTableViewController.h"
#import "Broker.h"
#import "Money.h"

@interface WalletTableViewController ()
@property (nonatomic, strong) Wallet *model;
@property (nonatomic, strong) Broker *broker;
@property (nonatomic, strong) NSString *totalCurrency;
@end

@implementation WalletTableViewController

-(id) initWithModel: (Wallet*) model {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
        
        self.totalCurrency = @"EUR";
        self.broker = [Broker new];
        [self.broker addRate: 2 fromCurrency: @"EUR" toCurrency: @"USD"];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TDDWallet";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.currenciesCount + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.model.currenciesCount > section) {
        NSString * currency = [self.model getCurrencyAtIndex:section];
        return [self.model countOfMoneisForCurrency:currency] + 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellIdentifier = @"MoneyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    NSString * cellText;
    
    if (self.model.currenciesCount > indexPath.section) {
        NSString * currency = [self.model getCurrencyAtIndex:indexPath.section];
        if ([self.model countOfMoneisForCurrency:currency] > indexPath.row) {
            Money *money = [self.model getMoneyForCurrency:currency atIndex:indexPath.row];
            cellText = [NSString stringWithFormat:@"%@", money.amount];
        } else {
            Money *total = [self.model getTotalMoneyForCurrency:currency];
            cellText = [NSString stringWithFormat: @"Total: %@ %@", currency, total.amount];
        }
    } else {
        Money *totalMoney = [self.broker reduce:self.model toCurrency:self.totalCurrency];
        cellText = [NSString stringWithFormat:@"%@ %@", self.totalCurrency, totalMoney.amount];
    }
    
    cell.textLabel.text = cellText;
    
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.model.currenciesCount > section) {
        NSString * currency = [self.model getCurrencyAtIndex:section];
        return currency;
    } else {
        return [NSString stringWithFormat: @"Total en %@", self.totalCurrency];
    }
}

@end
