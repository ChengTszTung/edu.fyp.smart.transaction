//
//  InvoicePDF.h
//  InvoicePDF
//
//  Created by Lau Ming Hei on 23/11/13.
//  Copyright (c) 2013 Lau Ming Hei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transaction.h"

@interface InvoicePDF : NSObject

+(void)generateInvoicePDF:(NSString*)fileName withTransaction:(Transaction*)transaction;

@end
