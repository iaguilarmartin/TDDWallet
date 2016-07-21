//
//  WalletTableViewController.h
//  TDDWallet
//
//  Created by Ivan Aguilar Martin on 21/7/16.
//  Copyright © 2016 Ivan Aguilar Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wallet.h"

@interface WalletTableViewController : UITableViewController

-(id) initWithModel: (Wallet*) model;

@end
