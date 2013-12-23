//
//  Transaction.m
//  Smart Transaction
//
//  Created by TszTung Cheng on 9/12/13.
//  Copyright (c) 2013 1314-114102-02. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction

-(TransactionItem*) getTransactionItemAtIndex:(NSInteger)index
{
    return [_transactionItems objectAtIndex:index];
}

-(id)initWithTranId:(NSInteger)tranId dateTime:(NSDate*)dateTime transactionItems:(NSArray*)transactionItems
{
    self = [super init];
    if(self)
    {
        _tranId = tranId;
        _dateTime = dateTime;
        _transactionItems = [[NSMutableArray alloc]init];
        _amount = 0;
        
        for (int i = 0 ; i < transactionItems.count; i ++)
        {
            TransactionItem* tranItem = [[TransactionItem alloc]initWithProductId:[[transactionItems[i] valueForKey:@"productId"] integerValue]
                                                                         quantity:[[transactionItems[i] valueForKey:@"quantity"] integerValue]
                                                                      productName:[transactionItems[i] valueForKey:@"productName"]
                                                                            price:[[transactionItems[i] valueForKey:@"price"] floatValue]];
            
            _amount += [tranItem quantity] * [tranItem price];
            [_transactionItems addObject:tranItem];
        }
        _transactionItemsCount = [_transactionItems count];
        
        
    }
    return self;
}
@end
