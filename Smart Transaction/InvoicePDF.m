//
//  InvoicePDF.m
//  InvoicePDF
//
//  Created by Lau Ming Hei on 23/11/13.
//  Copyright (c) 2013 Lau Ming Hei. All rights reserved.
//

#import "InvoicePDF.h"
#import "InvoicePDFBuilder.h"

@implementation InvoicePDF

+(void)generateInvoicePDF:(NSString*)fileName withTransaction:(Transaction*)transaction
{
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:@"Invoice.PDF"];
    InvoicePDFBuilder* builder = [[InvoicePDFBuilder alloc]init];
    [builder setTransaction:transaction];
    
    [builder buildInvoicePDF:pdfFileName PDFPageSize:CGSizeMake(612, 792)];
}

@end
