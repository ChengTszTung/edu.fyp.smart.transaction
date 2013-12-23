//
//  Transaction.h
//  Smart Transaction
//
//  Created by TszTung Cheng on 9/12/13.
//  Copyright (c) 2013 1314-114102-02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionItem.h"

@interface Transaction : NSObject

@property (nonatomic) NSInteger tranId;
@property (nonatomic) NSDate* dateTime;
@property (nonatomic) NSMutableArray* transactionItems;
@property (nonatomic) NSInteger transactionItemsCount;
@property (nonatomic) float amount;

-(id)initWithTranId:(NSInteger)tranId dateTime:(NSDate*)dateTime transactionItems:(NSArray*)transactionItems;
-(TransactionItem*) getTransactionItemAtIndex:(NSInteger)index;
@end
