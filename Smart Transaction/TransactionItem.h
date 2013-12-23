//
//  TransactionItem.h
//  Smart Transaction
//
//  Created by TszTung Cheng on 9/12/13.
//  Copyright (c) 2013 1314-114102-02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionItem : NSObject
@property (nonatomic) NSInteger productId;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) NSString* productName;
@property (nonatomic) float price;

-(id)initWithProductId:(NSInteger)productId quantity:(NSInteger)quantity productName:(NSString*)productName price:(float)price;
@end
