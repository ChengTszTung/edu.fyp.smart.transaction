//
//  InvoicePDFBuilder.h
//  InvoicePDF
//
//  Created by Lau Ming Hei on 23/11/13.
//  Copyright (c) 2013 Lau Ming Hei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transaction.h"

@interface InvoicePDFBuilder : NSObject

//@property (nonatomic) NSArray* purchase;
//@property (nonatomic) NSDictionary* invoiceData;
@property (nonatomic,strong) Transaction* transaction;
-(void)buildInvoicePDF:(NSString*)filePath PDFPageSize:(CGSize)pageSize;

@end
