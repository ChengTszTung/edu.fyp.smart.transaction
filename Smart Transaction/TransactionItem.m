//
//  TransactionItem.m
//  Smart Transaction
//
//  Created by TszTung Cheng on 9/12/13.
//  Copyright (c) 2013 1314-114102-02. All rights reserved.
//

#import "TransactionItem.h"

@implementation TransactionItem

-(id)initWithProductId:(NSInteger)productId quantity:(NSInteger)quantity productName:(NSString*)productName price:(float)price
{
    self = [super init];
    if(self)
    {
        _productId = productId;
        _quantity = quantity;
        _productName = productName;
        _price = round(10 * price) / 10.0f;
    }
    return self;
}
@end
