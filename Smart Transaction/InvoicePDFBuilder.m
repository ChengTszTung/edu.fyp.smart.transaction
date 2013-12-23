//
//  InvoicePDFBuilder.m
//  InvoicePDF
//
//  Created by Lau Ming Hei on 23/11/13.
//  Copyright (c) 2013 Lau Ming Hei. All rights reserved.
//

#import "InvoicePDFBuilder.h"
#import "TransactionItem.h"
@interface InvoicePDFBuilder()
{
    CGSize invoicePageSize;
}
@end

@implementation InvoicePDFBuilder

-(void)buildInvoicePDF:(NSString*)filePath PDFPageSize:(CGSize)pageSize
{
    invoicePageSize = pageSize;
    UIGraphicsBeginPDFContextToFile(filePath, CGRectZero, nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0,0, invoicePageSize.width, invoicePageSize.height),nil);
    [self drawBackgroundWithX:39 andY:149 andWidth:524 andHeight:25];
    [self drawStaticPart];
    [self drawDynamicPart];
    [self addRecord];
    UIGraphicsEndPDFContext();
}


-(void)drawText:(NSString*)text inRect:(CGRect)textRect withStyle:(NSString*)textStyle andSize:(CGFloat)textSize
{
    [text drawInRect:textRect withAttributes:@{NSFontAttributeName: [self getFontWithSize:textSize], NSParagraphStyleAttributeName:[self getParagraphStyle:textStyle]}];
}

-(void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.5);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor]CGColor]);
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    CGContextStrokePath(context);
}

-(void)drawBackgroundWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(x, y, width, height);
    CGContextSetFillColorWithColor(context, [[UIColor lightGrayColor]CGColor]);
    CGContextFillRect(context, rect);
}

-(void)drawStaticPart
{
    [self drawText:@"Smart Transaction Prototype" inRect:CGRectMake(40, 30, invoicePageSize.width, invoicePageSize.height) withStyle:@"alignLeft" andSize:18];
    
    NSLog(@"%@", _transaction);
    [self drawText:[[NSString alloc]initWithFormat:@"Invoice No : %d",[_transaction tranId]] inRect:CGRectMake(435, 55, invoicePageSize.width, invoicePageSize.height) withStyle:@"alignLeft" andSize:13];
    [self drawText:[[NSString alloc]initWithFormat:@"Date : %@",[_transaction dateTime]] inRect:CGRectMake(435, 85, invoicePageSize.width, invoicePageSize.height) withStyle:@"alignLeft" andSize:13];
//    [self drawText:[[NSString alloc]initWithFormat:@"Customer ID : %@",[self.invoiceData objectForKey:@"customerID"]] inRect:CGRectMake(435, 115, invoicePageSize.width, invoicePageSize.height) withStyle:@"alignLeft" andSize:13];
    
    [self drawText:@"Product" inRect:CGRectMake(180, 155, invoicePageSize.width, invoicePageSize.height) withStyle:@"alignLeft" andSize:13];
    [self drawText:@"Quanity" inRect:CGRectMake(397, 155, invoicePageSize.width, invoicePageSize.height) withStyle:@"alignLeft" andSize:13];
    [self drawText:@"Amount" inRect:CGRectMake(492, 155, invoicePageSize.width, invoicePageSize.height) withStyle:@"alignLeft" andSize:13];
    
    [self drawLineFromPoint:CGPointMake(40, 150) toPoint:CGPointMake(562, 150)];
    [self drawLineFromPoint:CGPointMake(40, 175) toPoint:CGPointMake(562, 175)];
}

-(void)drawDynamicPart
{
    int numberOfRecord = [_transaction transactionItemsCount]+ 1;
    CGFloat initHeightPerRecord = 30;
    
    [self drawLineFromPoint:CGPointMake(40, 150) toPoint:CGPointMake(40, initHeightPerRecord*numberOfRecord+150)];
    [self drawLineFromPoint:CGPointMake(370, 150) toPoint:CGPointMake(370, initHeightPerRecord*numberOfRecord+150)];
    [self drawLineFromPoint:CGPointMake(470, 150) toPoint:CGPointMake(470, initHeightPerRecord*numberOfRecord+150)];
    [self drawLineFromPoint:CGPointMake(562, 150) toPoint:CGPointMake(562, initHeightPerRecord*numberOfRecord+150)];
    [self drawLineFromPoint:CGPointMake(40, initHeightPerRecord*numberOfRecord+150) toPoint:CGPointMake(562, initHeightPerRecord*numberOfRecord+150)];
    
    
    [self drawText:[[NSString alloc]initWithFormat:@"Totle Due"] inRect:CGRectMake(395, initHeightPerRecord*numberOfRecord+158, invoicePageSize.width, invoicePageSize.height) withStyle:@"alignLeft" andSize:13];
    
    [self drawText:[[NSString alloc]initWithFormat:@"$%.1f",[_transaction amount]] inRect:CGRectMake(495, initHeightPerRecord*numberOfRecord+158, invoicePageSize.width, invoicePageSize.height) withStyle:@"alignLeft" andSize:13];
    
    [self drawLineFromPoint:CGPointMake(470, initHeightPerRecord*numberOfRecord+150) toPoint:CGPointMake(470, initHeightPerRecord*numberOfRecord+180)];
    [self drawLineFromPoint:CGPointMake(562, initHeightPerRecord*numberOfRecord+150) toPoint:CGPointMake(562, initHeightPerRecord*numberOfRecord+180)];
    [self drawLineFromPoint:CGPointMake(470, initHeightPerRecord*numberOfRecord+180) toPoint:CGPointMake(562, initHeightPerRecord*numberOfRecord+180)];
}


-(NSMutableParagraphStyle*)getParagraphStyle:(NSString*)style
{
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle]mutableCopy];
    if([@"alignLeft"isEqualToString:style])
    {
        [paragraphStyle setAlignment:NSTextAlignmentLeft];
    }else if([@"alignRight" isEqualToString:style])
    {
        [paragraphStyle setAlignment:NSTextAlignmentRight];
    }else{
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
    }
    return paragraphStyle;
}



-(void)addRecord
{
    int initPosition = 30 ;
    for(TransactionItem* orderLine in [self.transaction transactionItems])
    {
        [self drawText:[orderLine productName] inRect:CGRectMake(180, 155+initPosition, invoicePageSize.width, invoicePageSize.height) withStyle:@"alignLeft" andSize:13];
        [self drawText:[NSString stringWithFormat:@"%d",[orderLine quantity]] inRect:CGRectMake(397, 155+initPosition, invoicePageSize.width, invoicePageSize.height) withStyle:@"alignLeft" andSize:13];
        [self drawText:[NSString stringWithFormat:@"$%.1f",[orderLine price]] inRect:CGRectMake(492, 155+initPosition, invoicePageSize.width, invoicePageSize.height) withStyle:@"alignLeft" andSize:13];
        initPosition+=30;
    }
}

-(UIFont*)getFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
    
}

//-(NSArray*)purchase
//{
//    if(!_purchase)
//    {
//        NSArray* temp = @[
//                          @[@"PAPER",@"100",@"$1000"],
//                          @[@"CANDY",@"3",@"$50"],
//                          @[@"BEARD",@"4",@"$20"],
//                          @[@"PAPER",@"100",@"$1000"],
//                          @[@"CANDY",@"3",@"$50"],
//                          @[@"BEARD",@"4",@"$20"],
//                          @[@"PAPER",@"100",@"$1000"]
//                          ];
//        _purchase = [[NSArray alloc]initWithArray:temp];
//    }
//    return _purchase;
//}
//
//-(NSDictionary*)invoiceData
//{
//
//    if(!_invoiceData) _invoiceData = [[NSDictionary alloc]initWithObjectsAndKeys:
//                                      @"123456", @"customerID",
//                                      @"033589", @"invoiceID",
//                                      [NSDate date], @"date",
//                                      self.purchase,@"purchaseItem",
//                                      @"$8600",@"totalAmount"
//                                      ,nil];
//    return _invoiceData;
//}

@end
