//
//  InvoiceDetailViewController.m
//  Smart Transaction
//
//  Created by TszTung Cheng on 18/12/13.
//  Copyright (c) 2013 1314-114102-02. All rights reserved.
//

#import "InvoiceDetailViewController.h"
#import "InvoicePDF.h"
#import "PDFScrollView.h"

@interface InvoiceDetailViewController ()

@property (weak, nonatomic) IBOutlet PDFScrollView *invoiceScrollView;


@end

@implementation InvoiceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [InvoicePDF generateInvoicePDF:@"" withTransaction:_transaction];

    NSString* fileName = @"Invoice.PDF";
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    NSURL *url = [NSURL fileURLWithPath:pdfFileName];
    
    CGPDFDocumentRef PDFDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)url);
    CGPDFPageRef PDFPage = CGPDFDocumentGetPage(PDFDocument, 1);
    [(PDFScrollView *)self.invoiceScrollView setPDFPage:PDFPage];
    CGPDFDocumentRelease(PDFDocument);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
