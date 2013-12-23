//
//  InvoiceDetailViewController.h
//  Smart Transaction
//
//  Created by TszTung Cheng on 18/12/13.
//  Copyright (c) 2013 1314-114102-02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
#import "TransactionItem.h"

@interface InvoiceDetailViewController : UIViewController
@property (nonatomic) Transaction* transaction;
@end
